port module Ports exposing (fromSoundCloudWidget, log, toSoundCloudWidget)

import Json.Encode exposing (Value)
import PortMessage exposing (PortMessage)


port console : PortMessage -> Cmd msg


port fromSoundCloudWidget : (Value -> msg) -> Sub msg


port toSoundCloudWidget : PortMessage -> Cmd msg


log : Value -> Cmd msg
log payload =
    console (PortMessage.withTaggedPayload ( "LOG", payload ))
