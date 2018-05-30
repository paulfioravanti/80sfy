module Main exposing (main)

import Config
import Flags exposing (Flags)
import Html.Styled as Html
import Model exposing (Model)
import Msg exposing (Msg)
import Subscriptions
import Tag
import Update
import View


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , update = Update.update
        , view = View.view
        , subscriptions = Subscriptions.subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        config =
            Config.init flags

        model =
            Model.init config
    in
        ( model, Tag.fetchTags )
