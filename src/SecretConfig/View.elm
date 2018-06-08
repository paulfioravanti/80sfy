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
import Config.Msg exposing (Msg(SaveConfig))
import MsgConfig exposing (MsgConfig)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg
    exposing
        ( Msg
            ( ToggleGifRotation
            , ToggleInactivityPause
            , ToggleVisibility
            , UpdateSoundCloudPlaylistUrl
            , UpdateTags
            )
        )
import SecretConfig.Styles as Styles


view : MsgConfig msg -> SecretConfig -> Html msg
view msgConfig secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton msgConfig
        , secretConfigSettings msgConfig secretConfig
        ]


secretConfigButton : MsgConfig msg -> Html msg
secretConfigButton { secretConfigMsg } =
    div
        [ css [ Styles.secretConfigButton ]
        , attribute "data-name" "secret-config-button"
        , onClick (secretConfigMsg ToggleVisibility)
        ]
        []


secretConfigSettings : MsgConfig msg -> SecretConfig -> Html msg
secretConfigSettings msgConfig { soundCloudPlaylistUrl, tags, visible } =
    div
        [ css [ Styles.secretConfig visible ]
        , attribute "data-name" "secret-config-settings"
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput msgConfig tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput msgConfig soundCloudPlaylistUrl
        , saveSettingsButton msgConfig soundCloudPlaylistUrl tags
        , showStateButton
        , overrideInactivityPauseButton msgConfig
        , pauseGifRotationButton msgConfig
        , playGifRotationButton msgConfig
        , playAudioButton
        , pauseAudioButton
        ]


gifTagsInput : MsgConfig msg -> String -> Html msg
gifTagsInput { secretConfigMsg } tags =
    textarea
        [ css [ Styles.gifTags ]
        , attribute "data-name" "search-tags"
        , onInput (secretConfigMsg << UpdateTags)
        ]
        [ text tags ]


soundCloudPlaylistUrlInput : MsgConfig msg -> String -> Html msg
soundCloudPlaylistUrlInput { secretConfigMsg } soundCloudPlaylistUrl =
    input
        [ css [ Styles.playlist ]
        , attribute "data-name" "playlist-input"
        , value soundCloudPlaylistUrl
        , onInput (secretConfigMsg << UpdateSoundCloudPlaylistUrl)
        ]
        []


saveSettingsButton : MsgConfig msg -> String -> String -> Html msg
saveSettingsButton { configMsg } soundCloudPlaylistUrl tags =
    button
        [ css [ Styles.configButton ]
        , onClick (configMsg (SaveConfig soundCloudPlaylistUrl tags))
        ]
        [ text "Save Settings" ]


showStateButton : Html msg
showStateButton =
    button [ css [ Styles.configButton ] ]
        [ text "Show State" ]


overrideInactivityPauseButton : MsgConfig msg -> Html msg
overrideInactivityPauseButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg ToggleInactivityPause)
        ]
        [ text "Override Inactivity Pause" ]


pauseGifRotationButton : MsgConfig msg -> Html msg
pauseGifRotationButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg (ToggleGifRotation False))
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : MsgConfig msg -> Html msg
playGifRotationButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg (ToggleGifRotation True))
        ]
        [ text "Play Gif Rotation" ]


playAudioButton : Html msg
playAudioButton =
    button [ css [ Styles.configButton ] ]
        [ text "Play Audio" ]


pauseAudioButton : Html msg
pauseAudioButton =
    button [ css [ Styles.configButton ] ]
        [ text "Pause Audio" ]
