module BrowserVendor exposing
    ( BrowserVendor
    , Msg
    , cmd
    , exitFullScreenMsg
    , init
    , mozilla
    , performExitFullScreen
    , toggleFullScreenMsg
    )

import BrowserVendor.Model as Model
import BrowserVendor.Msg as Msg
import BrowserVendor.Task as Task
import Flags exposing (Flags)


type alias BrowserVendor =
    Model.BrowserVendor


type alias Msg =
    Msg.Msg


init : Flags -> BrowserVendor
init flags =
    Model.init flags.browserVendor


cmd : Msg -> Cmd msg
cmd msg =
    Msg.toCmd msg


exitFullScreenMsg : (Msg -> msg) -> msg
exitFullScreenMsg browserVendorMsg =
    Msg.exitFullScreen browserVendorMsg


mozilla : BrowserVendor
mozilla =
    Model.mozilla


performExitFullScreen : (Msg -> msg) -> Cmd msg
performExitFullScreen browserVendorMsg =
    Task.performExitFullScreen browserVendorMsg


toggleFullScreenMsg : (Msg -> msg) -> msg
toggleFullScreenMsg browserVendorMsg =
    Msg.toggleFullScreen browserVendorMsg
