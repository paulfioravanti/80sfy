module SecretConfig.View exposing (view)

import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (attribute, css)
import Html.Styled.Events exposing (onClick)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SecretConfig.View.ParentMsgs exposing (ParentMsgs)
import SecretConfig.View.Settings as Settings
import SecretConfig.View.Styles as Styles


view : ParentMsgs msgs msg -> SecretConfig -> Html msg
view ({ secretConfigMsg } as parentMsgs) secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton secretConfigMsg
        , Settings.view parentMsgs secretConfig
        ]



-- PRIVATE


secretConfigButton : (Msg -> msg) -> Html msg
secretConfigButton secretConfigMsg =
    div
        [ attribute "data-name" "secret-config-button"
        , css [ Styles.secretConfigButton ]
        , onClick (secretConfigMsg Msg.ToggleVisibility)
        ]
        []
