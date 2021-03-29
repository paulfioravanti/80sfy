module SecretConfig exposing
    ( Msg
    , SecretConfig
    , init
    , performInitTags
    , randomTagGeneratedMsg
    , saveMsg
    , update
    , view
    )

import Flags exposing (Flags)
import Gif exposing (GifDisplayIntervalSeconds)
import Html.Styled exposing (Html)
import SecretConfig.Model as Model
import SecretConfig.Msg as Msg
import SecretConfig.Task as Task
import SecretConfig.Update as Update
import SecretConfig.View as View
import SecretConfig.View.ParentMsgs exposing (ParentMsgs)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type alias SecretConfig =
    Model.SecretConfig


type alias Msg =
    Msg.Msg


init : Flags -> SoundCloudPlaylistUrl -> GifDisplayIntervalSeconds -> SecretConfig
init flags soundCloudPlaylistUrl gifDisplayIntervalSeconds =
    Model.init flags soundCloudPlaylistUrl gifDisplayIntervalSeconds


performInitTags : (Msg -> msg) -> List String -> Cmd msg
performInitTags secretConfigMsg tags =
    Task.performInitTags secretConfigMsg tags


randomTagGeneratedMsg : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGeneratedMsg configMsg videoPlayerId tag =
    Msg.randomTagGenerated configMsg videoPlayerId tag


saveMsg :
    SoundCloudPlaylistUrl
    -> List Tag
    -> GifDisplayIntervalSeconds
    -> Msg
saveMsg soundCloudPlaylistUrl tagList gifDisplayIntervalSeconds =
    Msg.Save soundCloudPlaylistUrl tagList gifDisplayIntervalSeconds


update :
    Update.ParentMsgs msgs msg
    -> Msg
    -> SecretConfig
    -> ( SecretConfig, Cmd msg )
update parentMsgs msg secretConfig =
    Update.update parentMsgs msg secretConfig


view : ParentMsgs msgs msg -> SecretConfig -> Html msg
view parentMsgs secretConfig =
    View.view parentMsgs secretConfig
