module Subscriptions exposing (subscriptions)

import Animation
import ControlPanel
import ControlPanel.Msg exposing (Msg(AnimateControlPanel))
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( ConfigMsg
            , ControlPanelMsg
            , CrossFadePlayers
            , SecretConfigMsg
            , VideoPlayerMsg
            )
        )
import MsgConfig
import Time exposing (second)
import VideoPlayer.Msg exposing (Msg(AnimateVideoPlayer))


subscriptions : Model -> Sub Msg.Msg
subscriptions { controlPanel, secretConfig, videoPlayer1 } =
    let
        msgConfig =
            MsgConfig.init
                ConfigMsg
                ControlPanelMsg
                SecretConfigMsg
                VideoPlayerMsg

        videoPlayerSubscription =
            if secretConfig.fetchNextGif then
                Time.every (4 * second) CrossFadePlayers
            else
                Sub.none

        controlPanelSubscription =
            if secretConfig.overrideInactivityPause then
                Sub.none
            else
                ControlPanel.subscriptions
                    msgConfig
                    secretConfig.overrideInactivityPause
                    controlPanel
    in
        Sub.batch
            [ videoPlayerSubscription
            , Animation.subscription
                (VideoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            , controlPanelSubscription
            ]
