module MsgRouter exposing (MsgRouter)

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
    , noOpMsg : msg
    , pauseMsg : msg
    , playMsg : msg
    , secretConfigMsg : SecretConfig.Msg.Msg -> msg
    , showApplicationState : msg
    , videoPlayerMsg : VideoPlayer.Msg.Msg -> msg
    }
