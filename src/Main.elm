module Main exposing (main)

import AudioPlayer
import Browser
import Config
import Flags exposing (Flags)
import Model exposing (Model)
import Msg exposing (Msg)
import Port
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

        ({ audioPlayer } as model) =
            Model.init config

        widgetPayload =
            AudioPlayer.soundCloudWidgetPayload audioPlayer

        initSoundCloudWidget =
            Port.initSoundCloudWidgetMsg widgetPayload
    in
    ( model
    , Cmd.batch
        [ Tag.fetchTags (Config.tagsFetchedMsg Msg.config)
        , Port.cmd initSoundCloudWidget
        ]
    )
