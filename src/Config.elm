module Config exposing
    ( Config
    , Msg
    , VolumeAdjustmentRate
    , init
    , performSave
    , randomTagGeneratedMsg
    , rawVolumeAdjustmentRate
    , tagsFetchedMsg
    , update
    )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Task as Task
import Config.Update as Update
import Flags exposing (Flags)
import Gif exposing (GifDisplayIntervalSeconds)
import Http exposing (Error)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag, TagsString)
import VideoPlayer exposing (VideoPlayerId)


type alias Config =
    Model.Config


type alias Msg =
    Msg.Msg


type alias VolumeAdjustmentRate =
    Model.VolumeAdjustmentRate


init : Flags -> Config
init flags =
    Model.init flags


performSave :
    (Msg -> msg)
    -> SoundCloudPlaylistUrl
    -> TagsString
    -> GifDisplayIntervalSeconds
    -> Cmd msg
performSave configMsg soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds =
    Task.performSave
        configMsg
        soundCloudPlaylistUrl
        tagsString
        gifDisplayIntervalSeconds


randomTagGeneratedMsg : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGeneratedMsg configMsg videoPlayerId tag =
    Msg.randomTagGenerated configMsg videoPlayerId tag


rawVolumeAdjustmentRate : VolumeAdjustmentRate -> Int
rawVolumeAdjustmentRate volumeAdjustmentRate =
    Model.rawVolumeAdjustmentRate volumeAdjustmentRate


tagsFetchedMsg : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetchedMsg configMsg tags =
    Msg.tagsFetched configMsg tags


update : Update.ParentMsgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    Update.update msgs msg config
