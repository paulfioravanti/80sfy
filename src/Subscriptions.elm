module Subscriptions exposing (subscriptions)

import AudioPlayer
import ControlPanel
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
        , VideoPlayer.subscriptions
            msgRouter
            model.secretConfig.fetchNextGif
            model.videoPlayer1
        ]
