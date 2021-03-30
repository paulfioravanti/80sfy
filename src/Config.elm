module Config exposing
    ( Config
    , Msg
    , init
    , randomTagGeneratedMsg
    , rawVolumeAdjustmentRate
    , tagsFetchedMsg
    , update
    , view
    )

import Config.Model as Model
import Config.Msg as Msg
import Config.Update as Update
import Config.View as View
import Config.View.ParentMsgs exposing (ParentMsgs)
import Flags exposing (Flags)
import Html.Styled exposing (Html)
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


update :
    Update.ParentMsgs msgs msg
    -> Msg
    -> Config
    -> ( Config, Cmd msg )
update parentMsgs msg secretConfig =
    Update.update parentMsgs msg secretConfig


view : ParentMsgs msgs msg -> Config -> Html msg
view parentMsgs secretConfig =
    View.view parentMsgs secretConfig
