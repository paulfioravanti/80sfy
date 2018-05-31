module Config.View exposing (secretConfigButton, view)

import Config.Styles as Styles
import Html.Styled as Html
    exposing
        ( Html
        , button
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
import Msg exposing (Msg(SaveConfig, ToggleConfigVisibility))
import Tag exposing (Tags)


secretConfigButton : Bool -> Html Msg
secretConfigButton visible =
    div
        [ css [ Styles.secretConfigButton ]
        , attribute "data-name" "secret-config-button"
        , onClick ToggleConfigVisibility
        ]
        []


view : String -> Tags -> Bool -> Html Msg
view playlistUrl tags visible =
    div
        [ css [ Styles.secretConfig visible ]
        , attribute "data-name" "secret-config"
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput tags
        , span []
            [ text "Playlist:" ]
        , playlistUrlInput playlistUrl
        , saveSettingsButton playlistUrl tags
        ]


gifTagsInput : Tags -> Html msg
gifTagsInput tags =
    textarea
        [ css [ Styles.gifTags ]
        , attribute "data-name" "search-tags"
        ]
        [ text (String.join ", " tags) ]


playlistUrlInput : String -> Html msg
playlistUrlInput playlistUrl =
    input
        [ css [ Styles.playlist ]
        , attribute "data-name" "playlist-input"
        , value playlistUrl
        ]
        []


saveSettingsButton : String -> Tags -> Html Msg
saveSettingsButton playlistUrl tags =
    button
        [ css [ Styles.configButton ]
        , onClick (SaveConfig playlistUrl (String.join ", " tags))
        ]
        [ text "Save Settings" ]
