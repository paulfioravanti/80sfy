module BrowserVendor exposing
    ( BrowserVendor
    , Msg
    , cmd
    , exitFullScreenMsg
    , init
    , mozilla
    , performExitFullScreen
    , subscriptions
    , toggleFullScreenMsg
    )

import BrowserVendor.Model as Model
import BrowserVendor.Msg as Msg
import BrowserVendor.Subscriptions as Subscriptions
import BrowserVendor.Task as Task
import Flags exposing (Flags)


type alias BrowserVendor =
    Model.BrowserVendor


type alias Msg =
    Msg.Msg


type alias Msgs msgs msg =
    Subscriptions.Msgs msgs msg


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


subscriptions : Msgs msgs msg -> Sub msg
subscriptions msgs =
    Subscriptions.subscriptions msgs


toggleFullScreenMsg : (Msg -> msg) -> msg
toggleFullScreenMsg browserVendorMsg =
    Msg.toggleFullScreen browserVendorMsg
