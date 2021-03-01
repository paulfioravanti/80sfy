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
        { audioPlayer, config, controlPanel, secretConfig, videoPlayer1 } =
            model

        msgs =
            { audioPlayerMsg = Msg.audioPlayer
            , browserVendorMsg = Msg.browserVendor
            , noOpMsg = Msg.noOp
            , videoPlayerMsg = Msg.videoPlayer
            }

        videoPlayerContext =
            { audioPlayerRawId = AudioPlayer.rawId audioPlayer.id
            , gifDisplayIntervalSeconds = config.gifDisplayIntervalSeconds
            , overrideInactivityPause = secretConfig.overrideInactivityPause
            }
    in
    Sub.batch
        [ AudioPlayer.subscriptions msgs audioPlayer
        , BrowserVendor.subscriptions msgs
        , ControlPanel.subscriptions Msg.controlPanel controlPanel
        , Key.subscriptions Msg.keyPressed
        , VideoPlayer.subscriptions msgs videoPlayerContext videoPlayer1
        ]
