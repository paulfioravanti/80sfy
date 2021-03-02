module PortMessage exposing (PortMessage, decode, withTag, withTaggedPayload)

import Json.Decode as Decode exposing (Decoder, Value)
import Json.Decode.Pipeline as Pipeline
import Json.Encode as Encode exposing (Value)


type alias PortMessage =
    { tag : String
    , payload : Value
    }


decode : Value -> PortMessage
decode value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault (withTag "")


withTag : String -> PortMessage
withTag tag =
    { tag = tag
    , payload = Encode.null
    }


withTaggedPayload : ( String, Value ) -> PortMessage
withTaggedPayload ( tag, payload ) =
    { tag = tag
    , payload = payload
    }



-- PRIVATE


decoder : Decoder PortMessage
decoder =
    Decode.succeed PortMessage
        |> Pipeline.required "tag" Decode.string
        |> Pipeline.required "payload" Decode.value
