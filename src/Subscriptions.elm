module Subscriptions exposing (subscriptions)

import ControlPanel
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import VideoPlayer


subscriptions : MsgRouter msg -> Model -> Sub msg
subscriptions msgRouter { controlPanel, secretConfig, videoPlayer1 } =
    Sub.batch
        [ VideoPlayer.subscriptions
            msgRouter
            secretConfig.fetchNextGif
            videoPlayer1
        , ControlPanel.subscriptions
            msgRouter
            secretConfig.overrideInactivityPause
            controlPanel
        ]
