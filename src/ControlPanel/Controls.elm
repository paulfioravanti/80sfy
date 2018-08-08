module ControlPanel.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import Browser
import ControlPanel.Styles as Styles
import Html.Styled exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)
import MsgRouter exposing (MsgRouter)


view : MsgRouter msg -> AudioPlayer -> Html msg
view msgRouter audioPlayer =
    let
        muted =
            AudioPlayer.isMuted audioPlayer

        playing =
            AudioPlayer.isPlaying audioPlayer
    in
        div
            [ css [ Styles.controls ]
            , attribute "data-name" "controls"
            ]
            [ muteUnmuteButton msgRouter muted
            , playPauseButton msgRouter playing
            , nextTrackButton msgRouter
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
playPauseButton { pauseMsg, playMsg } playing =
    let
        ( iconClass, playPauseMsg ) =
            if playing then
                ( "fas fa-pause", pauseMsg )
            else
                ( "fas fa-play", playMsg )
    in
        div
            [ css [ Styles.button ]
            , attribute "data-name" "play-pause"
            , onClick playPauseMsg
            ]
            [ div [ css [ Styles.iconBackground ] ] []
            , i [ css [ Styles.icon ], class iconClass ] []
            ]


nextTrackButton : MsgRouter msg -> Html msg
nextTrackButton { audioPlayerMsg } =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "next-track"
        , onClick (audioPlayerMsg AudioPlayer.nextTrackMsg)
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-fast-forward" ] []
        ]


fullscreenButton : MsgRouter msg -> Html msg
fullscreenButton { browserMsg } =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "fullscreen"
        , onClick (browserMsg Browser.performFullScreenToggleMsg)
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]
