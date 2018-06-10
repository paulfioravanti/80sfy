module AudioPlayer.Subscriptions exposing (subscriptions)

-- import AudioPlayer.Msg exposing (Msg(PauseAudio, PlayAudio))

import AudioPlayer.Model exposing (AudioPlayer)
import MsgRouter exposing (MsgRouter)


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions { audioPlayerMsg } audioPlayer =
    Sub.batch
        []
