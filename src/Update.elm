module Update exposing (update)

import ApplicationState
import AudioPlayer
import BrowserVendor
import Config
import ControlPanel
import Gif
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import SecretConfig
import Task_
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        msgs =
            { audioPlayerMsg = Msg.AudioPlayer
            , browserVendorMsg = Msg.BrowserVendor
            , generateRandomGifMsg = Msg.GenerateRandomGif
            , pauseMsg = Msg.Pause
            , playMsg = Msg.Play
            , secretConfigMsg = Msg.SecretConfig
            , videoPlayerMsg = Msg.VideoPlayer
            }
    in
    case msg of
        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msgs msgForAudioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.Config msgForConfig ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgs msgForConfig
            in
            ( { model | config = config }, cmd )

        Msg.ControlPanel msgForControlPanel ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgForControlPanel
            in
            ( { model | controlPanel = controlPanel }
            , Cmd.map Msg.ControlPanel cmd
            )

        Msg.BrowserVendor browserVendorMsg ->
            let
                cmd =
                    model.browserVendor
                        |> BrowserVendor.cmd browserVendorMsg
            in
            ( model, cmd )

        Msg.GenerateRandomGif videoPlayerId ->
            let
                randomTagGeneratedMsg =
                    Config.randomTagGeneratedMsg Msg.Config videoPlayerId

                cmd =
                    model.config.tags
                        |> Gif.random randomTagGeneratedMsg
            in
            ( model, cmd )

        Msg.KeyPressed code ->
            let
                cmd =
                    code
                        |> Key.pressed msgs model
            in
            ( model, cmd )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Pause ->
            let
                pauseMedia =
                    Task_.pauseMedia Msg.AudioPlayer Msg.VideoPlayer
            in
            ( model, pauseMedia )

        Msg.Play ->
            let
                playAudio =
                    AudioPlayer.playAudio Msg.AudioPlayer

                playVideos =
                    VideoPlayer.playVideos Msg.VideoPlayer
            in
            ( model, Cmd.batch [ playVideos, playAudio ] )

        Msg.SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                saveConfig =
                    Config.save
                        Msg.Config
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplaySecondsString
            in
            ( model, saveConfig )

        Msg.SecretConfig msgForSecretConfig ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.update msgForSecretConfig
            in
            ( { model | secretConfig = secretConfig }, Cmd.none )

        Msg.ShowApplicationState ->
            ( model, ApplicationState.show model )

        Msg.VideoPlayer msgForVideoPlayer ->
            let
                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        Msg.GenerateRandomGif
                        msgForVideoPlayer
                        model
            in
            ( { model
                | videoPlayer1 = videoPlayer1
                , videoPlayer2 = videoPlayer2
              }
            , cmd
            )
