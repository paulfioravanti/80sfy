module VideoPlayer.MsgConfig exposing (MsgConfig, init)

import VideoPlayer.Msg exposing (Msg)


type alias MsgConfig msg =
    { videoPlayerMsg : Msg -> msg
    }


init :
    (Msg -> msg)
    -> MsgConfig msg
init videoPlayerMsg =
    { videoPlayerMsg = videoPlayerMsg
    }
