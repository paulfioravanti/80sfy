module Config
    exposing
        ( Config
        , Msg
        , init
        , initTagsMsg
        , generateRandomGifMsg
        , update
        )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)
import MsgConfig exposing (MsgConfig)


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


update : MsgConfig msg -> Msg -> Config -> ( Config, Cmd msg )
update msgConfig msg config =
    Update.update msgConfig msg config
