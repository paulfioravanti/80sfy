module SecretConfig exposing
    ( Msg
    , SecretConfig
    , init
    , initTags
    , update
    , view
    )

import Html.Styled exposing (Html)
import SecretConfig.Model as Model
import SecretConfig.Msg as Msg
import SecretConfig.Task as Task
import SecretConfig.Update as Update
import SecretConfig.View as View


type alias SecretConfig =
    Model.SecretConfig


type alias Msg =
    Msg.Msg


init : String -> Float -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    Model.init soundCloudPlaylistUrl gifDisplaySeconds


initTags : (Msg -> msg) -> List String -> Cmd msg
initTags secretConfigMsg tags =
    Task.initTags secretConfigMsg tags


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    Update.update msg secretConfig


view : View.Msgs msgs msg -> SecretConfig -> Html msg
view msgs secretConfig =
    View.view msgs secretConfig
