module MsgRouter exposing (MsgRouter, init)

import AudioPlayer.Msg
import Config.Msg
import ControlPanel.Msg
import Keyboard exposing (KeyCode)
import SecretConfig.Msg
import VideoPlayer.Msg


type alias MsgRouter msg =
    { audioPlayerMsg : AudioPlayer.Msg.Msg -> msg
    , configMsg : Config.Msg.Msg -> msg
    , controlPanelMsg : ControlPanel.Msg.Msg -> msg
    , keyMsg : KeyCode -> msg
    , pauseMsg : () -> msg
    , playMsg : () -> msg
    , secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , showApplicationState : msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }


init :
    (AudioPlayer.Msg.Msg -> msg)
    -> (Config.Msg.Msg -> msg)
    -> (ControlPanel.Msg.Msg -> msg)
    -> (KeyCode -> msg)
    -> (() -> msg)
    -> (() -> msg)
    -> (SecretConfig.Msg.Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg.Msg -> msg)
    -> MsgRouter msg
init audioPlayerMsg configMsg controlPanelMsg keyMsg pauseMsg playMsg secretConfigMsg showApplicationState videoPlayerMsg =
    { audioPlayerMsg = audioPlayerMsg
    , configMsg = configMsg
    , controlPanelMsg = controlPanelMsg
    , keyMsg = keyMsg
    , pauseMsg = pauseMsg
    , playMsg = playMsg
    , secretConfigMsg = secretConfigMsg
    , showApplicationState = showApplicationState
    , videoPlayerMsg = videoPlayerMsg
    }
