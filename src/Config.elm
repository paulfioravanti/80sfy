module Config exposing
    ( Config
    , Msg
    , init
    , randomTagGeneratedMsg
    , save
    , tagsFetchedMsg
    , update
    )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Task as Task
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)
import VideoPlayer exposing (VideoPlayerId)


type alias Config =
    Model.Config


type alias Msg =
    Msg.Msg


init : Flags -> Config
init flags =
    Model.init flags


randomTagGeneratedMsg : (Msg -> msg) -> VideoPlayerId -> String -> msg
randomTagGeneratedMsg configMsg videoPlayerId tag =
    Msg.randomTagGenerated configMsg videoPlayerId tag


save : (Msg -> msg) -> String -> String -> String -> Cmd msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    Task.save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString


tagsFetchedMsg : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetchedMsg configMsg tags =
    Msg.tagsFetched configMsg tags


update : Update.Msgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    Update.update msgs msg config
