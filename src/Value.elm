module Value exposing (extractBool, extractFloat, extractInt, extractString)

import Json.Decode as Decode exposing (Value, bool, float, int, string)


extractBool : Bool -> Value -> Bool
extractBool fallbackBool value =
    value
        |> Decode.decodeValue bool
        |> Result.withDefault fallbackBool


extractFloat : Float -> Value -> Float
extractFloat fallbackFloat value =
    value
        |> Decode.decodeValue float
        |> Result.withDefault fallbackFloat


extractInt : Int -> Value -> Int
extractInt fallbackInt value =
    value
        |> Decode.decodeValue int
        |> Result.withDefault fallbackInt


extractString : String -> Value -> String
extractString fallbackString value =
    value
        |> Decode.decodeValue string
        |> Result.withDefault fallbackString
