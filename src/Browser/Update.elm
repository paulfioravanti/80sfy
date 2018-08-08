module Browser.Update exposing (update)

import Browser.Model exposing (Browser)
import Browser.Msg
    exposing
        ( Msg
            ( EnterFullScreen
            , LeaveFullScreen
            , PerformFullScreenToggle
            )
        )
import Browser.Ports as Ports


update : Msg -> Browser -> Cmd msg
update msg browser =
    case msg of
        EnterFullScreen ->
            Ports.enterFullScreen browser

        LeaveFullScreen ->
            Ports.leaveFullScreen browser

        PerformFullScreenToggle ->
            Ports.performFullScreenToggle browser
