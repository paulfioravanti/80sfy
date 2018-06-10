module MsgRouter exposing (MsgRouter, init)

import AudioPlayer.Msg
import Config.Msg
import ControlPanel.Msg
import SecretConfig.Msg
import VideoPlayer.Msg


type alias MsgRouter msg =
    { audioPlayerMsg : AudioPlayer.Msg.Msg -> msg
    , configMsg : Config.Msg.Msg -> msg
    , controlPanelMsg : ControlPanel.Msg.Msg -> msg
    , secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (AudioPlayer.Msg.Msg -> msg)
    -> (Config.Msg.Msg -> msg)
    -> (ControlPanel.Msg.Msg -> msg)
    -> (SecretConfig.Msg.Msg -> msg)
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgRouter msg
init audioPlayerMsg configMsg controlPanelMsg secretConfigMsg videoPlayerMsg =
    { audioPlayerMsg = audioPlayerMsg
    , configMsg = configMsg
    , controlPanelMsg = controlPanelMsg
    , secretConfigMsg = secretConfigMsg
    , videoPlayerMsg = videoPlayerMsg
    }
