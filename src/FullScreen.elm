module FullScreen
    exposing
        ( Msg
        , leaveFullScreenMsg
        , performFullScreenToggleMsg
        , subscriptions
        , update
        )

import BrowserVendor exposing (Vendor)
import FullScreen.Msg as Msg
import FullScreen.Subscriptions as Subscriptions
import FullScreen.Update as Update
import MsgRouter exposing (MsgRouter)


type alias Msg =
    Msg.Msg


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle


leaveFullScreenMsg : Msg
leaveFullScreenMsg =
    Msg.LeaveFullScreen


subscriptions : MsgRouter msg -> Sub msg
subscriptions msgRouter =
    Subscriptions.subscriptions msgRouter


update : Msg -> Vendor -> Cmd msg
update msg vendor =
    Update.update msg vendor
