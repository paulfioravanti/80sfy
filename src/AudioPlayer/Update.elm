module AudioPlayer.Update exposing (Msgs, update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Status as Status
import AudioPlayer.Task as Task
import AudioPlayer.Volume as Volume
import Port
import VideoPlayer


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : Msgs msgs msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
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
                        Port.setVolume (Volume.rawVolume volume)
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
                performNextTrackNumberRequest =
                    Task.performNextTrackNumberRequest audioPlayerMsg

                playVideos =
                    Port.cmd Port.playVideosMsg

                status =
                    Status.play audioPlayer.status
            in
            ( { audioPlayer | status = status }
            , Cmd.batch [ performNextTrackNumberRequest, playVideos ]
            )

        Msg.NextTrackNumberRequested ->
            let
                ( playlist, cmd ) =
                    case audioPlayer.playlist of
                        head :: tail ->
                            let
                                trackNumber =
                                    Playlist.rawTrackIndex head
                            in
                            ( tail, Port.skipToTrack trackNumber )

                        [] ->
                            ( []
                            , Playlist.generate
                                audioPlayerMsg
                                audioPlayer.playlistLength
                            )
            in
            ( { audioPlayer | playlist = playlist }
            , cmd
            )

        Msg.PlaylistGenerated rawPlaylist ->
            let
                performNextTrackNumberRequest =
                    Task.performNextTrackNumberRequest audioPlayerMsg

                playlist =
                    List.map Playlist.trackIndex rawPlaylist
            in
            ( { audioPlayer | playlist = playlist }
            , performNextTrackNumberRequest
            )

        Msg.ResetAudioPlayer soundCloudPlaylistUrl ->
            let
                widgetPayload =
                    Model.soundCloudWidgetPayload audioPlayer

                initSoundCloudWidget =
                    Port.initSoundCloudWidgetMsg widgetPayload
            in
            ( Model.init soundCloudPlaylistUrl
            , Port.cmd initSoundCloudWidget
            )

        Msg.PlaylistLengthFetched playlistLength ->
            let
                generatePlaylist =
                    Playlist.generate audioPlayerMsg playlistLength
            in
            ( { audioPlayer | playlistLength = playlistLength }
            , generatePlaylist
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
                        , Port.setVolume volume
                        )

                    else
                        ( Status.mute currentStatus
                        , Port.setVolume 0
                        )
            in
            ( { audioPlayer | status = newStatus }, cmd )
