module Value exposing
    ( extractBoolWithDefault
    , extractFloatWithDefault
    , extractIntWithDefault
    , extractStringWithDefault
    )

import Json.Decode as Decode exposing (Decoder, Value, bool, float, int, string)


extractBoolWithDefault : Bool -> Value -> Bool
extractBoolWithDefault defaultBool value =
    value
        |> extractTypeFromValueWithDefault bool defaultBool


extractFloatWithDefault : Float -> Value -> Float
extractFloatWithDefault defaultFloat value =
    value
        |> extractTypeFromValueWithDefault float defaultFloat


extractIntWithDefault : Int -> Value -> Int
extractIntWithDefault defaultInt value =
    value
        |> extractTypeFromValueWithDefault int defaultInt


extractStringWithDefault : String -> Value -> String
extractStringWithDefault defaultString value =
    value
        |> extractTypeFromValueWithDefault string defaultString



-- PRIVATE


extractTypeFromValueWithDefault : Decoder a -> a -> Value -> a
extractTypeFromValueWithDefault decoder default value =
    value
        |> Decode.decodeValue decoder
        |> Result.withDefault default
