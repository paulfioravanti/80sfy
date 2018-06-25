module Main exposing (main)

import AudioPlayer
import Config
import Flags exposing (Flags)
import Html.Styled as Html
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayer
            , Config
            , ControlPanel
            , Key
            , Pause
            , Play
            , SecretConfig
            , ShowApplicationState
            , VideoPlayer
            )
        )
import MsgRouter exposing (MsgRouter)
import Subscriptions
import Tags
import Update
import View


main : Program Flags Model Msg
main =
    let
        msgRouter =
            MsgRouter.init
                AudioPlayer
                Config
                ControlPanel
                Key
                Pause
                Play
                SecretConfig
                ShowApplicationState
                VideoPlayer
    in
        Html.programWithFlags
            { init = init msgRouter
            , update = Update.update msgRouter
            , view = View.view msgRouter
            , subscriptions = Subscriptions.subscriptions msgRouter
            }


init : MsgRouter msg -> Flags -> ( Model, Cmd msg )
init msgRouter flags =
    let
        config =
            Config.init flags

        model =
            Model.init config
    in
        ( model
        , Cmd.batch
            [ Tags.init (msgRouter.configMsg << Config.initTagsMsg)
            , AudioPlayer.initAudioPlayer model.audioPlayer.volume
            ]
        )
