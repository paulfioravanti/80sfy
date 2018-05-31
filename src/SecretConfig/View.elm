module SecretConfig.View exposing (secretConfigButton, view)

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
import Msg exposing (Msg(SaveConfig, ToggleSecretConfigVisibility))
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Styles as Styles


secretConfigButton : Bool -> Html Msg
secretConfigButton visible =
    div
        [ css [ Styles.secretConfigButton ]
        , attribute "data-name" "secret-config-button"
        , onClick ToggleSecretConfigVisibility
        ]
        []


view : SecretConfig -> Html Msg
view { soundCloudPlaylistUrl, tags, visible } =
    div
        [ css [ Styles.secretConfig visible ]
        , attribute "data-name" "secret-config"
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput soundCloudPlaylistUrl
        , saveSettingsButton
        ]


gifTagsInput : String -> Html msg
gifTagsInput tags =
    textarea
        [ css [ Styles.gifTags ]
        , attribute "data-name" "search-tags"
        ]
        [ text tags ]


soundCloudPlaylistUrlInput : String -> Html msg
soundCloudPlaylistUrlInput soundCloudPlaylistUrl =
    input
        [ css [ Styles.playlist ]
        , attribute "data-name" "playlist-input"
        , value soundCloudPlaylistUrl
        ]
        []


saveSettingsButton : Html Msg
saveSettingsButton =
    button
        [ css [ Styles.configButton ]
          -- , onClick (SaveConfig)
        ]
        [ text "Save Settings" ]
