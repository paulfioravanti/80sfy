module BrowserVendor exposing
    ( Msg
    , cmd
    , exitFullScreenMsg
    , performExitFullScreen
    , toggleFullScreenMsg
    )

import BrowserVendor.Msg as Msg
import BrowserVendor.Task as Task


type alias Msg =
    Msg.Msg


cmd : Msg -> Cmd msg
cmd msg =
    Msg.toCmd msg


exitFullScreenMsg : (Msg -> msg) -> msg
exitFullScreenMsg browserVendorMsg =
    Msg.exitFullScreen browserVendorMsg


performExitFullScreen : (Msg -> msg) -> Cmd msg
performExitFullScreen browserVendorMsg =
    Task.performExitFullScreen browserVendorMsg


toggleFullScreenMsg : (Msg -> msg) -> msg
toggleFullScreenMsg browserVendorMsg =
    Msg.toggleFullScreen browserVendorMsg
