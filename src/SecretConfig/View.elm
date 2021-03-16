module SecretConfig.View exposing (view)

import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (attribute, css)
import Html.Styled.Events exposing (onClick)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SecretConfig.View.Msgs exposing (Msgs)
import SecretConfig.View.Settings as Settings
import SecretConfig.View.Styles as Styles


view : Msgs msgs msg -> SecretConfig -> Html msg
view ({ secretConfigMsg } as msgs) secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton secretConfigMsg
        , Settings.view msgs secretConfig
        ]



-- PRIVATE


secretConfigButton : (Msg -> msg) -> Html msg
secretConfigButton secretConfigMsg =
    div
        [ attribute "data-name" "secret-config-button"
        , css [ Styles.secretConfigButton ]
        , onClick (Msg.toggleVisibility secretConfigMsg)
        ]
        []
