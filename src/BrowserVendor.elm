module BrowserVendor exposing
    ( BrowserVendor
    , Msg
    , cmd
    , init
    , leaveFullScreen
    , leaveFullScreenMsg
    , mozilla
    , performFullScreenToggleMsg
    , subscriptions
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


init : Flags -> BrowserVendor
init flags =
    Model.init flags.browserVendor


cmd : Msg -> BrowserVendor -> Cmd msg
cmd msg browserVendor =
    Msg.toCmd msg browserVendor


leaveFullScreen : (Msg -> msg) -> Cmd msg
leaveFullScreen browserVendorMsg =
    Task.leaveFullScreen browserVendorMsg


leaveFullScreenMsg : (Msg -> msg) -> msg
leaveFullScreenMsg browserVendorMsg =
    browserVendorMsg Msg.leaveFullScreen


mozilla : BrowserVendor
mozilla =
    Model.mozilla


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.performFullScreenToggle


subscriptions : (Msg -> msg) -> Sub msg
subscriptions browserVendorMsg =
    Subscriptions.subscriptions browserVendorMsg
