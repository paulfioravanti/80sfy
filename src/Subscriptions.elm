module Subscriptions exposing (subscriptions)

import AudioPlayer
import ControlPanel
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import VideoPlayer


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        { audioPlayer, config, controlPanel, secretConfig, videoPlayer1 } =
            model

        parentMsgs =
            { audioPausedMsg = Msg.audioPaused
            , audioPlayerMsg = Msg.audioPlayer
            , audioPlayingMsg = Msg.audioPlaying
            , noOpMsg = Msg.noOp
            , portsMsg = Msg.ports
            , videoPlayerMsg = Msg.videoPlayer
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
