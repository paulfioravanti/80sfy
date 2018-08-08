port module Browser.Subscriptions exposing (subscriptions)

import Browser.Msg exposing (Msg(EnterFullScreen, LeaveFullScreen))
import Json.Decode as Decode exposing (Value)
import MsgRouter exposing (MsgRouter)


port toggleFullScreen : (Value -> msg) -> Sub msg


subscriptions : MsgRouter msg -> Sub msg
subscriptions { browserMsg } =
    toggleFullScreen
        (\isFullScreenFlag ->
            if extractBoolValue isFullScreenFlag then
                browserMsg LeaveFullScreen
            else
                browserMsg EnterFullScreen
        )


extractBoolValue : Value -> Bool
extractBoolValue boolFlag =
    boolFlag
        |> Decode.decodeValue Decode.bool
        |> Result.withDefault False
