module Main exposing (main)

import AudioPlayer
import Browser
import Config exposing (Config)
import Flags exposing (Flags)
import Model exposing (Model)
import Msg exposing (Msg)
import Ports exposing (SoundCloudWidgetPayload)
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



-- PRIVATE


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        config : Config
        config =
            Config.init flags

        ({ audioPlayer } as model) =
            Model.init config

        widgetPayload : SoundCloudWidgetPayload
        widgetPayload =
            AudioPlayer.soundCloudWidgetPayload audioPlayer
    in
    ( model
    , Cmd.batch
        [ Tag.fetchTags (Config.tagsFetchedMsg Msg.config)
        , Ports.initSoundCloudWidget widgetPayload
        ]
    )
