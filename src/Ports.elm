port module Ports exposing (inbound, log, outbound)

import Json.Encode exposing (Value)
import PortMessage exposing (PortMessage)


port inbound : (Value -> msg) -> Sub msg


port outbound : PortMessage -> Cmd msg


log : Value -> Cmd msg
log payload =
    outbound (PortMessage.withTaggedPayload ( "LOG", payload ))
