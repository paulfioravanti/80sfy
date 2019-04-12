module FullScreen exposing
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


subscriptions : (Msg -> msg) -> Sub msg
subscriptions fullScreenMsg =
    Subscriptions.subscriptions fullScreenMsg
