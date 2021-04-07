module Update exposing (update)

import ApplicationState
import AudioPlayer
import ControlPanel exposing (ControlPanel)
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import SecretConfig
import Tag exposing (Tag)
import VideoPlayer


type alias Msgs msgs =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> Msg
        , pauseMsg : Msg
        , portsMsg : Ports.Msg -> Msg
        , secretConfigMsg : SecretConfig.Msg -> Msg
        , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


update : Msgs msgs -> Msg -> Model -> ( Model, Cmd Msg )
update parentMsgs msg model =
    case msg of
        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    AudioPlayer.update
                        parentMsgs
                        msgForAudioPlayer
                        model.audioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.ControlPanel msgForControlPanel ->
            let
                controlPanel : ControlPanel
                controlPanel =
                    ControlPanel.update msgForControlPanel model.controlPanel
            in
            ( { model | controlPanel = controlPanel }, Cmd.none )

        Msg.CrossFadePlayers _ ->
            let
                ( crossFadedVideoPlayer1, crossFadedVideoPlayer2, nowHiddenVideoPlayerId ) =
                    VideoPlayer.crossFade model.videoPlayer1 model.videoPlayer2

                randomTagGeneratedMsg : Tag -> Msg
                randomTagGeneratedMsg =
                    SecretConfig.randomTagGeneratedMsg
                        Msg.SecretConfig
                        nowHiddenVideoPlayerId

                generateRandomTagForHiddenVideoPlayer : Cmd Msg
                generateRandomTagForHiddenVideoPlayer =
                    Tag.generateRandomTag randomTagGeneratedMsg model.secretConfig.tags
            in
            ( { model
                | videoPlayer1 = crossFadedVideoPlayer1
                , videoPlayer2 = crossFadedVideoPlayer2
              }
            , generateRandomTagForHiddenVideoPlayer
            )

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
                    Ports.performPause Msg.Ports
            in
            ( model, pauseMedia )

        Msg.Ports msgForPorts ->
            ( model, Ports.cmd msgForPorts )

        Msg.SecretConfig msgForSecretConfig ->
            let
                ( secretConfig, cmd ) =
                    SecretConfig.update
                        parentMsgs
                        msgForSecretConfig
                        model.secretConfig
            in
            ( { model | secretConfig = secretConfig }, cmd )

        Msg.ShowApplicationState ->
            ( model, ApplicationState.show model )

        Msg.VideoPlayer msgForVideoPlayer ->
            let
                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update msgForVideoPlayer model
            in
            ( { model
                | videoPlayer1 = videoPlayer1
                , videoPlayer2 = videoPlayer2
              }
            , cmd
            )
