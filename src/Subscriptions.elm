module Subscriptions exposing (subscriptions)

import AudioPlayer
import ControlPanel
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import VideoPlayer


type alias ParentMsgs =
    { audioPausedMsg : Msg
    , audioPlayerMsg : AudioPlayer.Msg -> Msg
    , audioPlayingMsg : Msg
    , noOpMsg : Msg
    , portsMsg : Ports.Msg -> Msg
    , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        { audioPlayer, config, controlPanel, secretConfig, videoPlayer1 } =
            model

        parentMsgs : ParentMsgs
        parentMsgs =
            { audioPausedMsg = Msg.AudioPaused
            , audioPlayerMsg = Msg.AudioPlayer
            , audioPlayingMsg = Msg.AudioPlaying
            , noOpMsg = Msg.NoOp
            , portsMsg = Msg.Ports
            , videoPlayerMsg = Msg.VideoPlayer
            }

        videoPlayerContext =
            { rawAudioPlayerId = AudioPlayer.rawId audioPlayer.id
            , gifDisplayIntervalSeconds = config.gifDisplayIntervalSeconds
            , overrideInactivityPause = secretConfig.overrideInactivityPause
            }
    in
    Sub.batch
        [ AudioPlayer.subscriptions parentMsgs audioPlayer
        , ControlPanel.subscriptions Msg.controlPanel controlPanel
        , Key.subscriptions Msg.keyPressed
        , VideoPlayer.subscriptions parentMsgs videoPlayerContext videoPlayer1
        ]
