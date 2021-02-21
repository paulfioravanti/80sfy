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
            { audioPlayerMsg = Msg.audioPlayer
            , browserVendorMsg = Msg.browserVendor
            , generateRandomGifMsg = Msg.generateRandomGif
            , pauseMsg = Msg.pause
            , playMsg = Msg.play
            , secretConfigMsg = Msg.secretConfig
            , videoPlayerMsg = Msg.videoPlayer
            }
    in
    case msg of
        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update msgs msgForAudioPlayer model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.Config msgForConfig ->
            let
                ( config, cmd ) =
                    Config.update msgs msgForConfig model.config
            in
            ( { model | config = config }, cmd )

        Msg.ControlPanel msgForControlPanel ->
            let
                ( controlPanel, cmd ) =
                    ControlPanel.update msgForControlPanel model.controlPanel
            in
            ( { model | controlPanel = controlPanel }
            , Cmd.map Msg.controlPanel cmd
            )

        Msg.BrowserVendor browserVendorMsg ->
            let
                cmd =
                    BrowserVendor.cmd browserVendorMsg model.browserVendor
            in
            ( model, cmd )

        Msg.GenerateRandomGif videoPlayerId ->
            let
                randomTagGeneratedMsg =
                    Config.randomTagGeneratedMsg Msg.config videoPlayerId

                cmd =
                    Gif.random randomTagGeneratedMsg model.config.tags
            in
            ( model, cmd )

        Msg.KeyPressed code ->
            let
                cmd =
                    Key.pressed msgs model code
            in
            ( model, cmd )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Pause ->
            let
                pauseMedia =
                    Task_.pauseMedia
                        (AudioPlayer.pauseAudioMsg Msg.audioPlayer)
                        (VideoPlayer.pauseVideosMsg Msg.videoPlayer)
            in
            ( model, pauseMedia )

        Msg.Play ->
            let
                playAudio =
                    AudioPlayer.playAudio Msg.audioPlayer

                playVideos =
                    VideoPlayer.playVideos Msg.videoPlayer
            in
            ( model, Cmd.batch [ playVideos, playAudio ] )

        Msg.SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                saveConfig =
                    Config.save
                        Msg.config
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplaySecondsString
            in
            ( model, saveConfig )

        Msg.SecretConfig msgForSecretConfig ->
            let
                secretConfig =
                    SecretConfig.update msgForSecretConfig model.secretConfig
            in
            ( { model | secretConfig = secretConfig }, Cmd.none )

        Msg.ShowApplicationState ->
            ( model, ApplicationState.show model )

        Msg.VideoPlayer msgForVideoPlayer ->
            let
                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        Msg.generateRandomGif
                        msgForVideoPlayer
                        model
            in
            ( { model
                | videoPlayer1 = videoPlayer1
                , videoPlayer2 = videoPlayer2
              }
            , cmd
            )
