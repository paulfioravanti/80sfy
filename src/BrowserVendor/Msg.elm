module BrowserVendor.Msg exposing
    ( Msg
    , enterFullScreen
    , leaveFullScreen
    , toCmd
    , toggleFullScreen
    )

import BrowserVendor.Model as Model exposing (BrowserVendor)


type Msg
    = EnterFullScreen
    | LeaveFullScreen
    | ToggleFullScreen


enterFullScreen : (Msg -> msg) -> msg
enterFullScreen browserVendorMsg =
    browserVendorMsg EnterFullScreen


leaveFullScreen : (Msg -> msg) -> msg
leaveFullScreen browserVendorMsg =
    browserVendorMsg LeaveFullScreen


toCmd : Msg -> BrowserVendor -> Cmd msg
toCmd msg browserVendor =
    case msg of
        EnterFullScreen ->
            Model.enterFullScreen browserVendor

        LeaveFullScreen ->
            Model.leaveFullScreen browserVendor

        ToggleFullScreen ->
            Model.toggleFullScreen browserVendor


toggleFullScreen : (Msg -> msg) -> msg
toggleFullScreen browserVendorMsg =
    browserVendorMsg ToggleFullScreen
