module SecretConfig.View.ParentMsgs exposing (ParentMsgs)

import ControlPanel
import Ports
import SecretConfig.Msg exposing (Msg)


type alias ParentMsgs msgs msg =
    { msgs
        | controlPanelMsg : ControlPanel.Msg -> msg
        , portsMsg : Ports.Msg -> msg
        , secretConfigMsg : Msg -> msg
        , showApplicationStateMsg : msg
    }
