port module FullScreen.Subscriptions exposing (subscriptions)

import FullScreen.Msg as Msg exposing (Msg)
import Json.Decode exposing (Value)
import Value


port toggleFullScreen : (Value -> msg) -> Sub msg


subscriptions : (Msg -> msg) -> Sub msg
subscriptions fullScreenMsg =
    toggleFullScreen
        (\isFullScreenFlag ->
            if Value.extractBool False isFullScreenFlag then
                fullScreenMsg Msg.LeaveFullScreen

            else
                fullScreenMsg Msg.EnterFullScreen
        )
