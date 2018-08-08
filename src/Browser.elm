module Browser
    exposing
        ( Browser
        , Msg
        , init
        , enterFullScreen
        , leaveFullScreen
        , performFullScreenToggle
        , update
        )

import Browser.Model as Model
import Browser.Msg as Msg
import Browser.Ports as Ports
import Browser.Update as Update
import Flags exposing (Flags)


type alias Browser =
    Model.Browser


type alias Msg =
    Msg.Msg


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


update : Msg -> Browser -> Cmd msg
update msg browser =
    Update.update msg browser
