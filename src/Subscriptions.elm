module Subscriptions exposing (subscriptions)

import AudioPlayer
import ControlPanel
import Keyboard
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import VideoPlayer


subscriptions : MsgRouter msg -> Model -> Sub msg
subscriptions msgRouter model =
    Sub.batch
        [ AudioPlayer.subscriptions
            msgRouter
            model.audioPlayer
        , ControlPanel.subscriptions
            msgRouter
            model.secretConfig.overrideInactivityPause
            model.controlPanel
        , Keyboard.downs msgRouter.keyMsg
        , VideoPlayer.subscriptions msgRouter model.videoPlayer1
        ]
