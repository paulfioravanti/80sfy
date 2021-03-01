module BrowserVendor exposing
    ( BrowserVendor
    , Msg
    , cmd
    , init
    , leaveFullScreenMsg
    , mozilla
    , performLeaveFullScreen
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


cmd : Msg -> BrowserVendor -> Cmd msg
cmd msg browserVendor =
    Msg.toCmd msg browserVendor


leaveFullScreenMsg : (Msg -> msg) -> msg
leaveFullScreenMsg browserVendorMsg =
    Msg.leaveFullScreen browserVendorMsg


mozilla : BrowserVendor
mozilla =
    Model.mozilla


toggleFullScreenMsg : (Msg -> msg) -> msg
toggleFullScreenMsg browserVendorMsg =
    Msg.toggleFullScreen browserVendorMsg


performLeaveFullScreen : (Msg -> msg) -> Cmd msg
performLeaveFullScreen browserVendorMsg =
    Task.performLeaveFullScreen browserVendorMsg


subscriptions : Msgs msgs msg -> Sub msg
subscriptions msgs =
    Subscriptions.subscriptions msgs
