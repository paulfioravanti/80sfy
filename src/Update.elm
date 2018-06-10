module Update exposing (update)

import AudioPlayer
import Config
import ControlPanel
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , SecretConfigMsg
            , VideoPlayerMsg
            )
        )
import MsgRouter exposing (MsgRouter)
import SecretConfig
import VideoPlayer


update : MsgRouter msg -> Msg -> Model -> ( Model, Cmd msg )
update msgRouter msg model =
    case msg of
        AudioPlayerMsg msg ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msg
            in
                ( { model | audioPlayer = audioPlayer }
                , cmd
                )

        ConfigMsg msg ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgRouter msg
            in
                ( { model | config = config }
                , cmd
                )

        ControlPanelMsg msg ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgRouter msg
            in
                ( { model | controlPanel = controlPanel }
                , cmd
                )

        SecretConfigMsg msg ->
            let
                ( secretConfig, cmd ) =
                    model.secretConfig
                        |> SecretConfig.update msgRouter msg
            in
                ( { model | secretConfig = secretConfig }
                , cmd
                )

        VideoPlayerMsg msg ->
            let
                context =
                    { generateRandomGifMsg =
                        msgRouter.configMsg << Config.generateRandomGifMsg
                    }

                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        msgRouter
                        context
                        msg
                        model.videoPlayer1
                        model.videoPlayer2
            in
                ( { model
                    | videoPlayer1 = videoPlayer1
                    , videoPlayer2 = videoPlayer2
                  }
                , cmd
                )
