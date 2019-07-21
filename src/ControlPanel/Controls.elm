module ControlPanel.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (BrowserVendor)
import ControlPanel.Styles as Styles
import Html.Styled exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)


view : Msgs msgs msg -> Context a -> Html msg
view msgs { browserVendor, audioPlayer } =
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
        [ muteUnmuteButton msgs muted
        , playPauseButton msgs playing
        , nextTrackButton msgs
        , fullscreenButton msgs browserVendor
        ]



-- PRIVATE


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , browserVendorMsg : BrowserVendor.Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
    }


type alias Context a =
    { a
        | browserVendor : BrowserVendor
        , audioPlayer : AudioPlayer
    }


muteUnmuteButton : Msgs msgs msg -> Bool -> Html msg
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


playPauseButton : Msgs msgs msg -> Bool -> Html msg
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


nextTrackButton : Msgs msgs msg -> Html msg
nextTrackButton { audioPlayerMsg } =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "next-track"
        , onClick (AudioPlayer.nextTrackMsg audioPlayerMsg)
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-fast-forward" ] []
        ]


fullscreenButton : Msgs msgs msg -> BrowserVendor -> Html msg
fullscreenButton { browserVendorMsg } browserVendor =
    let
        onClickAttribute =
            if browserVendor == BrowserVendor.mozilla then
                attribute "onClick" "window.mozFullScreenToggleHack()"

            else
                onClick
                    (BrowserVendor.performFullScreenToggleMsg browserVendorMsg)
    in
    div
        [ onClickAttribute
        , css [ Styles.button ]
        , attribute "data-name" "fullscreen"
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]
