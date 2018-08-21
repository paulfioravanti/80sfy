module Main exposing (main)

import AudioPlayer
import BrowserVendor
import Config
import Flags exposing (Flags)
import FullScreen
import Html.Styled as Html
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayer
            , Config
            , ControlPanel
            , FullScreen
            , Key
            , NoOp
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
            { audioPlayerMsg = AudioPlayer
            , configMsg = Config
            , controlPanelMsg = ControlPanel
            , fullScreenMsg = FullScreen
            , keyMsg = Key
            , noOpMsg = NoOp
            , pauseMsg = Pause
            , playMsg = Play
            , secretConfigMsg = SecretConfig
            , showApplicationState = ShowApplicationState
            , videoPlayerMsg = VideoPlayer
            }
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

        browserVendor =
            BrowserVendor.init flags

        ({ audioPlayer } as model) =
            Model.init config browserVendor

        audioPlayerFlags =
            { id = audioPlayer.id
            , volume = audioPlayer.volume
            }
    in
        ( model
        , Cmd.batch
            [ Tags.init (msgRouter.configMsg << Config.initTagsMsg)
            , AudioPlayer.initAudioPlayer audioPlayerFlags
            ]
        )
