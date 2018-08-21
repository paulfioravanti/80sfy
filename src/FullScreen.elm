module FullScreen
    exposing
        ( Msg
        , cmd
        , leaveFullScreenMsg
        , performFullScreenToggleMsg
        , subscriptions
        )

import BrowserVendor exposing (Vendor)
import FullScreen.Cmd as Cmd
import FullScreen.Msg as Msg
import FullScreen.Subscriptions as Subscriptions
import MsgRouter exposing (MsgRouter)


type alias Msg =
    Msg.Msg


cmd : Msg -> Vendor -> Cmd msg
cmd msg vendor =
    Cmd.cmd msg vendor


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle


leaveFullScreenMsg : Msg
leaveFullScreenMsg =
    Msg.LeaveFullScreen


subscriptions : MsgRouter msg -> Sub msg
subscriptions msgRouter =
    Subscriptions.subscriptions msgRouter
