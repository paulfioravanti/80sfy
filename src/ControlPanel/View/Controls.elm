module ControlPanel.View.Controls exposing (view)

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.View.Styled as Styled
import Html.Styled exposing (Html)
import Html.Styled.Attributes exposing (attribute, class)
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
    Styled.controls
        [ attribute "data-name" "controls" ]
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
    Styled.controlButton
        [ attribute "data-name" "mute-unmute"
        , onClick (audioPlayerMsg AudioPlayer.toggleMuteMsg)
        ]
        [ Styled.iconBackground [] []
        , Styled.icon [ class iconClass ] []
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
    Styled.controlButton
        [ attribute "data-name" "play-pause"
        , onClick playPauseMsg
        ]
        [ Styled.iconBackground [] []
        , Styled.icon [ class iconClass ] []
        ]


nextTrackButton : ParentMsgs msgs msg -> Html msg
nextTrackButton { audioPlayerMsg } =
    Styled.controlButton
        [ attribute "data-name" "next-track"
        , onClick (audioPlayerMsg AudioPlayer.nextTrackMsg)
        ]
        [ Styled.iconBackground [] []
        , Styled.icon [ class "fas fa-fast-forward" ] []
        ]


fullscreenButton : ParentMsgs msgs msg -> Html msg
fullscreenButton { portsMsg } =
    Styled.controlButton
        [ onClick (portsMsg Ports.toggleFullscreenMsg)
        , attribute "data-name" "fullscreen"
        ]
        [ Styled.iconBackground [] []
        , Styled.icon [ class "fas fa-expand-arrows-alt" ] []
        ]
