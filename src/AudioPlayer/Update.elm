module AudioPlayer.Update exposing (Msgs, update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Ports as Ports
import AudioPlayer.Status as Status
import AudioPlayer.Task as Task
import AudioPlayer.Volume as Volume
import SoundCloud
import VideoPlayer


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : Msgs msgs msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update { audioPlayerMsg, videoPlayerMsg } msg audioPlayer =
    case msg of
        Msg.AdjustVolume sliderVolume ->
            let
                volume =
                    Volume.setWithDefault audioPlayer.volume sliderVolume

                cmd =
                    if Status.isMuted audioPlayer.status then
                        Cmd.none

                    else
                        Ports.setVolume (Volume.rawVolume volume)
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

        Msg.PlaylistGenerated rawPlaylist ->
            let
                performNextTrackNumberRequest =
                    Task.performNextTrackNumberRequest audioPlayerMsg

                playlist =
                    List.map Model.trackIndex rawPlaylist
            in
            ( { audioPlayer | playlist = playlist }
            , performNextTrackNumberRequest
            )

        Msg.NextTrack ->
            let
                performNextTrackNumberRequest =
                    Task.performNextTrackNumberRequest audioPlayerMsg

                performPlayVideos =
                    VideoPlayer.performPlayVideos videoPlayerMsg

                status =
                    Status.play audioPlayer.status
            in
            ( { audioPlayer | status = status }
            , Cmd.batch [ performNextTrackNumberRequest, performPlayVideos ]
            )

        Msg.NextTrackNumberRequested ->
            let
                ( playlist, cmd ) =
                    case audioPlayer.playlist of
                        head :: tail ->
                            let
                                trackNumber =
                                    Model.rawTrackIndex head
                            in
                            ( tail, Ports.skipToTrack trackNumber )

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

        Msg.PauseAudio ->
            ( audioPlayer, Ports.pauseAudio () )

        Msg.PlayAudio ->
            ( audioPlayer, Ports.playAudio () )

        Msg.ResetAudioPlayer soundCloudPlaylistUrl ->
            let
                soundCloudWidgetFlags =
                    { id = Model.rawId audioPlayer.id
                    , volume = Volume.rawVolume audioPlayer.volume
                    }
            in
            ( Model.init soundCloudPlaylistUrl
            , SoundCloud.initWidget soundCloudWidgetFlags
            )

        Msg.SetPlaylistLength playlistLength ->
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
                        ( Status.unMute currentStatus
                        , Ports.setVolume (Volume.rawVolume audioPlayer.volume)
                        )

                    else
                        ( Status.mute currentStatus
                        , Ports.setVolume 0
                        )
            in
            ( { audioPlayer | status = newStatus }, cmd )
