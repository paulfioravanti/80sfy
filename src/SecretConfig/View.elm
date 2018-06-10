module SecretConfig.View exposing (view)

import AudioPlayer
import Config.Msg exposing (Msg(SaveConfig))
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
import MsgRouter exposing (MsgRouter)
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
secretConfigSettings msgRouter { soundCloudPlaylistUrl, tags, visible } =
    div
        [ css [ Styles.secretConfig visible ]
        , attribute "data-name" "secret-config-settings"
        ]
        [ span []
            [ text "Tags:" ]
        , gifTagsInput msgRouter tags
        , span []
            [ text "Playlist:" ]
        , soundCloudPlaylistUrlInput msgRouter soundCloudPlaylistUrl
        , saveSettingsButton msgRouter soundCloudPlaylistUrl tags
        , showStateButton
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
        [ css [ Styles.playlist ]
        , attribute "data-name" "playlist-input"
        , value soundCloudPlaylistUrl
        , onInput (secretConfigMsg << UpdateSoundCloudPlaylistUrl)
        ]
        []


saveSettingsButton : MsgRouter msg -> String -> String -> Html msg
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


overrideInactivityPauseButton : MsgRouter msg -> Html msg
overrideInactivityPauseButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg ToggleInactivityPause)
        ]
        [ text "Override Inactivity Pause" ]


pauseGifRotationButton : MsgRouter msg -> Html msg
pauseGifRotationButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg (ToggleGifRotation False))
        ]
        [ text "Pause Gif Rotation" ]


playGifRotationButton : MsgRouter msg -> Html msg
playGifRotationButton { secretConfigMsg } =
    button
        [ css [ Styles.configButton ]
        , onClick (secretConfigMsg (ToggleGifRotation True))
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
