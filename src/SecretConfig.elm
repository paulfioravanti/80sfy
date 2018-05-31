module SecretConfig
    exposing
        ( SecretConfig
        , init
        , setTags
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


setTags : Tags -> SecretConfig -> SecretConfig
setTags tagsList secretConfig =
    let
        tags =
            tagsList
                |> String.join ", "
    in
        { secretConfig | tags = tags }


toggleVisibility : SecretConfig -> SecretConfig
toggleVisibility secretConfig =
    { secretConfig | visible = not secretConfig.visible }


view : SecretConfig -> Html Msg
view secretConfig =
    View.view secretConfig
