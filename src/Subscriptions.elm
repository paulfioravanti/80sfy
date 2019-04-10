module Subscriptions exposing (subscriptions)

import AudioPlayer
import Browser.Events as Events
import ControlPanel
import FullScreen
import Json.Decode as Decode
import Key
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
        , FullScreen.subscriptions msgRouter
        , ControlPanel.subscriptions
            msgRouter
            model.controlPanel
        , Events.onKeyDown (Decode.map msgRouter.keyMsg Key.decoder)
        , VideoPlayer.subscriptions
            msgRouter
            videoPlayerContext
            model.videoPlayer1
        ]
