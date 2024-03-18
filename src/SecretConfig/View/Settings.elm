module SecretConfig.View.Settings exposing (view)

import ControlPanel
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (attribute, value)
import Html.Styled.Events exposing (onClick, onInput)
import Ports
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SecretConfig.View.ParentMsgs exposing (ParentMsgs)
import SecretConfig.View.Styled as Styled


view : ParentMsgs msgs msg -> SecretConfig -> Html msg
view parentMsgs secretConfig =
    let
        { portsMsg, secretConfigMsg } =
            parentMsgs
    in
    Styled.secretConfig secretConfig.visible
        [ attribute "data-name" "secret-config-settings" ]
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
    Styled.gifTags
        [ attribute "data-name" "search-tags"
        , onInput (Msg.updateTagsField secretConfigMsg)
        ]
        [ text rawTags ]


soundCloudPlaylistUrlInput : (Msg -> msg) -> String -> Html msg
soundCloudPlaylistUrlInput secretConfigMsg rawSoundCloudPlaylistUrl =
    Styled.configInput
        [ attribute "data-name" "playlist-input"
        , value rawSoundCloudPlaylistUrl
        , onInput (Msg.updateSoundCloudPlaylistUrlField secretConfigMsg)
        ]
        []


gifDisplaySecondsInput : (Msg -> msg) -> String -> Html msg
gifDisplaySecondsInput secretConfigMsg rawGifDisplayIntervalSeconds =
    Styled.configInput
        [ attribute "data-name" "gif-display-seconds-input"
        , value rawGifDisplayIntervalSeconds
        , onInput (Msg.updateGifDisplaySecondsField secretConfigMsg)
        ]
        []


saveSettingsButton : (Msg -> msg) -> Html msg
saveSettingsButton secretConfigMsg =
    Styled.configButton
        [ onClick (secretConfigMsg Msg.Save) ]
        [ text "Save Settings" ]


showStateButton : msg -> Html msg
showStateButton showApplicationStateMsg =
    Styled.configButton
        [ onClick showApplicationStateMsg ]
        [ text "Show State" ]


overrideControlPanelHideButton : (ControlPanel.Msg -> msg) -> Html msg
overrideControlPanelHideButton controlPanelMsg =
    Styled.configButton
        [ onClick (controlPanelMsg ControlPanel.toggleHideWhenInactiveMsg) ]
        [ text "Override Control Panel Hide" ]


overrideInactivityPauseButton : (Msg -> msg) -> Html msg
overrideInactivityPauseButton secretConfigMsg =
    Styled.configButton
        [ onClick (secretConfigMsg Msg.ToggleInactivityPauseOverride) ]
        [ text "Toggle Inactivity Pause" ]


pauseGifRotationButton : (Ports.Msg -> msg) -> Html msg
pauseGifRotationButton portsMsg =
    Styled.configButton
        [ onClick (portsMsg Ports.pauseVideosMsg) ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : (Ports.Msg -> msg) -> Html msg
playGifRotationButton portsMsg =
    Styled.configButton
        [ onClick (portsMsg Ports.playVideosMsg) ]
        [ text "Play Gif Rotation" ]


playAudioButton : (Ports.Msg -> msg) -> Html msg
playAudioButton portsMsg =
    Styled.configButton
        [ onClick (portsMsg Ports.playAudioMsg) ]
        [ text "Play Audio" ]


pauseAudioButton : (Ports.Msg -> msg) -> Html msg
pauseAudioButton portsMsg =
    Styled.configButton
        [ onClick (portsMsg Ports.pauseAudioMsg) ]
        [ text "Pause Audio" ]
