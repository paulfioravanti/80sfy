module SecretConfig.View exposing (Msgs, view)

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
import Port
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SecretConfig.Styles as Styles
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)
import VideoPlayer


type alias Msgs msgs msg =
    { msgs
        | controlPanelMsg : ControlPanel.Msg -> msg
        , portMsg : Port.Msg -> msg
        , saveConfigMsg :
            SoundCloudPlaylistUrl
            -> TagsString
            -> GifDisplayIntervalSeconds
            -> msg
        , secretConfigMsg : Msg -> msg
        , showApplicationStateMsg : msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


view : Msgs msgs msg -> SecretConfig -> Html msg
view ({ secretConfigMsg } as msgs) secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton secretConfigMsg
        , secretConfigSettings msgs secretConfig
        ]



-- PRIVATE


secretConfigButton : (Msg -> msg) -> Html msg
secretConfigButton secretConfigMsg =
    div
        [ attribute "data-name" "secret-config-button"
        , css [ Styles.secretConfigButton ]
        , onClick (Msg.toggleVisibility secretConfigMsg)
        ]
        []


secretConfigSettings : Msgs msgs msg -> SecretConfig -> Html msg
secretConfigSettings msgs secretConfig =
    let
        { portMsg, secretConfigMsg } =
            msgs
    in
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
        , saveSettingsButton msgs.saveConfigMsg secretConfig
        , showStateButton msgs.showApplicationStateMsg
        , overrideControlPanelHideButton msgs.controlPanelMsg
        , overrideInactivityPauseButton secretConfigMsg
        , pauseGifRotationButton portMsg
        , playGifRotationButton portMsg
        , playAudioButton portMsg
        , pauseAudioButton portMsg
        ]


gifTagsInput : (Msg -> msg) -> TagsString -> Html msg
gifTagsInput secretConfigMsg tags =
    let
        rawTags =
            Tag.rawTagsString tags
    in
    textarea
        [ attribute "data-name" "search-tags"
        , css [ Styles.gifTags ]
        , onInput (Msg.updateTags secretConfigMsg)
        ]
        [ text rawTags ]


soundCloudPlaylistUrlInput : (Msg -> msg) -> SoundCloudPlaylistUrl -> Html msg
soundCloudPlaylistUrlInput secretConfigMsg soundCloudPlaylistUrl =
    let
        playlistUrl =
            SoundCloud.rawPlaylistUrl soundCloudPlaylistUrl
    in
    input
        [ attribute "data-name" "playlist-input"
        , css [ Styles.configInput ]
        , value playlistUrl
        , onInput (Msg.updateSoundCloudPlaylistUrl secretConfigMsg)
        ]
        []


gifDisplaySecondsInput : (Msg -> msg) -> GifDisplayIntervalSeconds -> Html msg
gifDisplaySecondsInput secretConfigMsg gifDisplayIntervalSeconds =
    let
        gifDisplaySeconds =
            gifDisplayIntervalSeconds
                |> Gif.rawDisplayIntervalSeconds
                |> String.fromFloat
    in
    input
        [ attribute "data-name" "gif-display-seconds-input"
        , css [ Styles.configInput ]
        , value gifDisplaySeconds
        , onInput (Msg.updateGifDisplaySeconds secretConfigMsg)
        ]
        []


saveSettingsButton :
    (SoundCloudPlaylistUrl -> TagsString -> GifDisplayIntervalSeconds -> msg)
    -> SecretConfig
    -> Html msg
saveSettingsButton saveConfigMsg secretConfig =
    let
        saveConfig =
            saveConfigMsg
                secretConfig.soundCloudPlaylistUrl
                secretConfig.tags
                secretConfig.gifDisplaySeconds
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
overrideInactivityPauseButton secretConfigMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Msg.toggleInactivityPauseOverride secretConfigMsg)
        ]
        [ text "Toggle Inactivity Pause" ]


pauseGifRotationButton : (Port.Msg -> msg) -> Html msg
pauseGifRotationButton portMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Port.pauseVideosMsg portMsg)
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : (Port.Msg -> msg) -> Html msg
playGifRotationButton portMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Port.playVideosMsg portMsg)
        ]
        [ text "Play Gif Rotation" ]


playAudioButton : (Port.Msg -> msg) -> Html msg
playAudioButton portMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Port.playAudioParentMsg portMsg)
        ]
        [ text "Play Audio" ]


pauseAudioButton : (Port.Msg -> msg) -> Html msg
pauseAudioButton portMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (Port.pauseAudioParentMsg portMsg)
        ]
        [ text "Pause Audio" ]
