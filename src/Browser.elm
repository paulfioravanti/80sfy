module Browser
    exposing
        ( Msg
        , Vendor
        , init
        , leaveFullScreenMsg
        , mozilla
        , performFullScreenToggleMsg
        , subscriptions
        , update
        )

import Browser.Msg as Msg
import Browser.Subscriptions as Subscriptions
import Browser.Update as Update
import Browser.Vendor as Vendor
import Flags exposing (Flags)
import MsgRouter exposing (MsgRouter)


type alias Msg =
    Msg.Msg


type alias Vendor =
    Vendor.Vendor


init : Flags -> Vendor
init flags =
    Vendor.init flags


mozilla : Vendor
mozilla =
    Vendor.Mozilla


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
