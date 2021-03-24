module Value exposing
    ( extractFloatWithDefault
    , extractIntWithDefault
    , extractStringWithDefault
    )

import Json.Decode as Decode exposing (Decoder, Value)


extractFloatWithDefault : Float -> Value -> Float
extractFloatWithDefault defaultFloat value =
    extractTypeFromValueWithDefault Decode.float defaultFloat value


extractIntWithDefault : Int -> Value -> Int
extractIntWithDefault defaultInt value =
    extractTypeFromValueWithDefault Decode.int defaultInt value


extractStringWithDefault : String -> Value -> String
extractStringWithDefault defaultString value =
    extractTypeFromValueWithDefault Decode.string defaultString value



-- PRIVATE


extractTypeFromValueWithDefault : Decoder a -> a -> Value -> a
extractTypeFromValueWithDefault decoder default value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault default
