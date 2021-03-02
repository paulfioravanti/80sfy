port module Ports exposing (log)

import Json.Encode exposing (Value)
import PortMessage exposing (PortMessage)


port console : PortMessage -> Cmd msg


log : Value -> Cmd msg
log payload =
    console (PortMessage.withTaggedPayload ( "LOG", payload ))
