module Subscriptions exposing (subscriptions)

import Animation
import ControlPanel
import Model exposing (Model)
import Msg exposing (Msg(Animate, CrossFadePlayers))
import Time exposing (second)


subscriptions : Model -> Sub Msg
subscriptions { controlPanel, secretConfig, videoPlayer1 } =
    let
        controlPanelSubscription =
            if secretConfig.overrideInactivityPause then
                Sub.none
            else
                ControlPanel.subscriptions controlPanel
    in
        Sub.batch
            [ Time.every (4 * second) CrossFadePlayers
            , Animation.subscription Animate
                [ videoPlayer1.style, controlPanel.style ]
            , controlPanelSubscription
            ]
