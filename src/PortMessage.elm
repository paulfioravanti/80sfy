module PortMessage exposing (PortMessage, new, withPayload)

import Json.Encode exposing (Value, null)


type alias PortMessage =
    { tag : String
    , payload : Value
    }


new : String -> PortMessage
new tag =
    { tag = tag
    , payload = null
    }


withPayload : Value -> PortMessage -> PortMessage
withPayload payload portMessage =
    { portMessage | payload = payload }
