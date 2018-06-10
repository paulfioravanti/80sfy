port module AudioPlayer.Subscriptions exposing (subscriptions)

import AudioPlayer.Msg exposing (Msg(PauseAudio, PlayAudio))
import AudioPlayer.Model exposing (AudioPlayer)
import MsgRouter exposing (MsgRouter)


port pauseAudioPlayer : (() -> msg) -> Sub msg


port playAudioPlayer : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions { audioPlayerMsg } audioPlayer =
    let
        playingSubscription =
            if audioPlayer.playing then
                pauseAudioPlayer (always (audioPlayerMsg (PauseAudio False)))
            else
                playAudioPlayer (always (audioPlayerMsg (PlayAudio False)))
    in
        playingSubscription
