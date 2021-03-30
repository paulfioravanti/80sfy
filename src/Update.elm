module Update exposing (update)

import ApplicationState
import AudioPlayer
import Config
import ControlPanel exposing (ControlPanel)
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import Tag exposing (Tag)
import Tasks
import VideoPlayer


type alias Msgs msgs =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> Msg
        , configMsg : Config.Msg -> Msg
        , pauseMsg : Msg
        , playMsg : Msg
        , portsMsg : Ports.Msg -> Msg
        , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


update : Msgs msgs -> Msg -> Model -> ( Model, Cmd Msg )
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

        Msg.Config msgForSecretConfig ->
            let
                ( config, cmd ) =
                    Config.update
                        parentMsgs
                        msgForSecretConfig
                        model.config
            in
            ( { model | config = config }, cmd )

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
                    Config.randomTagGeneratedMsg
                        Msg.Config
                        nowHiddenVideoPlayerId

                generateRandomTagForHiddenVideoPlayer : Cmd Msg
                generateRandomTagForHiddenVideoPlayer =
                    Tag.generateRandomTag randomTagGeneratedMsg model.config.tags
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
                    Tasks.performPause Msg.Ports
            in
            ( model, pauseMedia )

        Msg.Play ->
            ( model, Cmd.batch [ Ports.playVideos, Ports.playAudio ] )

        Msg.Ports msgForPorts ->
            ( model, Ports.cmd msgForPorts )

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
