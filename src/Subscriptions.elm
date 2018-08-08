module Subscriptions exposing (subscriptions)

import AudioPlayer
import Browser
import ControlPanel
import Keyboard
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import VideoPlayer


subscriptions : MsgRouter msg -> Model -> Sub msg
subscriptions msgRouter model =
    let
        videoPlayerContext =
            { audioPlayerId = model.audioPlayer.id
            , gifDisplaySeconds = model.config.gifDisplaySeconds
            , overrideInactivityPause =
                model.secretConfig.overrideInactivityPause
            }
    in
        Sub.batch
            [ AudioPlayer.subscriptions
                msgRouter
                model.audioPlayer
            , Browser.subscriptions msgRouter
            , ControlPanel.subscriptions
                msgRouter
                model.controlPanel
            , Keyboard.downs msgRouter.keyMsg
            , VideoPlayer.subscriptions
                msgRouter
                videoPlayerContext
                model.videoPlayer1
            ]
