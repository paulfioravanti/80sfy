module AudioPlayer.Update exposing (update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Ports as Ports
import AudioPlayer.Utils as Utils
import MsgRouter exposing (MsgRouter)
import Task
import VideoPlayer


update : MsgRouter msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update { audioPlayerMsg, videoPlayerMsg } msg audioPlayer =
    case msg of
        Msg.AdjustVolume sliderVolume ->
            let
                volume =
                    sliderVolume
                        |> String.toInt
                        |> Maybe.withDefault audioPlayer.volume
                        |> containVolume

                cmd =
                    if Model.isMuted audioPlayer then
                        Cmd.none

                    else
                        Ports.setVolume volume
            in
            ( { audioPlayer | volume = volume }, cmd )

        Msg.AudioPaused ->
            let
                status =
                    if Model.isMuted audioPlayer then
                        Model.Muted Model.Paused

                    else
                        Model.Paused
            in
            ( { audioPlayer | status = status }, Cmd.none )

        Msg.AudioPlaying ->
            let
                status =
                    if Model.isMuted audioPlayer then
                        Model.Muted Model.Playing

                    else
                        Model.Playing
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
                    if Model.isMuted audioPlayer then
                        Model.Muted Model.Playing

                    else
                        Model.Playing
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
                            , Utils.generatePlaylist
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
                        |> Utils.generatePlaylist audioPlayerMsg
            in
            ( { audioPlayer | playlistLength = playlistLength }
            , generatePlaylist
            )

        Msg.ToggleMute ->
            let
                ( cmd, newStatus ) =
                    case audioPlayer.status of
                        Model.Muted status ->
                            ( Ports.setVolume audioPlayer.volume, status )

                        status ->
                            ( Ports.setVolume 0, Model.Muted status )
            in
            ( { audioPlayer | status = newStatus }, cmd )


containVolume : Int -> Int
containVolume volume =
    let
        maxVolume =
            100

        minVolume =
            0
    in
    if volume < minVolume then
        minVolume

    else if volume > maxVolume then
        maxVolume

    else
        volume


nextTrackNumberRequested : (Msg.Msg -> msg) -> Cmd msg
nextTrackNumberRequested audioPlayerMsg =
    audioPlayerMsg Msg.NextTrackNumberRequested
        |> Task.succeed
        |> Task.perform identity
