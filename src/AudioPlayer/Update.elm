module AudioPlayer.Update exposing (ParentMsgs, update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Status as Status
import AudioPlayer.Volume as Volume
import Ports
import VideoPlayer


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update { audioPlayerMsg } msg audioPlayer =
    case msg of
        Msg.AdjustVolume sliderVolume ->
            let
                volume =
                    Volume.setWithDefault audioPlayer.volume sliderVolume

                cmd =
                    if Status.isMuted audioPlayer.status then
                        Cmd.none

                    else
                        let
                            rawVolume =
                                Volume.rawVolume volume
                        in
                        Ports.setVolume rawVolume
            in
            ( { audioPlayer | volume = volume }, cmd )

        Msg.AudioPaused ->
            let
                status =
                    Status.pause audioPlayer.status
            in
            ( { audioPlayer | status = status }, Cmd.none )

        Msg.AudioPlaying ->
            let
                status =
                    Status.play audioPlayer.status
            in
            ( { audioPlayer | status = status }, Cmd.none )

        Msg.NextTrack ->
            let
                ( playlist, cmd ) =
                    Playlist.handleNextTrackNumberRequest
                        audioPlayerMsg
                        audioPlayer.playlist
                        audioPlayer.playlistLength
            in
            ( { audioPlayer | playlist = playlist }
            , Cmd.batch [ cmd, Ports.playVideos ]
            )

        Msg.NextTrackNumberRequested ->
            let
                ( playlist, cmd ) =
                    Playlist.handleNextTrackNumberRequest
                        audioPlayerMsg
                        audioPlayer.playlist
                        audioPlayer.playlistLength
            in
            ( { audioPlayer | playlist = playlist }, cmd )

        Msg.PlaylistGenerated rawPlaylist ->
            let
                wrappedPlaylist =
                    List.map Playlist.trackIndex rawPlaylist

                ( playlist, cmd ) =
                    Playlist.handleNextTrackNumberRequest
                        audioPlayerMsg
                        wrappedPlaylist
                        audioPlayer.playlistLength
            in
            ( { audioPlayer | playlist = playlist }, cmd )

        Msg.PlaylistLengthFetched playlistLength ->
            let
                generatePlaylist =
                    Playlist.generate audioPlayerMsg playlistLength
            in
            ( { audioPlayer | playlistLength = playlistLength }
            , generatePlaylist
            )

        Msg.ResetAudioPlayer soundCloudPlaylistUrl ->
            let
                widgetPayload =
                    Model.soundCloudWidgetPayload audioPlayer
            in
            ( Model.init soundCloudPlaylistUrl
            , Ports.initSoundCloudWidget widgetPayload
            )

        Msg.ToggleMute ->
            let
                currentStatus =
                    audioPlayer.status

                ( newStatus, cmd ) =
                    if Status.isMuted currentStatus then
                        let
                            volume =
                                Volume.rawVolume audioPlayer.volume
                        in
                        ( Status.unMute currentStatus
                        , Ports.setVolume volume
                        )

                    else
                        ( Status.mute currentStatus
                        , Ports.setVolume 0
                        )
            in
            ( { audioPlayer | status = newStatus }, cmd )
