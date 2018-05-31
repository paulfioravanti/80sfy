module Config.View exposing (view)

import Config.Model exposing (Config)
import Config.Styles as Styles
import Html.Styled as Html
    exposing
        ( Html
        , div
        , span
        , text
        )
import Html.Styled.Attributes as Attributes
    exposing
        ( attribute
        , css
        )
import Html.Styled.Events exposing (onClick)
import Msg exposing (Msg(ToggleConfigVisibility))


view : Config -> Html Msg
view { visible } =
    div
        [ attribute "data-name" "secret-config"
        , onClick ToggleConfigVisibility
        ]
        [ div
            [ css [ Styles.secretConfigButton ]
            , attribute "data-name" "secret-config-button"
            ]
            []
        , div
            [ css [ Styles.secretConfig visible ]
            , attribute "data-name" "secret-config-content"
            ]
            [ span [] [ text "Tags:" ] ]
        ]
