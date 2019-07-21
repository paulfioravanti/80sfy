module BrowserVendor.Msg exposing
    ( Msg
    , enterFullScreen
    , leaveFullScreen
    , performFullScreenToggle
    , toCmd
    )

import BrowserVendor.Model as Model exposing (BrowserVendor)


type Msg
    = EnterFullScreen
    | LeaveFullScreen
    | PerformFullScreenToggle


enterFullScreen : (Msg -> msg) -> msg
enterFullScreen browserVendorMsg =
    browserVendorMsg EnterFullScreen


leaveFullScreen : (Msg -> msg) -> msg
leaveFullScreen browserVendorMsg =
    browserVendorMsg LeaveFullScreen


performFullScreenToggle : (Msg -> msg) -> msg
performFullScreenToggle browserVendorMsg =
    browserVendorMsg PerformFullScreenToggle


toCmd : Msg -> BrowserVendor -> Cmd msg
toCmd msg browserVendor =
    case msg of
        EnterFullScreen ->
            Model.enterFullScreen browserVendor

        LeaveFullScreen ->
            Model.leaveFullScreen browserVendor

        PerformFullScreenToggle ->
            Model.performFullScreenToggle browserVendor
