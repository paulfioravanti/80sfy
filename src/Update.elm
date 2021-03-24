module Update exposing (update)

import ApplicationState
import AudioPlayer
import Config
import ControlPanel exposing (ControlPanel)
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import SecretConfig exposing (SecretConfig)
import Tag exposing (Tag)
import Tasks
import VideoPlayer exposing (VideoPlayerId)


type alias ParentMsgs msgs =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> Msg
        , configMsg : Config.Msg -> Msg
        , pauseMsg : Msg
        , playMsg : Msg
        , portsMsg : Ports.Msg -> Msg
        , secretConfigMsg : SecretConfig.Msg -> Msg
        , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


update : ParentMsgs msgs -> Msg -> Model -> ( Model, Cmd Msg )
update parentMsgs msg model =
    case msg of
        Msg.AudioPaused ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update
                        parentMsgs
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
                        parentMsgs
                        msgForAudioPlayer
                        model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.AudioPlaying ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update
                        parentMsgs
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
                controlPanel : ControlPanel
                controlPanel =
                    ControlPanel.update msgForControlPanel model.controlPanel
            in
            ( { model | controlPanel = controlPanel }, Cmd.none )

        Msg.KeyPressed code ->
            let
                cmd : Cmd Msg
                cmd =
                    Key.pressed parentMsgs model code
            in
            ( model, cmd )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Pause ->
            let
                pauseMedia : Cmd Msg
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
                performSaveConfig : Cmd Msg
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
                secretConfig : SecretConfig
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
                randomTagGeneratedMsg : VideoPlayerId -> Tag -> Msg
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
