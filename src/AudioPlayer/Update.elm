module AudioPlayer.Update exposing (update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg
    exposing
        ( Msg
            ( AdjustVolume
            , AudioPaused
            , AudioPlaying
            , GeneratePlaylistTrackOrder
            , NextTrack
            , NextTrackNumberRequested
            , PauseAudio
            , PlayAudio
            , ReInitAudioPlayer
            , SetPlaylistLength
            , ToggleMute
            )
        )
import AudioPlayer.Ports as Ports
import AudioPlayer.Utils as Utils
import MsgRouter exposing (MsgRouter)
import Task
import VideoPlayer


update : MsgRouter msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msgRouter msg audioPlayer =
    case msg of
        AdjustVolume sliderVolume ->
            let
                maxVolume =
                    100

                minVolume =
                    0

                containVolume volume =
                    if volume < minVolume then
                        minVolume
                    else if volume > maxVolume then
                        maxVolume
                    else
                        volume

                volume =
                    sliderVolume
                        |> String.toInt
                        |> Result.withDefault audioPlayer.volume
                        |> containVolume
            in
                ( { audioPlayer | muted = False, volume = volume }
                , Ports.setVolume volume
                )

        AudioPaused ->
            ( { audioPlayer | playing = False }, Cmd.none )

        AudioPlaying ->
            ( { audioPlayer | playing = True }, Cmd.none )

        GeneratePlaylistTrackOrder playlistTrackOrder ->
            ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
            , msgRouter.audioPlayerMsg NextTrackNumberRequested
                |> Task.succeed
                |> Task.perform identity
            )

        NextTrack ->
            let
                requestNextTrack =
                    msgRouter.audioPlayerMsg NextTrackNumberRequested
                        |> Task.succeed
                        |> Task.perform identity

                playVideos =
                    msgRouter.videoPlayerMsg VideoPlayer.playVideosMsg
                        |> Task.succeed
                        |> Task.perform identity
            in
                ( { audioPlayer | playing = True }
                , Cmd.batch [ requestNextTrack, playVideos ]
                )

        NextTrackNumberRequested ->
            let
                ( playlistTrackOrder, cmd ) =
                    case audioPlayer.playlistTrackOrder of
                        head :: tail ->
                            ( tail, Ports.skipToTrack head )

                        [] ->
                            ( []
                            , Utils.generatePlaylistTrackOrder
                                msgRouter.audioPlayerMsg
                                audioPlayer.playlistLength
                            )
            in
                ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
                , cmd
                )

        PauseAudio ->
            ( audioPlayer, Ports.pauseAudio () )

        PlayAudio ->
            ( audioPlayer, Ports.playAudio () )

        ReInitAudioPlayer soundCloudPlaylistUrl ->
            ( Model.init soundCloudPlaylistUrl
            , Ports.initAudioPlayer audioPlayer.volume
            )

        SetPlaylistLength playlistLength ->
            ( { audioPlayer | playlistLength = playlistLength }
            , Utils.generatePlaylistTrackOrder
                msgRouter.audioPlayerMsg
                playlistLength
            )

        ToggleMute ->
            let
                cmd =
                    if audioPlayer.muted then
                        Ports.setVolume audioPlayer.volume
                    else
                        Ports.setVolume 0
            in
                ( { audioPlayer | muted = not audioPlayer.muted }, cmd )
