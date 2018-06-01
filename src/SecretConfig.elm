module SecretConfig
    exposing
        ( SecretConfig
        , init
        , initTags
        , setSoundCloudPlaylistUrl
        , setTags
        , toggleInactivityPause
        , toggleVisibility
        , view
        )

import Html.Styled exposing (Html)
import Msg exposing (Msg)
import SecretConfig.Model as Model
import SecretConfig.View as View
import Tag exposing (Tags)


type alias SecretConfig =
    Model.SecretConfig


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


initTags : Tags -> SecretConfig -> SecretConfig
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


toggleInactivityPause : SecretConfig -> SecretConfig
toggleInactivityPause secretConfig =
    { secretConfig
        | overrideInactivityPause = not secretConfig.overrideInactivityPause
    }


toggleVisibility : SecretConfig -> SecretConfig
toggleVisibility secretConfig =
    { secretConfig | visible = not secretConfig.visible }


view : SecretConfig -> Html Msg
view secretConfig =
    View.view secretConfig
