module Main exposing (main)

import Animation
import ControlPanel
import Html.Styled as Html
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( Animate
            , CrossFadePlayers
            )
        )
import Time
import Update
import View
import Visibility exposing (Visibility(Visible))


subscriptions : Model -> Sub Msg
subscriptions { controlPanel, player1 } =
    Sub.batch
        [ Time.every (4 * Time.second) CrossFadePlayers
        , Animation.subscription Animate
            [ player1.style, controlPanel.style ]
        , ControlPanel.subscription controlPanel
        ]


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Model.init
        , update = Update.update
        , subscriptions = subscriptions
        }
