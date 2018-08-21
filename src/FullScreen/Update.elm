module FullScreen.Update exposing (update)

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


update : Msg -> Vendor -> Cmd msg
update msg vendor =
    case msg of
        EnterFullScreen ->
            Ports.enterFullScreen vendor

        LeaveFullScreen ->
            Ports.leaveFullScreen vendor

        PerformFullScreenToggle ->
            Ports.performFullScreenToggle vendor
