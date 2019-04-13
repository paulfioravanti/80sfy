module Subscriptions exposing (subscriptions)

import AudioPlayer
import ControlPanel
import FullScreen
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import VideoPlayer


subscriptions : Model -> Sub Msg
subscriptions model =
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
            Msg.AudioPlayer
            Msg.NoOp
            Msg.VideoPlayer
            model.audioPlayer
        , FullScreen.subscriptions Msg.FullScreen
        , ControlPanel.subscriptions Msg.ControlPanel model.controlPanel
        , Key.subscriptions Msg.KeyPressed
        , VideoPlayer.subscriptions
            Msg.NoOp
            Msg.VideoPlayer
            videoPlayerContext
            model.videoPlayer1
        ]
