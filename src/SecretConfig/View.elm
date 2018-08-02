module SecretConfig.View exposing (view)

import AudioPlayer
import Config.Msg exposing (Msg(SaveConfig))
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
import MsgRouter exposing (MsgRouter)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg
    exposing
        ( Msg
            ( ToggleInactivityPauseOverride
            , ToggleVisibility
            , UpdateGifDisplaySeconds
            , UpdateSoundCloudPlaylistUrl
            , UpdateTags
            )
        )
import SecretConfig.Styles as Styles
import VideoPlayer


view : MsgRouter msg -> SecretConfig -> Html msg
view msgRouter secretConfig =
    div [ attribute "data-name" "secret-config" ]
        [ secretConfigButton msgRouter
        , secretConfigSettings msgRouter secretConfig
        ]


secretConfigButton : MsgRouter msg -> Html msg
secretConfigButton { secretConfigMsg } =
    div
        [ css [ Styles.secretConfigButton ]
        , attribute "data-name" "secret-config-button"
        , onClick (secretConfigMsg ToggleVisibility)
        ]
        []


secretConfigSettings : MsgRouter msg -> SecretConfig -> Html msg
secretConfigSettings msgRouter secretConfig =
    div
        [ css [ Styles.secretConfig secretConfig.visible ]
        , attribute "data-name" "secret-config-settings"
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput msgRouter secretConfig.tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput
            msgRouter
            secretConfig.soundCloudPlaylistUrl
        , span []
            [ text "Gif Display Seconds:" ]
        , gifDisplaySecondsInput msgRouter secretConfig.gifDisplaySeconds
        , saveSettingsButton
            msgRouter
            secretConfig.soundCloudPlaylistUrl
            secretConfig.tags
            secretConfig.gifDisplaySeconds
        , showStateButton msgRouter
        , overrideControlPanelHideButton msgRouter
        , overrideInactivityPauseButton msgRouter
        , pauseGifRotationButton msgRouter
        , playGifRotationButton msgRouter
        , playAudioButton msgRouter
        , pauseAudioButton msgRouter
        ]


gifTagsInput : MsgRouter msg -> String -> Html msg
gifTagsInput { secretConfigMsg } tags =
    textarea
        [ css [ Styles.gifTags ]
        , attribute "data-name" "search-tags"
        , onInput (secretConfigMsg << UpdateTags)
        ]
        [ text tags ]


soundCloudPlaylistUrlInput : MsgRouter msg -> String -> Html msg
soundCloudPlaylistUrlInput { secretConfigMsg } soundCloudPlaylistUrl =
    input
        [ css [ Styles.configInput ]
        , attribute "data-name" "playlist-input"
        , value soundCloudPlaylistUrl
        , onInput (secretConfigMsg << UpdateSoundCloudPlaylistUrl)
        ]
        []


gifDisplaySecondsInput : MsgRouter msg -> String -> Html msg
gifDisplaySecondsInput { secretConfigMsg } gifDisplaySeconds =
    input
        [ css [ Styles.configInput ]
        , attribute "data-name" "gif-display-seconds-input"
        , value gifDisplaySeconds
        , onInput (secretConfigMsg << UpdateGifDisplaySeconds)
        ]
        []


saveSettingsButton : MsgRouter msg -> String -> String -> String -> Html msg
saveSettingsButton { configMsg } soundCloudPlaylistUrl tags gifDisplaySeconds =
    button
        [ css [ Styles.configButton ]
        , onClick
            (configMsg
                (SaveConfig soundCloudPlaylistUrl tags gifDisplaySeconds)
            )
        ]
        [ text "Save Settings" ]


showStateButton : MsgRouter msg -> Html msg
showStateButton { showApplicationState } =
    button
        [ css [ Styles.configButton ]
        , onClick showApplicationState
        ]
        [ text "Show State" ]


overrideControlPanelHideButton : MsgRouter msg -> Html msg
overrideControlPanelHideButton { controlPanelMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (controlPanelMsg ControlPanel.toggleHideWhenInactiveMsg)
        ]
        [ text "Override Control Panel Hide" ]


overrideInactivityPauseButton : MsgRouter msg -> Html msg
overrideInactivityPauseButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg ToggleInactivityPauseOverride)
        ]
        [ text "Toggle Inactivity Pause" ]


pauseGifRotationButton : MsgRouter msg -> Html msg
pauseGifRotationButton { videoPlayerMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (videoPlayerMsg (VideoPlayer.pauseVideosMsg ()))
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : MsgRouter msg -> Html msg
playGifRotationButton { videoPlayerMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (videoPlayerMsg (VideoPlayer.playVideosMsg ()))
        ]
        [ text "Play Gif Rotation" ]


playAudioButton : MsgRouter msg -> Html msg
playAudioButton { audioPlayerMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (audioPlayerMsg AudioPlayer.playAudioMsg)
        ]
        [ text "Play Audio" ]


pauseAudioButton : MsgRouter msg -> Html msg
pauseAudioButton { audioPlayerMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (audioPlayerMsg AudioPlayer.pauseAudioMsg)
        ]
        [ text "Pause Audio" ]
