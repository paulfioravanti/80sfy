module FullScreen.Cmd exposing (cmd)

import BrowserVendor exposing (BrowserVendor)
import FullScreen.Msg as Msg exposing (Msg)
import FullScreen.Ports as Ports


cmd : Msg -> BrowserVendor -> Cmd msg
cmd msg browserVendor =
    case msg of
        Msg.EnterFullScreen ->
            Ports.enterFullScreen browserVendor

        Msg.LeaveFullScreen ->
            Ports.leaveFullScreen browserVendor

        Msg.PerformFullScreenToggle ->
            Ports.performFullScreenToggle browserVendor
