module BrowserVendor exposing
    ( Msg
    , cmd
    , exitFullscreenMsg
    , performExitFullscreen
    , toggleFullscreenMsg
    )

import BrowserVendor.Msg as Msg
import BrowserVendor.Task as Task


type alias Msg =
    Msg.Msg


cmd : Msg -> Cmd msg
cmd msg =
    Msg.toCmd msg


exitFullscreenMsg : (Msg -> msg) -> msg
exitFullscreenMsg browserVendorMsg =
    Msg.exitFullscreen browserVendorMsg


performExitFullscreen : (Msg -> msg) -> Cmd msg
performExitFullscreen browserVendorMsg =
    Task.performExitFullscreen browserVendorMsg


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg browserVendorMsg =
    Msg.toggleFullscreen browserVendorMsg
