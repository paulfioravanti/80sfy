module BrowserVendor.Task exposing (performLeaveFullScreen)

import BrowserVendor.Msg as Msg exposing (Msg)
import Task


performLeaveFullScreen : (Msg -> msg) -> Cmd msg
performLeaveFullScreen browserVendorMsg =
    Msg.leaveFullScreen browserVendorMsg
        |> Task.succeed
        |> Task.perform identity
