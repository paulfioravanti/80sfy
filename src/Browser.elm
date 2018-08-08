module Browser
    exposing
        ( Browser
        , Msg
        , init
        , leaveFullScreenMsg
        , performFullScreenToggleMsg
        , subscriptions
        , update
        )

import Browser.Model as Model
import Browser.Msg as Msg
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


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle


leaveFullScreenMsg : Msg
leaveFullScreenMsg =
    Msg.LeaveFullScreen


subscriptions : MsgRouter msg -> Sub msg
subscriptions msgRouter =
    Subscriptions.subscriptions msgRouter


update : Msg -> Browser -> Cmd msg
update msg browser =
    Update.update msg browser
