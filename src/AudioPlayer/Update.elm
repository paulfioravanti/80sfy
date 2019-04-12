module AudioPlayer.Update exposing (update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Ports as Ports
import AudioPlayer.Status as Status
import AudioPlayer.Volume as Volume
import Task
import VideoPlayer


update :
    (Msg -> msg)
    -> (VideoPlayer.Msg -> msg)
    -> Msg
    -> AudioPlayer
    -> ( AudioPlayer, Cmd msg )
update audioPlayerMsg videoPlayerMsg msg audioPlayer =
    case msg of
        Msg.AdjustVolume sliderVolume ->
            let
                volume =
                    sliderVolume
                        |> String.toInt
                        |> Maybe.withDefault audioPlayer.volume
                        |> Volume.contain

                cmd =
                    if Status.isMuted audioPlayer.status then
                        Cmd.none

                    else
                        Ports.setVolume volume
            in
            ( { audioPlayer | volume = volume }, cmd )

        Msg.AudioPaused ->
            let
                status =
                    if Status.isMuted audioPlayer.status then
                        Status.Muted Status.Paused

                    else
                        Status.Paused
            in
            ( { audioPlayer | status = status }, Cmd.none )

        Msg.AudioPlaying ->
            let
                status =
                    if Status.isMuted audioPlayer.status then
                        Status.Muted Status.Playing

                    else
                        Status.Playing
            in
            ( { audioPlayer | status = status }, Cmd.none )

        Msg.GeneratePlaylist playlist ->
            let
                requestNextTrack =
                    nextTrackNumberRequested audioPlayerMsg
            in
            ( { audioPlayer | playlist = playlist }
            , requestNextTrack
            )

        Msg.NextTrack ->
            let
                requestNextTrack =
                    nextTrackNumberRequested audioPlayerMsg

                playVideos =
                    videoPlayerMsg VideoPlayer.playVideosMsg
                        |> Task.succeed
                        |> Task.perform identity

                status =
                    if Status.isMuted audioPlayer.status then
                        Status.Muted Status.Playing

                    else
                        Status.Playing
            in
            ( { audioPlayer | status = status }
            , Cmd.batch [ requestNextTrack, playVideos ]
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
                    { id = audioPlayer.id
                    , volume = audioPlayer.volume
                    }
            in
            ( Model.init soundCloudPlaylistUrl
            , Ports.initAudioPlayer initAudioPlayerFlags
            )

        Msg.SetPlaylistLength playlistLength ->
            let
                generatePlaylist =
                    playlistLength
                        |> Playlist.generate audioPlayerMsg
            in
            ( { audioPlayer | playlistLength = playlistLength }
            , generatePlaylist
            )

        Msg.ToggleMute ->
            let
                ( cmd, newStatus ) =
                    case audioPlayer.status of
                        Status.Muted status ->
                            ( Ports.setVolume audioPlayer.volume, status )

                        status ->
                            ( Ports.setVolume 0, Status.Muted status )
            in
            ( { audioPlayer | status = newStatus }, cmd )



-- PRIVATE


nextTrackNumberRequested : (Msg -> msg) -> Cmd msg
nextTrackNumberRequested audioPlayerMsg =
    audioPlayerMsg Msg.NextTrackNumberRequested
        |> Task.succeed
        |> Task.perform identity
