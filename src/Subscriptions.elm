module Subscriptions exposing (subscriptions)

import AudioPlayer
import ControlPanel
import Key exposing (Key)
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import Time exposing (Posix)
import VideoPlayer exposing (VideoPlayerSubscriptionsContext)


type alias Msgs msgs =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> Msg
        , controlPanelMsg : ControlPanel.Msg -> Msg
        , crossFadePlayersMsg : Posix -> Msg
        , keyPressedMsg : Key -> Msg
        , noOpMsg : Msg
        , portsMsg : Ports.Msg -> Msg
        , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


subscriptions : Msgs msgs -> Model -> Sub Msg
subscriptions msgs model =
    let
        { audioPlayer, controlPanel, secretConfig, videoPlayer1 } =
            model

        videoPlayerContext : VideoPlayerSubscriptionsContext
        videoPlayerContext =
            { rawAudioPlayerId = AudioPlayer.rawId audioPlayer.id
            , gifDisplayIntervalSeconds = secretConfig.gifDisplayIntervalSeconds
            , overrideInactivityPause = secretConfig.overrideInactivityPause
            }
    in
    Sub.batch
        [ AudioPlayer.subscriptions msgs audioPlayer
        , ControlPanel.subscriptions msgs controlPanel
        , Key.subscriptions msgs
        , VideoPlayer.subscriptions msgs videoPlayerContext videoPlayer1
        ]
