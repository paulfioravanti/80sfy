module AudioPlayer.MsgConfig exposing (MsgConfig, init)

import AudioPlayer.Msg
import VideoPlayer.Msg


type alias MsgConfig msg =
    { audioPlayerMsg : AudioPlayer.Msg.Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (AudioPlayer.Msg.Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgConfig msg
init audioPlayerMsg videoPlayerMsg =
    { audioPlayerMsg = audioPlayerMsg
    , videoPlayerMsg = videoPlayerMsg
    }
