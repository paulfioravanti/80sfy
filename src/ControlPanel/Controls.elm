module ControlPanel.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Styles as Styles
import Html.Styled as Html exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)


view : AudioPlayer -> Html msg
view { playing } =
    div [ css [ Styles.controls ], attribute "data-name" "controls" ]
        [ muteUnmuteButton
        , playPauseButton playing
        , nextTrackButton
        , fullscreenButton
        ]


fullscreenButton : Html msg
fullscreenButton =
    div [ css [ Styles.button ], attribute "data-name" "fullscreen" ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]


muteUnmuteButton : Html msg
muteUnmuteButton =
    div [ css [ Styles.button ], attribute "data-name" "mute-unmute" ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-volume-up" ] []
        ]


nextTrackButton : Html msg
nextTrackButton =
    div [ css [ Styles.button ], attribute "data-name" "next-track" ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-fast-forward" ] []
        ]


playPauseButton : Bool -> Html msg
playPauseButton playing =
    let
        iconClass =
            if playing then
                "fas fa-pause"
            else
                "fas fa-play"
    in
        div [ css [ Styles.button ], attribute "data-name" "play-pause" ]
            [ div [ css [ Styles.iconBackground ] ] []
            , i [ css [ Styles.icon ], class iconClass ] []
            ]
