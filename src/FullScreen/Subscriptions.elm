port module FullScreen.Subscriptions exposing (subscriptions)

import FullScreen.Msg as Msg exposing (Msg)
import Json.Decode as Decode exposing (Value)


port toggleFullScreen : (Value -> msg) -> Sub msg


subscriptions : (Msg -> msg) -> Sub msg
subscriptions fullScreenMsg =
    toggleFullScreen
        (\isFullScreenFlag ->
            if extractBoolValue isFullScreenFlag then
                fullScreenMsg Msg.LeaveFullScreen

            else
                fullScreenMsg Msg.EnterFullScreen
        )


extractBoolValue : Value -> Bool
extractBoolValue boolFlag =
    boolFlag
        |> Decode.decodeValue Decode.bool
        |> Result.withDefault False
