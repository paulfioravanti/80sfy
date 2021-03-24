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
        |> Result.withDefault (PortMessage "" Encode.null)


withTag : String -> Value
withTag tag =
    withTaggedPayload ( tag, Encode.null )


withTaggedPayload : ( String, Value ) -> Value
withTaggedPayload ( tag, payload ) =
    Encode.object
        [ ( "tag", Encode.string tag )
        , ( "payload", payload )
        ]



-- PRIVATE


decoder : Decoder PortMessage
decoder =
    Decode.succeed PortMessage
        |> Pipeline.required "tag" Decode.string
        |> Pipeline.optional "payload" Decode.value Encode.null
