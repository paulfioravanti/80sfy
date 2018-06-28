module SecretConfig
    exposing
        ( Msg
        , SecretConfig
        , init
        , initTagsMsg
        , update
        , view
        )

import Html.Styled exposing (Html)
import MsgRouter exposing (MsgRouter)
import SecretConfig.Model as Model
import SecretConfig.Msg as Msg
import SecretConfig.Update as Update
import SecretConfig.View as View


type alias SecretConfig =
    Model.SecretConfig


type alias Msg =
    Msg.Msg


init : String -> Float -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    Model.init soundCloudPlaylistUrl gifDisplaySeconds


initTagsMsg : List String -> Msg
initTagsMsg =
    Msg.InitTags


update : Msg -> SecretConfig -> ( SecretConfig, Cmd msg )
update msg secretConfig =
    Update.update msg secretConfig


view : MsgRouter msg -> SecretConfig -> Html msg
view msgRouter secretConfig =
    View.view msgRouter secretConfig
