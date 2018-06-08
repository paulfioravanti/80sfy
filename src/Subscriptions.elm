module Subscriptions exposing (subscriptions)

import ControlPanel
import Model exposing (Model)
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
