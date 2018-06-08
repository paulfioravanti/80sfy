module Subscriptions exposing (subscriptions)

import Animation
import ControlPanel
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AnimateControlPanel
            , ConfigMsg
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
                ControlPanel.subscriptions controlPanel
    in
        Sub.batch
            [ videoPlayerSubscription
            , Animation.subscription
                (VideoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            , Animation.subscription AnimateControlPanel [ controlPanel.style ]
            , controlPanelSubscription
            ]
