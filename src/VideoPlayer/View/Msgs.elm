module VideoPlayer.View.Msgs exposing (Msgs)

import Ports


type alias Msgs msgs msg =
    { msgs
        | noOpMsg : msg
        , portsMsg : Ports.Msg -> msg
    }
