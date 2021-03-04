port module Ports exposing (log, soundCloudWidgetOut)

import Json.Encode exposing (Value)
import PortMessage exposing (PortMessage)


port consoleOut : PortMessage -> Cmd msg


port soundCloudWidgetOut : PortMessage -> Cmd msg


log : Value -> Cmd msg
log payload =
    consoleOut (PortMessage.withTaggedPayload ( "LOG", payload ))
