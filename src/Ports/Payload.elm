module Ports.Payload exposing (Payload, decode, withTag, withTaggedData)

import Json.Decode as Decode exposing (Decoder, Value)
import Json.Decode.Pipeline as Pipeline
import Json.Encode as Encode exposing (Value)


type alias Payload =
    { tag : String
    , data : Value
    }


decode : Value -> Payload
decode value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault (Payload "" Encode.null)


withTag : String -> Value
withTag tag =
    withTaggedData ( tag, Encode.null )


withTaggedData : ( String, Value ) -> Value
withTaggedData ( tag, data ) =
    Encode.object
        [ ( "tag", Encode.string tag )
        , ( "data", data )
        ]



-- PRIVATE


decoder : Decoder Payload
decoder =
    Decode.succeed Payload
        |> Pipeline.required "tag" Decode.string
        |> Pipeline.optional "data" Decode.value Encode.null
