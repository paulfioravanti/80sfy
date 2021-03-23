module SecretConfig exposing
    ( Msg
    , SecretConfig
    , init
    , performInitTags
    , update
    , view
    )

import Gif exposing (GifDisplayIntervalSeconds)
import Html.Styled exposing (Html)
import SecretConfig.Model as Model
import SecretConfig.Msg as Msg
import SecretConfig.Task as Task
import SecretConfig.Update as Update
import SecretConfig.View as View
import SecretConfig.View.ParentMsgs exposing (ParentMsgs)
import SoundCloud exposing (SoundCloudPlaylistUrl)


type alias SecretConfig =
    Model.SecretConfig


type alias Msg =
    Msg.Msg


init : SoundCloudPlaylistUrl -> GifDisplayIntervalSeconds -> SecretConfig
init soundCloudPlaylistUrl gifDisplayIntervalSeconds =
    Model.init soundCloudPlaylistUrl gifDisplayIntervalSeconds


performInitTags : (Msg -> msg) -> List String -> Cmd msg
performInitTags secretConfigMsg tags =
    Task.performInitTags secretConfigMsg tags


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    Update.update msg secretConfig


view : ParentMsgs msgs msg -> SecretConfig -> Html msg
view parentMsgs secretConfig =
    View.view parentMsgs secretConfig
