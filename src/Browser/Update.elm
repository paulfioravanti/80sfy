module Browser.Update exposing (update)

import Browser.Msg
    exposing
        ( Msg
            ( EnterFullScreen
            , LeaveFullScreen
            , PerformFullScreenToggle
            )
        )
import Browser.Ports as Ports
import Browser.Vendor exposing (Vendor)


update : Msg -> Vendor -> Cmd msg
update msg vendor =
    case msg of
        EnterFullScreen ->
            Ports.enterFullScreen vendor

        LeaveFullScreen ->
            Ports.leaveFullScreen vendor

        PerformFullScreenToggle ->
            Ports.performFullScreenToggle vendor
