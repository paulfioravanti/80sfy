module SecretConfig.View exposing (view)

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
import Html.Styled.Events exposing (onClick, onInput)
import Msg
    exposing
        ( Msg
            ( SaveConfig
            , ToggleSecretConfigVisibility
            , UpdateSecretConfigSoundCloudPlaylistUrl
            , UpdateSecretConfigTags
            )
        )
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Styles as Styles


view : SecretConfig -> Html Msg
view secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton
        , secretConfigSettings secretConfig
        ]


gifTagsInput : String -> Html Msg
gifTagsInput tags =
    textarea
        [ css [ Styles.gifTags ]
        , attribute "data-name" "search-tags"
        , onInput UpdateSecretConfigTags
        ]
        [ text tags ]


secretConfigButton : Html Msg
secretConfigButton =
    div
        [ css [ Styles.secretConfigButton ]
        , attribute "data-name" "secret-config-button"
        , onClick ToggleSecretConfigVisibility
        ]
        []


secretConfigSettings : SecretConfig -> Html Msg
secretConfigSettings { soundCloudPlaylistUrl, tags, visible } =
    div
        [ css [ Styles.secretConfig visible ]
        , attribute "data-name" "secret-config-settings"
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput soundCloudPlaylistUrl
        , saveSettingsButton
        ]


soundCloudPlaylistUrlInput : String -> Html Msg
soundCloudPlaylistUrlInput soundCloudPlaylistUrl =
    input
        [ css [ Styles.playlist ]
        , attribute "data-name" "playlist-input"
        , value soundCloudPlaylistUrl
        , onInput UpdateSecretConfigSoundCloudPlaylistUrl
        ]
        []


saveSettingsButton : Html Msg
saveSettingsButton =
    button
        [ css [ Styles.configButton ]
        , onClick SaveConfig
        ]
        [ text "Save Settings" ]
