module FullScreen.Cmd exposing (cmd)

import BrowserVendor exposing (Vendor)
import FullScreen.Msg as Msg exposing (Msg)
import FullScreen.Ports as Ports


cmd : Msg -> Vendor -> Cmd msg
cmd msg vendor =
    case msg of
        Msg.EnterFullScreen ->
            Ports.enterFullScreen vendor

        Msg.LeaveFullScreen ->
            Ports.leaveFullScreen vendor

        Msg.PerformFullScreenToggle ->
            Ports.performFullScreenToggle vendor
