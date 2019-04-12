module ControlPanel.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (BrowserVendor)
import ControlPanel.Styles as Styles
import FullScreen
import Html.Styled exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)


view :
    (AudioPlayer.Msg -> msg)
    -> (FullScreen.Msg -> msg)
    -> msg
    -> msg
    -> BrowserVendor
    -> AudioPlayer
    -> Html msg
view audioPlayerMsg fullScreenMsg pauseMsg playMsg browserVendor audioPlayer =
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
        [ muteUnmuteButton audioPlayerMsg muted
        , playPauseButton pauseMsg playMsg playing
        , nextTrackButton audioPlayerMsg
        , fullscreenButton fullScreenMsg browserVendor
        ]


muteUnmuteButton : (AudioPlayer.Msg -> msg) -> Bool -> Html msg
muteUnmuteButton audioPlayerMsg muted =
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


playPauseButton : msg -> msg -> Bool -> Html msg
playPauseButton pauseMsg playMsg playing =
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


nextTrackButton : (AudioPlayer.Msg -> msg) -> Html msg
nextTrackButton audioPlayerMsg =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "next-track"
        , onClick (audioPlayerMsg AudioPlayer.nextTrackMsg)
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-fast-forward" ] []
        ]


fullscreenButton : (FullScreen.Msg -> msg) -> BrowserVendor -> Html msg
fullscreenButton fullScreenMsg browserVendor =
    let
        onClickAttribute =
            if browserVendor == BrowserVendor.Mozilla then
                attribute "onClick" "window.mozFullScreenToggleHack()"

            else
                onClick (fullScreenMsg FullScreen.performFullScreenToggleMsg)
    in
    div
        [ onClickAttribute
        , css [ Styles.button ]
        , attribute "data-name" "fullscreen"
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]
