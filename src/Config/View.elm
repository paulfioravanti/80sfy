module Config.View exposing (button, view)

import Config.Model exposing (Config)
import Config.Styles as Styles
import Html.Styled as Html
    exposing
        ( Html
        , div
        , input
        , span
        , text
        , textarea
        )
import Html.Styled.Attributes as Attributes
    exposing
        ( attribute
        , css
        , value
        )
import Html.Styled.Events exposing (onClick)
import Msg exposing (Msg(ToggleConfigVisibility))


button : Config -> Html Msg
button { visible } =
    div
        [ css [ Styles.secretConfigButton ]
        , attribute "data-name" "secret-config-button"
        , onClick ToggleConfigVisibility
        ]
        []


view : Config -> Html Msg
view { playlistUrl, tags, visible } =
    div
        [ css [ Styles.secretConfig visible ]
        , attribute "data-name" "secret-config"
        ]
        [ span []
            [ text "Tags:" ]
        , textarea
            [ css [ Styles.searchTags ]
            , attribute "data-name" "search-tags"
            ]
            [ text (String.join ", " tags) ]
        , span []
            [ text "Playlist:" ]
        , input
            [ css [ Styles.playlist ]
            , attribute "data-name" "playlist-input"
            , value playlistUrl
            ]
            []
        ]
