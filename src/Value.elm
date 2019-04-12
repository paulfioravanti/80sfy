module Value exposing
    ( extractBoolWithDefault
    , extractFloatWithDefault
    , extractIntWithDefault
    , extractStringWithDefault
    )

import Json.Decode as Decode exposing (Value, bool, float, int, string)


extractBoolWithDefault : Bool -> Value -> Bool
extractBoolWithDefault defaultBool value =
    value
        |> Decode.decodeValue bool
        |> Result.withDefault defaultBool


extractFloatWithDefault : Float -> Value -> Float
extractFloatWithDefault defaultFloat value =
    value
        |> Decode.decodeValue float
        |> Result.withDefault defaultFloat


extractIntWithDefault : Int -> Value -> Int
extractIntWithDefault defaultInt value =
    value
        |> Decode.decodeValue int
        |> Result.withDefault defaultInt


extractStringWithDefault : String -> Value -> String
extractStringWithDefault defaultString value =
    value
        |> Decode.decodeValue string
        |> Result.withDefault defaultString
