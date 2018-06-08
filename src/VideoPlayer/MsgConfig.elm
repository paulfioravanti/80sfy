module VideoPlayer.MsgConfig exposing (MsgConfig, init)

import SecretConfig.Msg
import VideoPlayer.Msg exposing (Msg)


type alias MsgConfig msg =
    { secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , videoPlayerMsg : Msg -> msg
    }


init :
    (SecretConfig.Msg.Msg -> msg)
    -> (Msg -> msg)
    -> MsgConfig msg
init secretConfigMsg videoPlayerMsg =
    { secretConfigMsg = secretConfigMsg
    , videoPlayerMsg = videoPlayerMsg
    }
