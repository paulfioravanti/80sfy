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


enterFullScreen : Msg
enterFullScreen =
    EnterFullScreen


leaveFullScreen : Msg
leaveFullScreen =
    LeaveFullScreen


performFullScreenToggle : Msg
performFullScreenToggle =
    PerformFullScreenToggle


toCmd : Msg -> BrowserVendor -> Cmd msg
toCmd msg browserVendor =
    case msg of
        EnterFullScreen ->
            Model.enterFullScreen browserVendor

        LeaveFullScreen ->
            Model.leaveFullScreen browserVendor

        PerformFullScreenToggle ->
            Model.performFullScreenToggle browserVendor
