module MsgConfig exposing (MsgConfig, init)

import Config.Msg
import SecretConfig.Msg
import VideoPlayer.Msg


type alias MsgConfig msg =
    { configMsg : Config.Msg.Msg -> msg
    , secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (Config.Msg.Msg -> msg)
    -> (SecretConfig.Msg.Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgConfig msg
init configMsg secretConfigMsg videoPlayerMsg =
    { configMsg = configMsg
    , secretConfigMsg = secretConfigMsg
    , videoPlayerMsg = videoPlayerMsg
    }
