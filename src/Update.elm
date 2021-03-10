module Update exposing (update)

import ApplicationState
import AudioPlayer
import Config
import ControlPanel
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import Port
import SecretConfig
import Tasks
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        msgs =
            { audioPlayerMsg = Msg.audioPlayer
            , configMsg = Msg.config
            , controlPanelMsg = Msg.controlPanel
            , pauseMsg = Msg.pause
            , playMsg = Msg.play
            , portMsg = Msg.portMsg
            , secretConfigMsg = Msg.secretConfig
            , videoPlayerMsg = Msg.videoPlayer
            }
    in
    case msg of
        Msg.AudioPaused ->
            let
                performAudioPaused =
                    AudioPlayer.performAudioPaused Msg.audioPlayer

                pauseVideos =
                    Port.cmd Port.pauseVideosMsg
            in
            ( model, Cmd.batch [ pauseVideos, performAudioPaused ] )

        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update msgs msgForAudioPlayer model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.AudioPlaying ->
            let
                performAudioPlaying =
                    AudioPlayer.performAudioPlaying Msg.audioPlayer

                playVideos =
                    Port.cmd Port.playVideosMsg
            in
            ( model, Cmd.batch [ playVideos, performAudioPlaying ] )

        Msg.Config msgForConfig ->
            let
                ( config, cmd ) =
                    Config.update msgs msgForConfig model.config
            in
            ( { model | config = config }, cmd )

        Msg.ControlPanel msgForControlPanel ->
            let
                ( controlPanel, cmd ) =
                    ControlPanel.update msgs msgForControlPanel model.controlPanel
            in
            ( { model | controlPanel = controlPanel }, cmd )

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
                        (Port.pauseAudioPortMsg Msg.portMsg)
                        (Port.pauseVideosPortMsg Msg.portMsg)
            in
            ( model, pauseMedia )

        Msg.Play ->
            let
                playAudio =
                    Port.cmd Port.playAudioMsg

                playVideos =
                    Port.cmd Port.playVideosMsg
            in
            ( model, Cmd.batch [ playVideos, playAudio ] )

        Msg.Port msgForPort ->
            ( model, Port.cmd msgForPort )

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
