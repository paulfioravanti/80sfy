module Main exposing (main)

import Html.Styled as Html
import Model exposing (Model)
import Msg exposing (Msg)
import Subscriptions
import Update
import View


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Model.init
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }
