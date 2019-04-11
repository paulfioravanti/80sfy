module Main exposing (main)

import AudioPlayer
import Browser
import BrowserVendor
import Config
import Flags exposing (Flags)
import Model exposing (Model)
import Msg exposing (Msg)
import MsgRouter exposing (MsgRouter)
import Subscriptions
import Tags
import Update
import View


main : Program Flags Model Msg
main =
    let
        msgRouter =
            { audioPlayerMsg = Msg.AudioPlayer
            , configMsg = Msg.Config
            , controlPanelMsg = Msg.ControlPanel
            , fullScreenMsg = Msg.FullScreen
            , keyMsg = Msg.Key
            , noOpMsg = Msg.NoOp
            , pauseMsg = Msg.Pause
            , playMsg = Msg.Play
            , secretConfigMsg = Msg.SecretConfig
            , showApplicationState = Msg.ShowApplicationState
            , videoPlayerMsg = Msg.VideoPlayer
            }
    in
    Browser.document
        { init = init
        , update = Update.update msgRouter
        , view = View.view msgRouter
        , subscriptions = Subscriptions.subscriptions msgRouter
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
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
        [ Tags.init (Msg.Config << Config.initTagsMsg)
        , AudioPlayer.initAudioPlayer audioPlayerFlags
        ]
    )
