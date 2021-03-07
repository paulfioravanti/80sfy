module BrowserVendor.Task exposing (performExitFullscreen)

import BrowserVendor.Msg as Msg exposing (Msg)
import Task


performExitFullscreen : (Msg -> msg) -> Cmd msg
performExitFullscreen browserVendorMsg =
    Msg.exitFullscreen browserVendorMsg
        |> Task.succeed
        |> Task.perform identity
