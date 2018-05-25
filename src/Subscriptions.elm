module Subscriptions exposing (subscriptions)

import Animation
import ControlPanel
import Model exposing (Model)
import Msg exposing (Msg(Animate, CrossFadePlayers))
import Time


subscriptions : Model -> Sub Msg
subscriptions { controlPanel, player1 } =
    Sub.batch
        [ Time.every (4 * Time.second) CrossFadePlayers
        , Animation.subscription Animate
            [ player1.style, controlPanel.style ]
          -- FIXME
          -- , ControlPanel.subscription controlPanel
        ]
