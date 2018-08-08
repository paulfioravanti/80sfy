module Browser
    exposing
        ( Browser
        , Msg
        , init
        , enterFullScreen
        , leaveFullScreen
        , performFullScreenToggle
        , enterFullScreenMsg
        , leaveFullScreenMsg
        , performFullScreenToggleMsg
        , subscriptions
        , update
        )

import Browser.Model as Model
import Browser.Msg as Msg
import Browser.Ports as Ports
import Browser.Subscriptions as Subscriptions
import Browser.Update as Update
import Flags exposing (Flags)
import MsgRouter exposing (MsgRouter)


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


enterFullScreenMsg : Msg
enterFullScreenMsg =
    Msg.EnterFullScreen


performFullScreenToggle : Browser -> Cmd msg
performFullScreenToggle browser =
    Ports.performFullScreenToggle browser


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle


leaveFullScreen : Browser -> Cmd msg
leaveFullScreen browser =
    Ports.leaveFullScreen browser


leaveFullScreenMsg : Msg
leaveFullScreenMsg =
    Msg.LeaveFullScreen


subscriptions : MsgRouter msg -> Sub msg
subscriptions msgRouter =
    Subscriptions.subscriptions msgRouter


update : Msg -> Browser -> Cmd msg
update msg browser =
    Update.update msg browser
