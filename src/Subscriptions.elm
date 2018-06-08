module Subscriptions exposing (subscriptions)

import Animation
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
import VideoPlayer


subscriptions : MsgConfig msg -> Model -> Sub msg
subscriptions msgConfig { controlPanel, secretConfig, videoPlayer1 } =
    Sub.batch
        [ VideoPlayer.subscriptions
            msgConfig
            secretConfig.fetchNextGif
            videoPlayer1
        , ControlPanel.subscriptions
            msgConfig
            secretConfig.overrideInactivityPause
            controlPanel
        ]
