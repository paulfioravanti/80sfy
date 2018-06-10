port module AudioPlayer.Subscriptions exposing (subscriptions)

import AudioPlayer.Msg
    exposing
        ( Msg
            ( AudioPaused
            , AudioPlayerReady
            , AudioPlaying
            )
        )
import AudioPlayer.Model exposing (AudioPlayer)
import MsgRouter exposing (MsgRouter)


port audioPlayerReady : (() -> msg) -> Sub msg


port pauseAudioPlayer : (() -> msg) -> Sub msg


port playAudioPlayer : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions { audioPlayerMsg } audioPlayer =
    let
        playingSubscription =
            if audioPlayer.playing then
                pauseAudioPlayer (always (audioPlayerMsg AudioPaused))
            else
                playAudioPlayer (always (audioPlayerMsg AudioPlaying))
    in
        Sub.batch
            [ playingSubscription
            , audioPlayerReady (always (audioPlayerMsg AudioPlayerReady))
            ]
