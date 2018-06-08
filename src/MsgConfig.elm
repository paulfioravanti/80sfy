module MsgConfig exposing (MsgConfig, init)

import AudioPlayer
import Config.Msg
import ControlPanel.Msg
import SecretConfig.Msg
import VideoPlayer.Msg


type alias MsgConfig msg =
    { audioPlayerMsg : AudioPlayer.Msg -> msg
    , configMsg : Config.Msg.Msg -> msg
    , controlPanelMsg : ControlPanel.Msg.Msg -> msg
    , secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (AudioPlayer.Msg -> msg)
    -> (Config.Msg.Msg -> msg)
    -> (ControlPanel.Msg.Msg -> msg)
    -> (SecretConfig.Msg.Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgConfig msg
init audioPlayerMsg configMsg controlPanelMsg secretConfigMsg videoPlayerMsg =
    { audioPlayerMsg = audioPlayerMsg
    , configMsg = configMsg
    , controlPanelMsg = controlPanelMsg
    , secretConfigMsg = secretConfigMsg
    , videoPlayerMsg = videoPlayerMsg
    }
