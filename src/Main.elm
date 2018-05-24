module Main exposing (main)

import Animation
import ControlPanel exposing (Status(Visible))
import Html.Styled as Html
import Model exposing (Model)
import Mouse
import Msg
    exposing
        ( Msg
            ( Animate
            , CrossFade
            , HideControlPanel
            , ShowControlPanel
            , Tick
            )
        )
import Time exposing (Time)
import Update
import View


subscriptions : Model -> Sub Msg
subscriptions { controlPanel, player1 } =
    let
        menuToggle =
            if controlPanel.status == Visible && not controlPanel.inUse then
                Time.every Time.second Tick
            else
                Mouse.moves (\_ -> ShowControlPanel)
    in
        Sub.batch
            [ Time.every (4 * Time.second) CrossFade
            , Animation.subscription Animate [ player1.style, controlPanel.style ]
            , menuToggle
            ]


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Model.init
        , update = Update.update
        , subscriptions = subscriptions
        }
