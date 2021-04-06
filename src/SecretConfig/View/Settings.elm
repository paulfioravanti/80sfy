module SecretConfig.View.Settings exposing (view)

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
import Ports
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SecretConfig.View.ParentMsgs exposing (ParentMsgs)
import SecretConfig.View.Styles as Styles


view : ParentMsgs msgs msg -> SecretConfig -> Html msg
view parentMsgs secretConfig =
    let
        { portsMsg, secretConfigMsg } =
            parentMsgs
    in
    div
        [ attribute "data-name" "secret-config-settings"
        , css [ Styles.secretConfig secretConfig.visible ]
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput secretConfigMsg secretConfig.tagsField
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput
            secretConfigMsg
            secretConfig.soundCloudPlaylistUrlField
        , span []
            [ text "Gif Display Seconds:" ]
        , gifDisplaySecondsInput
            secretConfigMsg
            secretConfig.gifDisplayIntervalSecondsField
        , saveSettingsButton parentMsgs.secretConfigMsg
        , showStateButton parentMsgs.showApplicationStateMsg
        , overrideControlPanelHideButton parentMsgs.controlPanelMsg
        , overrideInactivityPauseButton secretConfigMsg
        , pauseGifRotationButton portsMsg
        , playGifRotationButton portsMsg
        , playAudioButton portsMsg
        , pauseAudioButton portsMsg
        ]


gifTagsInput : (Msg -> msg) -> String -> Html msg
gifTagsInput secretConfigMsg rawTags =
    textarea
        [ attribute "data-name" "search-tags"
        , css [ Styles.gifTags ]
        , onInput (Msg.updateTagsField secretConfigMsg)
        ]
        [ text rawTags ]


soundCloudPlaylistUrlInput : (Msg -> msg) -> String -> Html msg
soundCloudPlaylistUrlInput secretConfigMsg rawSoundCloudPlaylistUrl =
    input
        [ attribute "data-name" "playlist-input"
        , css [ Styles.configInput ]
        , value rawSoundCloudPlaylistUrl
        , onInput (Msg.updateSoundCloudPlaylistUrlField secretConfigMsg)
        ]
        []


gifDisplaySecondsInput : (Msg -> msg) -> String -> Html msg
gifDisplaySecondsInput secretConfigMsg rawGifDisplayIntervalSeconds =
    input
        [ attribute "data-name" "gif-display-seconds-input"
        , css [ Styles.configInput ]
        , value rawGifDisplayIntervalSeconds
        , onInput (Msg.updateGifDisplaySecondsField secretConfigMsg)
        ]
        []


saveSettingsButton : (Msg -> msg) -> Html msg
saveSettingsButton secretConfigMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg Msg.Save)
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
        , onClick (ControlPanel.toggleHideWhenInactiveMsg controlPanelMsg)
        ]
        [ text "Override Control Panel Hide" ]


overrideInactivityPauseButton : (Msg -> msg) -> Html msg
overrideInactivityPauseButton secretConfigMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg Msg.ToggleInactivityPauseOverride)
        ]
        [ text "Toggle Inactivity Pause" ]


pauseGifRotationButton : (Ports.Msg -> msg) -> Html msg
pauseGifRotationButton portsMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Ports.pauseVideosMsg portsMsg)
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : (Ports.Msg -> msg) -> Html msg
playGifRotationButton portsMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Ports.playVideosMsg portsMsg)
        ]
        [ text "Play Gif Rotation" ]


playAudioButton : (Ports.Msg -> msg) -> Html msg
playAudioButton portsMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Ports.playAudioMsg portsMsg)
        ]
        [ text "Play Audio" ]


pauseAudioButton : (Ports.Msg -> msg) -> Html msg
pauseAudioButton portsMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Ports.pauseAudioMsg portsMsg)
        ]
        [ text "Pause Audio" ]
