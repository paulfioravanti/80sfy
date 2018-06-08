module Subscriptions exposing (subscriptions)

import Animation
import ControlPanel
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , SecretConfigMsg
            , VideoPlayerMsg
            )
        )
import MsgConfig
import Time exposing (second)
import VideoPlayer.Msg exposing (Msg(AnimateVideoPlayer, CrossFadePlayers))


subscriptions : Model -> Sub Msg.Msg
subscriptions { controlPanel, secretConfig, videoPlayer1 } =
    let
        msgConfig =
            MsgConfig.init
                AudioPlayerMsg
                ConfigMsg
                ControlPanelMsg
                SecretConfigMsg
                VideoPlayerMsg

        videoPlayerSubscription =
            if secretConfig.fetchNextGif then
                Time.every
                    (4 * second)
                    (msgConfig.videoPlayerMsg << CrossFadePlayers)
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
