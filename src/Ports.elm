port module Ports exposing (consoleLog)

import Json.Encode exposing (Value)


port consoleLog : Value -> Cmd msg
