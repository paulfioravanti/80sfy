module Config exposing
    ( Config
    , Msg
    , VolumeAdjustmentRate
    , init
    , randomTagGeneratedMsg
    , rawVolumeAdjustmentRate
    , tagsFetchedMsg
    , update
    )

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)
import Tag exposing (Tag)
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
update parentMsgs msg config =
    Update.update parentMsgs msg config
