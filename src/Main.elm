module Main exposing (main)

import AudioPlayer
import Browser
import BrowserVendor
import Config
import Flags exposing (Flags)
import Model exposing (Model)
import Msg exposing (Msg)
import SoundCloud
import Subscriptions
import Tag
import Update
import View


main : Program Flags Model Msg
main =
    Browser.document
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

        browserVendor =
            BrowserVendor.init flags

        ({ audioPlayer } as model) =
            Model.init config browserVendor

        soundCloudWidgetFlags =
            { id = AudioPlayer.rawId audioPlayer.id
            , volume = AudioPlayer.rawVolume audioPlayer.volume
            }
    in
    ( model
    , Cmd.batch
        [ Tag.fetchTags (Config.tagsFetchedMsg Msg.config)
        , SoundCloud.initWidget soundCloudWidgetFlags
        ]
    )
