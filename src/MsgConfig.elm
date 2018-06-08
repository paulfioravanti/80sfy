module MsgConfig exposing (MsgConfig, init)

import SecretConfig.Msg
import VideoPlayer.Msg


type alias MsgConfig msg =
    { secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (SecretConfig.Msg.Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgConfig msg
init secretConfigMsg videoPlayerMsg =
    { secretConfigMsg = secretConfigMsg
    , videoPlayerMsg = videoPlayerMsg
    }
