module FullScreen.Cmd exposing (cmd)

import BrowserVendor exposing (Vendor)
import FullScreen.Msg
    exposing
        ( Msg
            ( EnterFullScreen
            , LeaveFullScreen
            , PerformFullScreenToggle
            )
        )
import FullScreen.Ports as Ports


cmd : Msg -> Vendor -> Cmd msg
cmd msg vendor =
    case msg of
        EnterFullScreen ->
            Ports.enterFullScreen vendor

        LeaveFullScreen ->
            Ports.leaveFullScreen vendor

        PerformFullScreenToggle ->
            Ports.performFullScreenToggle vendor
