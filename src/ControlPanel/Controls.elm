module ControlPanel.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Styles as Styles
import Html.Styled as Html exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)
import Msg exposing (Msg(AudioPlayerMsg, ToggleFullScreen))


view : AudioPlayer -> Html Msg.Msg
view { muted, playing } =
    div [ css [ Styles.controls ], attribute "data-name" "controls" ]
        [ muteUnmuteButton muted
        , playPauseButton playing
        , nextTrackButton
        , fullscreenButton
        ]


fullscreenButton : Html Msg.Msg
fullscreenButton =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "fullscreen"
        , onClick ToggleFullScreen
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]


muteUnmuteButton : Bool -> Html Msg.Msg
muteUnmuteButton muted =
    let
        iconClass =
            if muted then
                "fas fa-volume-off"
            else
                "fas fa-volume-up"
    in
        div
            [ css [ Styles.button ]
            , attribute "data-name" "mute-unmute"
            , onClick (AudioPlayerMsg AudioPlayer.toggleMuteMsg)
            ]
            [ div [ css [ Styles.iconBackground ] ] []
            , i [ css [ Styles.icon ], class iconClass ] []
            ]


nextTrackButton : Html msg
nextTrackButton =
    div [ css [ Styles.button ], attribute "data-name" "next-track" ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-fast-forward" ] []
        ]


playPauseButton : Bool -> Html Msg.Msg
playPauseButton playing =
    let
        iconClass =
            if playing then
                "fas fa-pause"
            else
                "fas fa-play"
    in
        div
            [ css [ Styles.button ]
            , attribute "data-name" "play-pause"
            , onClick (AudioPlayerMsg AudioPlayer.togglePlayPauseMsg)
            ]
            [ div [ css [ Styles.iconBackground ] ] []
            , i [ css [ Styles.icon ], class iconClass ] []
            ]
