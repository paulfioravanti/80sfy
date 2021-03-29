module SecretConfig.View.Settings exposing (view)

import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
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
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)


view : ParentMsgs msgs msg -> SecretConfig -> Html msg
view parentMsgs secretConfig =
    let
        { portsMsg, configMsg } =
            parentMsgs
    in
    div
        [ attribute "data-name" "secret-config-settings"
        , css [ Styles.secretConfig secretConfig.visible ]
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput configMsg secretConfig.tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput
            configMsg
            secretConfig.soundCloudPlaylistUrl
        , span []
            [ text "Gif Display Seconds:" ]
        , gifDisplaySecondsInput configMsg secretConfig.gifDisplayIntervalSeconds
        , saveSettingsButton parentMsgs.saveConfigMsg secretConfig
        , showStateButton parentMsgs.showApplicationStateMsg
        , overrideControlPanelHideButton parentMsgs.controlPanelMsg
        , overrideInactivityPauseButton configMsg
        , pauseGifRotationButton portsMsg
        , playGifRotationButton portsMsg
        , playAudioButton portsMsg
        , pauseAudioButton portsMsg
        ]


gifTagsInput : (Msg -> msg) -> List Tag -> Html msg
gifTagsInput configMsg tags =
    let
        rawTags : String
        rawTags =
            Tag.rawTagsString tags
    in
    textarea
        [ attribute "data-name" "search-tags"
        , css [ Styles.gifTags ]
        , onInput (Msg.updateTags configMsg)
        ]
        [ text rawTags ]


soundCloudPlaylistUrlInput : (Msg -> msg) -> SoundCloudPlaylistUrl -> Html msg
soundCloudPlaylistUrlInput configMsg soundCloudPlaylistUrl =
    let
        playlistUrl : String
        playlistUrl =
            SoundCloud.rawPlaylistUrl soundCloudPlaylistUrl
    in
    input
        [ attribute "data-name" "playlist-input"
        , css [ Styles.configInput ]
        , value playlistUrl
        , onInput (Msg.updateSoundCloudPlaylistUrl configMsg)
        ]
        []


gifDisplaySecondsInput : (Msg -> msg) -> GifDisplayIntervalSeconds -> Html msg
gifDisplaySecondsInput configMsg gifDisplayIntervalSeconds =
    let
        gifDisplaySeconds : String
        gifDisplaySeconds =
            gifDisplayIntervalSeconds
                |> Gif.rawDisplayIntervalSeconds
                |> String.fromFloat
    in
    input
        [ attribute "data-name" "gif-display-seconds-input"
        , css [ Styles.configInput ]
        , value gifDisplaySeconds
        , onInput (Msg.updateGifDisplaySeconds configMsg)
        ]
        []


saveSettingsButton :
    (SoundCloudPlaylistUrl -> List Tag -> GifDisplayIntervalSeconds -> msg)
    -> SecretConfig
    -> Html msg
saveSettingsButton saveConfigMsg secretConfig =
    let
        saveConfig : msg
        saveConfig =
            saveConfigMsg
                secretConfig.soundCloudPlaylistUrl
                secretConfig.tags
                secretConfig.gifDisplayIntervalSeconds
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
        , onClick (ControlPanel.toggleHideWhenInactiveMsg controlPanelMsg)
        ]
        [ text "Override Control Panel Hide" ]


overrideInactivityPauseButton : (Msg -> msg) -> Html msg
overrideInactivityPauseButton configMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (configMsg Msg.ToggleInactivityPauseOverride)
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
