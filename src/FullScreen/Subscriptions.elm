port module FullScreen.Subscriptions exposing (subscriptions)

import FullScreen.Msg exposing (Msg(EnterFullScreen, LeaveFullScreen))
import Json.Decode as Decode exposing (Value)
import MsgRouter exposing (MsgRouter)


port toggleFullScreen : (Value -> msg) -> Sub msg


subscriptions : MsgRouter msg -> Sub msg
subscriptions { fullScreenMsg } =
    toggleFullScreen
        (\isFullScreenFlag ->
            if extractBoolValue isFullScreenFlag then
                fullScreenMsg LeaveFullScreen
            else
                fullScreenMsg EnterFullScreen
        )


extractBoolValue : Value -> Bool
extractBoolValue boolFlag =
    boolFlag
        |> Decode.decodeValue Decode.bool
        |> Result.withDefault False
