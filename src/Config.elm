module Config
    exposing
        ( Config
        , Msg
        , init
        , initTagsMsg
        , generateRandomGifMsg
        , saveConfigMsg
        , update
        )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)
import MsgRouter exposing (MsgRouter)


type alias Config =
    Model.Config


type alias Msg =
    Msg.Msg


init : Flags -> Config
init flags =
    Model.init flags


initTagsMsg : Result Error (List String) -> Msg.Msg
initTagsMsg =
    Msg.InitTags


generateRandomGifMsg : String -> Msg
generateRandomGifMsg =
    Msg.GenerateRandomGif


saveConfigMsg : String -> String -> String -> Msg
saveConfigMsg =
    Msg.SaveConfig


update : MsgRouter msg -> Msg -> Config -> ( Config, Cmd msg )
update msgRouter msg config =
    Update.update msgRouter msg config
