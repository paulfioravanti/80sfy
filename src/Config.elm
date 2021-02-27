module Config exposing
    ( Config
    , Msg
    , init
    , performSave
    , randomTagGeneratedMsg
    , tagsFetchedMsg
    , update
    )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Task as Task
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type alias Config =
    Model.Config


type alias Msg =
    Msg.Msg


init : Flags -> Config
init flags =
    Model.init flags


performSave :
    (Msg -> msg)
    -> SoundCloudPlaylistUrl
    -> String
    -> String
    -> Cmd msg
performSave configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    Task.performSave
        configMsg
        soundCloudPlaylistUrl
        tagsString
        gifDisplaySecondsString


randomTagGeneratedMsg : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGeneratedMsg configMsg videoPlayerId tag =
    Msg.randomTagGenerated configMsg videoPlayerId tag


tagsFetchedMsg : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetchedMsg configMsg tags =
    Msg.tagsFetched configMsg tags


update : Update.Msgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    Update.update msgs msg config
