module Config exposing
    ( Config
    , Msg
    , init
    , initTagsMsg
    , randomTagGeneratedMsg
    , save
    , saveMsg
    , update
    )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Task as Task
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)


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


randomTagGeneratedMsg : String -> String -> Msg
randomTagGeneratedMsg =
    Msg.RandomTagGenerated


save : (Msg -> msg) -> String -> String -> String -> Cmd msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    Task.save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString


saveMsg : String -> String -> String -> Msg
saveMsg =
    Msg.Save


update : Update.Msgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    Update.update msgs msg config
