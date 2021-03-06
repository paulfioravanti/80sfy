module ControlPanel.View.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.View.Styles as Styles
import Html.Styled exposing (Html, div, i)
import Html.Styled.Attributes exposing (attribute, class, css)
import Html.Styled.Events exposing (onClick)
import Ports


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , pauseMsg : msg
        , portsMsg : Ports.Msg -> msg
    }


type alias Context a =
    { a | audioPlayer : AudioPlayer }


view : ParentMsgs msgs msg -> Context a -> Html msg
view parentMsgs { audioPlayer } =
    let
        muted : Bool
        muted =
            AudioPlayer.isMuted audioPlayer

        playing : Bool
        playing =
            AudioPlayer.isPlaying audioPlayer
    in
    div
        [ css [ Styles.controls ]
        , attribute "data-name" "controls"
        ]
        [ muteUnmuteButton parentMsgs muted
        , playPauseButton parentMsgs playing
        , nextTrackButton parentMsgs
        , fullscreenButton parentMsgs
        ]



-- PRIVATE


muteUnmuteButton : ParentMsgs msgs msg -> Bool -> Html msg
muteUnmuteButton { audioPlayerMsg } muted =
    let
        iconClass : String
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


playPauseButton : ParentMsgs msgs msg -> Bool -> Html msg
playPauseButton { pauseMsg, portsMsg } playing =
    let
        ( iconClass, playPauseMsg ) =
            if playing then
                ( "fas fa-pause", pauseMsg )

            else
                ( "fas fa-play", portsMsg Ports.playMsg )
    in
    div
        [ css [ Styles.button ]
        , attribute "data-name" "play-pause"
        , onClick playPauseMsg
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class iconClass ] []
        ]


nextTrackButton : ParentMsgs msgs msg -> Html msg
nextTrackButton { audioPlayerMsg } =
    div
        [ css [ Styles.button ]
        , attribute "data-name" "next-track"
        , onClick (audioPlayerMsg AudioPlayer.nextTrackMsg)
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-fast-forward" ] []
        ]


fullscreenButton : ParentMsgs msgs msg -> Html msg
fullscreenButton { portsMsg } =
    div
        [ onClick (portsMsg Ports.toggleFullscreenMsg)
        , css [ Styles.button ]
        , attribute "data-name" "fullscreen"
        ]
        [ div [ css [ Styles.iconBackground ] ] []
        , i [ css [ Styles.icon ], class "fas fa-expand-arrows-alt" ] []
        ]
