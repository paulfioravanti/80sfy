module SecretConfig
    exposing
        ( Msg
        , SecretConfig
        , init
        , initTagsMsg
        , toggleGifRotationMsg
        , update
        , view
        )

import Html.Styled exposing (Html)
import MsgConfig exposing (MsgConfig)
import SecretConfig.Model as Model
import SecretConfig.Msg as Msg
import SecretConfig.Update as Update
import SecretConfig.View as View


type alias SecretConfig =
    Model.SecretConfig


type alias Msg =
    Msg.Msg


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


initTagsMsg : List String -> Msg
initTagsMsg =
    Msg.InitTags


toggleGifRotationMsg : Bool -> Msg
toggleGifRotationMsg =
    Msg.ToggleGifRotation


update : MsgConfig msg -> Msg -> SecretConfig -> ( SecretConfig, Cmd msg )
update msgConfig msg secretConfig =
    Update.update msgConfig msg secretConfig


view : MsgConfig msg -> SecretConfig -> Html msg
view msgConfig secretConfig =
    View.view msgConfig secretConfig
