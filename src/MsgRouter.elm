module MsgRouter exposing (MsgRouter)

import AudioPlayer.Msg as AudioPlayerMsg
import Config.Msg as ConfigMsg
import ControlPanel.Msg as ControlPanelMsg
import FullScreen.Msg as FullScreenMsg
import Key.Model exposing (Key)
import SecretConfig.Msg as SecretConfigMsg
import VideoPlayer.Msg as VideoPlayerMsg


type alias MsgRouter msg =
    { audioPlayerMsg : AudioPlayerMsg.Msg -> msg
    , configMsg : ConfigMsg.Msg -> msg
    , controlPanelMsg : ControlPanelMsg.Msg -> msg
    , fullScreenMsg : FullScreenMsg.Msg -> msg
    , keyMsg : Key -> msg
    , noOpMsg : msg
    , pauseMsg : msg
    , playMsg : msg
    , secretConfigMsg : SecretConfigMsg.Msg -> msg
    , showApplicationState : msg
    , videoPlayerMsg : VideoPlayerMsg.Msg -> msg
    }
