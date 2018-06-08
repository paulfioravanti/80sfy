module SecretConfig
    exposing
        ( SecretConfig
        , init
        , initTags
        , setSoundCloudPlaylistUrl
        , setTags
        , toggleFetchNextGif
        , toggleInactivityPause
        , toggleVisibility
        , update
        , view
        )

import Html.Styled exposing (Html)
import MsgConfig exposing (MsgConfig)
import SecretConfig.Model as Model
import SecretConfig.Msg exposing (Msg(InitSecretConfigTags))
import SecretConfig.Update as Update
import SecretConfig.View as View
import Task


type alias SecretConfig =
    Model.SecretConfig


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


initTags : List String -> SecretConfig -> SecretConfig
initTags tagsList secretConfig =
    let
        tags =
            tagsList
                |> String.join ", "
    in
        { secretConfig | tags = tags }


setSoundCloudPlaylistUrl : String -> SecretConfig -> SecretConfig
setSoundCloudPlaylistUrl soundCloudPlaylistUrl secretConfig =
    { secretConfig | soundCloudPlaylistUrl = soundCloudPlaylistUrl }


setTags : String -> SecretConfig -> SecretConfig
setTags tags secretConfig =
    { secretConfig | tags = tags }


toggleFetchNextGif : Bool -> SecretConfig -> SecretConfig
toggleFetchNextGif bool secretConfig =
    { secretConfig | fetchNextGif = bool }


toggleInactivityPause : SecretConfig -> SecretConfig
toggleInactivityPause secretConfig =
    { secretConfig
        | overrideInactivityPause = not secretConfig.overrideInactivityPause
    }


toggleVisibility : SecretConfig -> SecretConfig
toggleVisibility secretConfig =
    { secretConfig | visible = not secretConfig.visible }


update :
    MsgConfig msg
    -> SecretConfig.Msg.Msg
    -> SecretConfig
    -> ( SecretConfig, Cmd msg )
update msgConfig msg secretConfig =
    Update.update msgConfig msg secretConfig


view : MsgConfig msg -> SecretConfig -> Html msg
view msgConfig secretConfig =
    View.view msgConfig secretConfig
