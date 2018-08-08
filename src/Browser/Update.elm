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


update : Msg -> Browser -> ( Browser, Cmd msg )
update msg browser =
    case msg of
        EnterFullScreen ->
            ( browser, Ports.enterFullScreen browser )

        LeaveFullScreen ->
            ( browser, Ports.leaveFullScreen browser )

        PerformFullScreenToggle ->
            ( browser, Ports.performFullScreenToggle browser )
