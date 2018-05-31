module Config
    exposing
        ( Config
        , init
        , updateSettings
        , secretConfigButton
        , setTags
        , toggleVisibility
        , view
        )

import Config.Model as Model exposing (Config)
import Config.View as View
import Html.Styled exposing (Html)
import Flags exposing (Flags)
import Msg exposing (Msg)
import Tag exposing (Tags)


type alias Config =
    Model.Config


init : Flags -> Config
init flags =
    Model.init flags


secretConfigButton : Bool -> Html Msg
secretConfigButton visible =
    View.secretConfigButton visible


setTags : Tags -> Config -> Config
setTags tags config =
    { config | tags = tags }


toggleVisibility : Config -> Config
toggleVisibility config =
    { config | visible = not config.visible }


updateSettings : String -> String -> Config -> Config
updateSettings playlistUrl tagsString config =
    let
        tags =
            tagsString
                |> String.split ", "
                |> List.map String.trim
    in
        { config | playlistUrl = playlistUrl, tags = tags }


view : String -> Tags -> Bool -> Html Msg
view playlistUrl tags visible =
    View.view playlistUrl tags visible
