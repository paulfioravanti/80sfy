module Main exposing (main)

import Animation
import Html.Styled as Html
import Model exposing (Model)
import Msg exposing (Msg(Animate, CrossFade))
import Time exposing (Time)
import Update
import View


subscriptions : Model -> Sub Msg
subscriptions { player1 } =
    Sub.batch
        [ Time.every (4 * Time.second) CrossFade
        , Animation.subscription Animate [ player1.style ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Model.init
        , update = Update.update
        , subscriptions = subscriptions
        }
