module AudioPlayer.Config exposing (Config, init)

import AudioPlayer.Msg
import VideoPlayer.Msg


type alias Config msg =
    { audioPlayerMsg : AudioPlayer.Msg.Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (AudioPlayer.Msg.Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> Config msg
init audioPlayerMsg videoPlayerMsg =
    { audioPlayerMsg = audioPlayerMsg
    , videoPlayerMsg = videoPlayerMsg
    }
