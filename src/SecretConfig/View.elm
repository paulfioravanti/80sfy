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
            , ToggleGifRotation
            , ToggleInactivityPause
            , ToggleSecretConfigVisibility
            , UpdateSecretConfigSoundCloudPlaylistUrl
            , UpdateSecretConfigTags
            )
        )
import MsgConfig exposing (MsgConfig)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Styles as Styles


view : MsgConfig msg -> SecretConfig -> Html Msg
view msgConfig secretConfig =
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


overrideInactivityPauseButton : Html Msg
overrideInactivityPauseButton =
    button
        [ css [ Styles.configButton ]
        , onClick ToggleInactivityPause
        ]
        [ text "Override Inactivity Pause" ]


pauseAudioButton : Html msg
pauseAudioButton =
    button [ css [ Styles.configButton ] ]
        [ text "Pause Audio" ]


pauseGifRotationButton : Html Msg
pauseGifRotationButton =
    button
        [ css [ Styles.configButton ]
        , onClick (ToggleGifRotation False)
        ]
        [ text "Pause Gif Rotation" ]


playAudioButton : Html msg
playAudioButton =
    button [ css [ Styles.configButton ] ]
        [ text "Play Audio" ]


playGifRotationButton : Html Msg
playGifRotationButton =
    button
        [ css [ Styles.configButton ]
        , onClick (ToggleGifRotation True)
        ]
        [ text "Play Gif Rotation" ]


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
        , saveSettingsButton soundCloudPlaylistUrl tags
        , showStateButton
        , overrideInactivityPauseButton
        , pauseGifRotationButton
        , playGifRotationButton
        , playAudioButton
        , pauseAudioButton
        ]


showStateButton : Html msg
showStateButton =
    button [ css [ Styles.configButton ] ]
        [ text "Show State" ]


soundCloudPlaylistUrlInput : String -> Html Msg
soundCloudPlaylistUrlInput soundCloudPlaylistUrl =
    input
        [ css [ Styles.playlist ]
        , attribute "data-name" "playlist-input"
        , value soundCloudPlaylistUrl
        , onInput UpdateSecretConfigSoundCloudPlaylistUrl
        ]
        []


saveSettingsButton : String -> String -> Html Msg
saveSettingsButton soundCloudPlaylistUrl tags =
    button
        [ css [ Styles.configButton ]
        , onClick (SaveConfig soundCloudPlaylistUrl tags)
        ]
        [ text "Save Settings" ]
