module SecretConfig.View exposing (Msgs, view)

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


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , controlPanelMsg : ControlPanel.Msg -> msg
        , saveConfigMsg : String -> String -> String -> msg
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
        , onClick (secretConfigMsg Msg.ToggleVisibility)
        ]
        []


secretConfigSettings : Msgs msgs msg -> SecretConfig -> Html msg
secretConfigSettings msgs secretConfig =
    let
        { audioPlayerMsg, secretConfigMsg, videoPlayerMsg } =
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
        , onClick (VideoPlayer.pauseVideosMsg videoPlayerMsg)
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : (VideoPlayer.Msg -> msg) -> Html msg
playGifRotationButton videoPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (VideoPlayer.playVideosMsg videoPlayerMsg)
        ]
        [ text "Play Gif Rotation" ]


playAudioButton : (AudioPlayer.Msg -> msg) -> Html msg
playAudioButton audioPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (AudioPlayer.playAudioMsg audioPlayerMsg)
        ]
        [ text "Play Audio" ]


pauseAudioButton : (AudioPlayer.Msg -> msg) -> Html msg
pauseAudioButton audioPlayerMsg =
    button
        [ css [ Styles.configButton ]
        , onClick (AudioPlayer.pauseAudioMsg audioPlayerMsg)
        ]
        [ text "Pause Audio" ]
