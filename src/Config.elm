module Config exposing (Config, button, init, setTags, toggleVisibility, view)

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


setTags : Tags -> Config -> Config
setTags tags config =
    { config | tags = tags }


toggleVisibility : Config -> Config
toggleVisibility config =
    { config | visible = not config.visible }


button : Config -> Html Msg
button config =
    View.button config


view : Config -> Html Msg
view config =
    View.view config
