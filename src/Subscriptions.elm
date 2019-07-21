module Subscriptions exposing (subscriptions)

import AudioPlayer
import BrowserVendor
import ControlPanel
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import VideoPlayer


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        msgs =
            { audioPlayerMsg = Msg.audioPlayer
            , noOpMsg = Msg.noOp
            , videoPlayerMsg = Msg.videoPlayer
            }

        videoPlayerContext =
            { audioPlayerId = model.audioPlayer.id
            , gifDisplaySeconds = model.config.gifDisplaySeconds
            , overrideInactivityPause =
                model.secretConfig.overrideInactivityPause
            }
    in
    Sub.batch
        [ AudioPlayer.subscriptions msgs model.audioPlayer
        , BrowserVendor.subscriptions Msg.browserVendor
        , ControlPanel.subscriptions Msg.controlPanel model.controlPanel
        , Key.subscriptions Msg.keyPressed
        , VideoPlayer.subscriptions msgs videoPlayerContext model.videoPlayer1
        ]
