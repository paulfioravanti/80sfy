module Update exposing (update)

import AudioPlayer
import Config
import ControlPanel
import Debug
import Gif
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , CrossFadePlayers
            , SecretConfigMsg
            , VideoPlayerMsg
            )
        )
import MsgConfig
import SecretConfig
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        msgConfig =
            MsgConfig.init
                AudioPlayerMsg
                ConfigMsg
                ControlPanelMsg
                SecretConfigMsg
                VideoPlayerMsg
    in
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

            CrossFadePlayers time ->
                let
                    ( newVideoPlayer1Visibility, nowHiddenVideoPlayerId ) =
                        model.videoPlayer1
                            |> VideoPlayer.newVisibility

                    videoPlayer1 =
                        model.videoPlayer1
                            |> VideoPlayer.updateVisibility
                                newVideoPlayer1Visibility
                in
                    ( { model | videoPlayer1 = videoPlayer1 }
                    , Gif.random
                        msgConfig
                        model.config.tags
                        nowHiddenVideoPlayerId
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
                    ( videoPlayer1, videoPlayer2, cmd ) =
                        VideoPlayer.update
                            msg
                            model.videoPlayer1
                            model.videoPlayer2
                in
                    ( { model
                        | videoPlayer1 = videoPlayer1
                        , videoPlayer2 = videoPlayer2
                      }
                    , Cmd.map VideoPlayerMsg cmd
                    )
