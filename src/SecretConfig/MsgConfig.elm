module SecretConfig.MsgConfig exposing (MsgConfig, init)

import SecretConfig.Msg exposing (Msg)
import VideoPlayer.Msg


type alias MsgConfig msg =
    { secretConfigMsg : Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgConfig msg
init secretConfigMsg videoPlayerMsg =
    { secretConfigMsg = secretConfigMsg
    , videoPlayerMsg = videoPlayerMsg
    }
