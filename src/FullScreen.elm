module FullScreen exposing
    ( Msg
    , cmd
    , leaveFullScreenMsg
    , performFullScreenToggleMsg
    , subscriptions
    )

import BrowserVendor exposing (BrowserVendor)
import FullScreen.Cmd as Cmd
import FullScreen.Msg as Msg
import FullScreen.Subscriptions as Subscriptions


type alias Msg =
    Msg.Msg


cmd : Msg -> BrowserVendor -> Cmd msg
cmd msg browserVendor =
    Cmd.cmd msg browserVendor


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle


leaveFullScreenMsg : Msg
leaveFullScreenMsg =
    Msg.LeaveFullScreen


subscriptions : (Msg -> msg) -> Sub msg
subscriptions fullScreenMsg =
    Subscriptions.subscriptions fullScreenMsg
