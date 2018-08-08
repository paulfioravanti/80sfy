module Browser
    exposing
        ( Browser
        , init
        , enterFullScreen
        , leaveFullScreen
        , performFullScreenToggle
        )

import Browser.Model as Model
import Browser.Ports as Ports
import Json.Decode as Decode
import Flags exposing (Flags)


type alias Browser =
    Model.Browser


init : Flags -> Browser
init flags =
    Model.init flags


enterFullScreen : Browser -> Cmd msg
enterFullScreen browser =
    Ports.enterFullScreen browser


performFullScreenToggle : Browser -> Cmd msg
performFullScreenToggle browser =
    Ports.performFullScreenToggle browser


leaveFullScreen : Browser -> Cmd msg
leaveFullScreen browser =
    Ports.leaveFullScreen browser
