module SecretConfig.View exposing (view)

import AudioPlayer
import ControlPanel
import Html.Styled
    exposing
        ( Html
        , button
        , div
        , input
        , span
        , text
        , textarea
        )
import Html.Styled.Attributes
    exposing
        ( attribute
        , css
        , value
        )
import Html.Styled.Events exposing (onClick, onInput)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SecretConfig.Styles as Styles
import VideoPlayer


view :
    (AudioPlayer.Msg -> msg)
    -> (ControlPanel.Msg -> msg)
    -> (String -> String -> String -> msg)
    -> (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> SecretConfig
    -> Html msg
view audioPlayerMsg controlPanelMsg saveConfigMsg secretConfigMsg showApplicationStateMsg videoPlayerMsg secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton secretConfigMsg
        , secretConfigSettings
            audioPlayerMsg
            saveConfigMsg
            controlPanelMsg
            secretConfigMsg
            showApplicationStateMsg
            videoPlayerMsg
            secretConfig
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


secretConfigSettings :
    (AudioPlayer.Msg -> msg)
    -> (String -> String -> String -> msg)
    -> (ControlPanel.Msg -> msg)
    -> (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> SecretConfig
    -> Html msg
secretConfigSettings audioPlayerMsg saveConfigMsg controlPanelMsg secretConfigMsg showApplicationStateMsg videoPlayerMsg secretConfig =
    div
        [ attribute "data-name" "secret-config-settings"
        , css [ Styles.secretConfig secretConfig.visible ]
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput secretConfigMsg secretConfig.tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput
            secretConfigMsg
            secretConfig.soundCloudPlaylistUrl
        , span []
            [ text "Gif Display Seconds:" ]
        , gifDisplaySecondsInput secretConfigMsg secretConfig.gifDisplaySeconds
        , saveSettingsButton
            saveConfigMsg
            secretConfig.soundCloudPlaylistUrl
            secretConfig.tags
            secretConfig.gifDisplaySeconds
        , showStateButton showApplicationStateMsg
        , overrideControlPanelHideButton controlPanelMsg
        , overrideInactivityPauseButton secretConfigMsg
        , pauseGifRotationButton videoPlayerMsg
        , playGifRotationButton videoPlayerMsg
        , playAudioButton audioPlayerMsg
        , pauseAudioButton audioPlayerMsg
        ]


gifTagsInput : (Msg -> msg) -> String -> Html msg
gifTagsInput secretConfigMsg tags =
    textarea
        [ attribute "data-name" "search-tags"
        , css [ Styles.gifTags ]
        , onInput (secretConfigMsg << Msg.UpdateTags)
        ]
        [ text tags ]


soundCloudPlaylistUrlInput : (Msg -> msg) -> String -> Html msg
soundCloudPlaylistUrlInput secretConfigMsg soundCloudPlaylistUrl =
    input
        [ attribute "data-name" "playlist-input"
        , css [ Styles.configInput ]
        , value soundCloudPlaylistUrl
        , onInput (secretConfigMsg << Msg.UpdateSoundCloudPlaylistUrl)
        ]
        []


gifDisplaySecondsInput : (Msg -> msg) -> String -> Html msg
gifDisplaySecondsInput secretConfigMsg gifDisplaySeconds =
    input
        [ attribute "data-name" "gif-display-seconds-input"
        , css [ Styles.configInput ]
        , value gifDisplaySeconds
        , onInput (secretConfigMsg << Msg.UpdateGifDisplaySeconds)
        ]
        []


saveSettingsButton :
    (String -> String -> String -> msg)
    -> String
    -> String
    -> String
    -> Html msg
saveSettingsButton saveConfigMsg soundCloudPlaylistUrl tags gifDisplaySeconds =
    let
        saveConfig =
            saveConfigMsg
                soundCloudPlaylistUrl
                tags
                gifDisplaySeconds
    in
    button
        [ css [ Styles.configButton ]
        , onClick saveConfig
        ]
        [ text "Save Settings" ]


showStateButton : msg -> Html msg
showStateButton showApplicationStateMsg =
    button
        [ css [ Styles.configButton ]
        , onClick showApplicationStateMsg
        ]
        [ text "Show State" ]


overrideControlPanelHideButton : (ControlPanel.Msg -> msg) -> Html msg
overrideControlPanelHideButton controlPanelMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (controlPanelMsg ControlPanel.toggleHideWhenInactiveMsg)
        ]
        [ text "Override Control Panel Hide" ]


overrideInactivityPauseButton : (Msg -> msg) -> Html msg
overrideInactivityPauseButton secretConfigMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg Msg.ToggleInactivityPauseOverride)
        ]
        [ text "Toggle Inactivity Pause" ]


pauseGifRotationButton : (VideoPlayer.Msg -> msg) -> Html msg
pauseGifRotationButton videoPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (videoPlayerMsg VideoPlayer.pauseVideosMsg)
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : (VideoPlayer.Msg -> msg) -> Html msg
playGifRotationButton videoPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (videoPlayerMsg VideoPlayer.playVideosMsg)
        ]
        [ text "Play Gif Rotation" ]


playAudioButton : (AudioPlayer.Msg -> msg) -> Html msg
playAudioButton audioPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (audioPlayerMsg AudioPlayer.playAudioMsg)
        ]
        [ text "Play Audio" ]


pauseAudioButton : (AudioPlayer.Msg -> msg) -> Html msg
pauseAudioButton audioPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (audioPlayerMsg AudioPlayer.pauseAudioMsg)
        ]
        [ text "Pause Audio" ]
