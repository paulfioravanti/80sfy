port module Ports exposing (log, out)

import Json.Encode exposing (Value)
import PortMessage exposing (PortMessage)


port out : PortMessage -> Cmd msg


log : Value -> Cmd msg
log payload =
    out (PortMessage.withTaggedPayload ( "LOG", payload ))
