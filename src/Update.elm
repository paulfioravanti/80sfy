module Update exposing (update)

import ApplicationState
import AudioPlayer
import Config
import ControlPanel
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import SecretConfig
import Tasks
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        parentMsgs =
            { audioPlayerMsg = Msg.AudioPlayer
            , configMsg = Msg.Config
            , controlPanelMsg = Msg.ControlPanel
            , pauseMsg = Msg.Pause
            , playMsg = Msg.Play
            , portsMsg = Msg.Ports
            , secretConfigMsg = Msg.SecretConfig
            , videoPlayerMsg = Msg.VideoPlayer
            }
    in
    case msg of
        Msg.AudioPaused ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update
                        Msg.AudioPlayer
                        AudioPlayer.audioPausedMsg
                        model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }
            , Cmd.batch [ cmd, Ports.pauseVideos ]
            )

        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update
                        Msg.AudioPlayer
                        msgForAudioPlayer
                        model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.AudioPlaying ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update
                        Msg.AudioPlayer
                        AudioPlayer.audioPlayingMsg
                        model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }
            , Cmd.batch [ cmd, Ports.playVideos ]
            )

        Msg.Config msgForConfig ->
            let
                ( config, cmd ) =
                    Config.update parentMsgs msgForConfig model.config
            in
            ( { model | config = config }, cmd )

        Msg.ControlPanel msgForControlPanel ->
            let
                controlPanel =
                    ControlPanel.update msgForControlPanel model.controlPanel
            in
            ( { model | controlPanel = controlPanel }, Cmd.none )

        Msg.KeyPressed code ->
            let
                cmd =
                    Key.pressed parentMsgs model code
            in
            ( model, cmd )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Pause ->
            let
                pauseMedia =
                    Tasks.performPause Msg.ports
            in
            ( model, pauseMedia )

        Msg.Play ->
            ( model, Cmd.batch [ Ports.playVideos, Ports.playAudio ] )

        Msg.Ports msgForPort ->
            ( model, Ports.cmd msgForPort )

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
                randomTagGeneratedMsg =
                    Config.randomTagGeneratedMsg Msg.config

                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        randomTagGeneratedMsg
                        model.config.tags
                        msgForVideoPlayer
                        model
            in
            ( { model
                | videoPlayer1 = videoPlayer1
                , videoPlayer2 = videoPlayer2
              }
            , cmd
            )
