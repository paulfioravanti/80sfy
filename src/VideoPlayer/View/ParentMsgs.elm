module VideoPlayer.View.ParentMsgs exposing (ParentMsgs)

import Ports


type alias ParentMsgs msgs msg =
    { msgs
        | noOpMsg : msg
        , portsMsg : Ports.Msg -> msg
    }
