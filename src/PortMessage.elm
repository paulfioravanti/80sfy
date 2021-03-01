module PortMessage exposing (PortMessage, decode, new, withPayload)

import Json.Decode as Decode exposing (Decoder, Value, string, value)
import Json.Decode.Pipeline exposing (required)
import Json.Encode exposing (Value, null)


type alias PortMessage =
    { tag : String
    , payload : Value
    }


decode : Value -> PortMessage
decode value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault (new "")


new : String -> PortMessage
new tag =
    { tag = tag
    , payload = null
    }


withPayload : Value -> PortMessage -> PortMessage
withPayload payload portMessage =
    { portMessage | payload = payload }



-- PRIVATE


decoder : Decoder PortMessage
decoder =
    Decode.succeed PortMessage
        |> required "tag" string
        |> required "payload" value
