module Main exposing (main)

import Config
import Flags exposing (Flags)
import Html.Styled as Html
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
import MsgConfig exposing (MsgConfig)
import Subscriptions
import Tags
import Update
import View


main : Program Flags Model Msg
main =
    let
        msgConfig =
            MsgConfig.init
                AudioPlayerMsg
                ConfigMsg
                ControlPanelMsg
                SecretConfigMsg
                VideoPlayerMsg
    in
        Html.programWithFlags
            { init = init msgConfig
            , update = Update.update msgConfig
            , view = View.view msgConfig
            , subscriptions = Subscriptions.subscriptions msgConfig
            }


init : MsgConfig msg -> Flags -> ( Model, Cmd msg )
init msgConfig flags =
    let
        config =
            Config.init flags

        model =
            Model.init config
    in
        ( model, Tags.init (msgConfig.configMsg << Config.fetchTagsMsg) )
