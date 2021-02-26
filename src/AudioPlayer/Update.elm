module AudioPlayer.Update exposing (Msgs, update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Ports as Ports
import AudioPlayer.Status as Status
import AudioPlayer.Task as Task
import AudioPlayer.Volume as Volume
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

        Msg.PlaylistGenerated playlist ->
            let
                requestNextTrackNumber =
                    Task.requestNextTrackNumber audioPlayerMsg
            in
            ( { audioPlayer | playlist = playlist }
            , requestNextTrackNumber
            )

        Msg.NextTrack ->
            let
                requestNextTrackNumber =
                    Task.requestNextTrackNumber audioPlayerMsg

                playVideos =
                    VideoPlayer.playVideos videoPlayerMsg

                status =
                    Status.play audioPlayer.status
            in
            ( { audioPlayer | status = status }
            , Cmd.batch [ requestNextTrackNumber, playVideos ]
            )

        Msg.NextTrackNumberRequested ->
            let
                ( playlist, cmd ) =
                    case audioPlayer.playlist of
                        head :: tail ->
                            ( tail, Ports.skipToTrack head )

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

        Msg.ReInitAudioPlayer soundCloudPlaylistUrl ->
            let
                initAudioPlayerFlags =
                    { id = Model.rawId audioPlayer.id
                    , volume = Volume.rawVolume audioPlayer.volume
                    }
            in
            ( Model.init soundCloudPlaylistUrl
            , Ports.initAudioPlayer initAudioPlayerFlags
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
