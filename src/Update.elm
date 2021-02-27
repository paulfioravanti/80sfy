module Update exposing (update)

import ApplicationState
import AudioPlayer
import BrowserVendor
import Config
import ControlPanel
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import SecretConfig
import Tag
import Tasks
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        msgs =
            { audioPlayerMsg = Msg.audioPlayer
            , browserVendorMsg = Msg.browserVendor
            , generateRandomTagMsg = Msg.generateRandomTag
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

        Msg.GenerateRandomTag videoPlayerId ->
            let
                randomTagGeneratedMsg =
                    Config.randomTagGeneratedMsg Msg.config videoPlayerId

                cmd =
                    Tag.generateRandomTag
                        randomTagGeneratedMsg
                        model.config.tags
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
                    Tasks.performPause
                        (AudioPlayer.pauseAudioMsg Msg.audioPlayer)
                        (VideoPlayer.pauseVideosMsg Msg.videoPlayer)
            in
            ( model, pauseMedia )

        Msg.Play ->
            let
                performPlayAudio =
                    AudioPlayer.performPlayAudio Msg.audioPlayer

                performPlayVideos =
                    VideoPlayer.performPlayVideos Msg.videoPlayer
            in
            ( model, Cmd.batch [ performPlayVideos, performPlayAudio ] )

        Msg.SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                performSaveConfig =
                    Config.performSave
                        Msg.config
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplaySecondsString
            in
            ( model, performSaveConfig )

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
                        Msg.generateRandomTag
                        msgForVideoPlayer
                        model
            in
            ( { model
                | videoPlayer1 = videoPlayer1
                , videoPlayer2 = videoPlayer2
              }
            , cmd
            )
