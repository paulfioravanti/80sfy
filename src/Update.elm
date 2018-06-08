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
import MsgConfig exposing (MsgConfig)
import SecretConfig
import VideoPlayer


update : MsgConfig msg -> Msg -> Model -> ( Model, Cmd msg )
update msgConfig msg model =
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
                        |> Config.update msgConfig msg
            in
                ( { model | config = config }
                , cmd
                )

        ControlPanelMsg msg ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgConfig msg
            in
                ( { model | controlPanel = controlPanel }
                , cmd
                )

        SecretConfigMsg msg ->
            let
                ( secretConfig, cmd ) =
                    model.secretConfig
                        |> SecretConfig.update msgConfig msg
            in
                ( { model | secretConfig = secretConfig }
                , cmd
                )

        VideoPlayerMsg msg ->
            let
                context =
                    { generateRandomGifMsg =
                        msgConfig.configMsg << Config.generateRandomGifMsg
                    }

                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        msgConfig
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
