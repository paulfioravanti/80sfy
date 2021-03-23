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
                    Tasks.performPause Msg.Ports
            in
            ( model, pauseMedia )

        Msg.Play ->
            ( model, Cmd.batch [ Ports.playVideos, Ports.playAudio ] )

        Msg.Ports msgForPorts ->
            ( model, Ports.cmd msgForPorts )

        Msg.SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                performSaveConfig =
                    Config.performSave
                        Msg.Config
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
                -- NOTE: Neither VideoPlayer.Update nor Tag can import the
                -- Config module due to forming an import cycle, so this
                -- message has to be generated here, even though it's only used
                -- in one branch of the `update` function.
                randomTagGeneratedMsg =
                    Config.randomTagGeneratedMsg Msg.Config

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
