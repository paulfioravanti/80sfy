module Subscriptions exposing (subscriptions)

import Animation
import ControlPanel
import Model exposing (Model)
import Msg exposing (Msg(Animate, CrossFadePlayers))
import Time exposing (second)


subscriptions : Model -> Sub Msg
subscriptions { controlPanel, videoPlayer1 } =
    Sub.batch
        [ Time.every (4 * second) CrossFadePlayers
        , Animation.subscription Animate
            [ videoPlayer1.style, controlPanel.style ]
        , ControlPanel.subscriptions controlPanel
        ]
