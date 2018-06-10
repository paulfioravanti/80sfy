module ControlPanel.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Styles as Styles
import Html.Styled as Html exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)
import MsgRouter exposing (MsgRouter)
import VideoPlayer


view : MsgRouter msg -> AudioPlayer -> Html msg
view msgRouter { muted, playing } =
    div [ css [ Styles.controls ], attribute "data-name" "controls" ]
        [ muteUnmuteButton msgRouter muted
        , playPauseButton msgRouter playing
        , nextTrackButton
        , fullscreenButton msgRouter
        ]


muteUnmuteButton : MsgRouter msg -> Bool -> Html msg
muteUnmuteButton { audioPlayerMsg } muted =
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
            , onClick (audioPlayerMsg AudioPlayer.toggleMuteMsg)
            ]
            [ div [ css [ Styles.iconBackground ] ] []
            , i [ css [ Styles.icon ], class iconClass ] []
            ]


playPauseButton : MsgRouter msg -> Bool -> Html msg
playPauseButton { audioPlayerMsg } playing =
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
            , onClick (audioPlayerMsg AudioPlayer.togglePlayPauseMsg)
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


fullscreenButton : MsgRouter msg -> Html msg
fullscreenButton { videoPlayerMsg } =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "fullscreen"
        , onClick (videoPlayerMsg VideoPlayer.toggleFullScreenMsg)
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]
