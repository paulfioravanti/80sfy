module Config.View exposing (view)

import Config.Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Config.View.ParentMsgs exposing (ParentMsgs)
import Config.View.Settings as Settings
import Config.View.Styles as Styles
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (attribute, css)
import Html.Styled.Events exposing (onClick)


view : ParentMsgs msgs msg -> Config -> Html msg
view ({ configMsg } as parentMsgs) secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton configMsg
        , Settings.view parentMsgs secretConfig
        ]



-- PRIVATE


secretConfigButton : (Msg -> msg) -> Html msg
secretConfigButton configMsg =
    div
        [ attribute "data-name" "secret-config-button"
        , css [ Styles.secretConfigButton ]
        , onClick (configMsg Msg.ToggleVisibility)
        ]
        []
