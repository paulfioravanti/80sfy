module Config.View.ParentMsgs exposing (ParentMsgs)

import Config.Msg exposing (Msg)
import ControlPanel
import Ports


type alias ParentMsgs msgs msg =
    { msgs
        | configMsg : Msg -> msg
        , controlPanelMsg : ControlPanel.Msg -> msg
        , portsMsg : Ports.Msg -> msg
        , showApplicationStateMsg : msg
    }
