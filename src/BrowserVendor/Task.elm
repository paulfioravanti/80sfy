module BrowserVendor.Task exposing (performExitFullScreen)

import BrowserVendor.Msg as Msg exposing (Msg)
import Task


performExitFullScreen : (Msg -> msg) -> Cmd msg
performExitFullScreen browserVendorMsg =
    Msg.exitFullScreen browserVendorMsg
        |> Task.succeed
        |> Task.perform identity
