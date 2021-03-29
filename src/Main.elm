module Main exposing (main)

import AudioPlayer
import Browser
import Config
import Flags exposing (Flags)
import Http exposing (Error)
import Model exposing (Model)
import Msg exposing (Msg, Msgs)
import Ports exposing (SoundCloudWidgetPayload)
import Subscriptions
import Tag
import Update
import View


main : Program Flags Model Msg
main =
    let
        msgs : Msgs
        msgs =
            Msg.dictionary
    in
    Browser.document
        { init = init
        , update = Update.update msgs
        , view = View.view msgs
        , subscriptions = Subscriptions.subscriptions msgs
        }



-- PRIVATE


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        ({ audioPlayer } as model) =
            Model.init flags

        widgetPayload : SoundCloudWidgetPayload
        widgetPayload =
            AudioPlayer.soundCloudWidgetPayload audioPlayer

        tagsFetchedMsg : Result Error (List String) -> Msg
        tagsFetchedMsg =
            Config.tagsFetchedMsg Msg.Config
    in
    ( model
    , Cmd.batch
        [ Tag.fetchTags tagsFetchedMsg
        , Ports.initSoundCloudWidget widgetPayload
        ]
    )
