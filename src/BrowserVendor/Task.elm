module BrowserVendor.Task exposing (leaveFullScreen)

import BrowserVendor.Msg as Msg exposing (Msg)
import Task


leaveFullScreen : (Msg -> msg) -> Cmd msg
leaveFullScreen browserVendorMsg =
    Msg.leaveFullScreen browserVendorMsg
        |> Task.succeed
        |> Task.perform identity
