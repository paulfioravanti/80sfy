module ControlPanel.Controls exposing (view)

import Html.Styled as Html exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Styles


view : Html msg
view =
    div [ css [ Styles.controls ], attribute "data-name" "controls" ]
        [ muteUnmuteButton
        , playPauseButton
        , nextTrackButton
        , fullscreenButton
        ]


fullscreenButton : Html msg
fullscreenButton =
    div [ css [ Styles.controlButton ], attribute "data-name" "fullscreen" ]
        [ div [ css [ Styles.controlIconBackground ] ] []
        , i [ css [ Styles.controlIcon ], class "fas fa-expand-arrows-alt" ] []
        ]


muteUnmuteButton : Html msg
muteUnmuteButton =
    div [ css [ Styles.controlButton ], attribute "data-name" "mute-unmute" ]
        [ div [ css [ Styles.controlIconBackground ] ] []
        , i [ css [ Styles.controlIcon ], class "fas fa-volume-up" ] []
        ]


nextTrackButton : Html msg
nextTrackButton =
    div [ css [ Styles.controlButton ], attribute "data-name" "next-track" ]
        [ div [ css [ Styles.controlIconBackground ] ] []
        , i [ css [ Styles.controlIcon ], class "fas fa-fast-forward" ] []
        ]


playPauseButton : Html msg
playPauseButton =
    div [ css [ Styles.controlButton ], attribute "data-name" "play-pause" ]
        [ div [ css [ Styles.controlIconBackground ] ] []
        , i [ css [ Styles.controlIcon ], class "fas fa-play" ] []
        ]
