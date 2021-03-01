port module BrowserVendor.Subscriptions exposing (Msgs, subscriptions)

import BrowserVendor.Msg as Msg exposing (Msg)
import Json.Decode exposing (Value)
import PortMessage
import Value


port fromBrowserVendor : (Value -> msg) -> Sub msg


type alias Msgs msgs msg =
    { msgs
        | browserVendorMsg : Msg -> msg
        , noOpMsg : msg
    }


subscriptions : Msgs msgs msg -> Sub msg
subscriptions msgs =
    fromBrowserVendor (handlePortMessage msgs)



-- PRIVATE


handlePortMessage : Msgs msgs msg -> Value -> msg
handlePortMessage ({ noOpMsg } as msgs) portMessage =
    let
        { tag, payload } =
            PortMessage.decode portMessage
    in
    case tag of
        "IS_FULL_SCREEN" ->
            handleIsFullScreenMessage msgs payload

        _ ->
            noOpMsg


handleIsFullScreenMessage : Msgs msgs msg -> Value -> msg
handleIsFullScreenMessage { browserVendorMsg } payload =
    let
        isFullScreen =
            Value.extractBoolWithDefault False payload
    in
    if isFullScreen then
        Msg.leaveFullScreen browserVendorMsg

    else
        Msg.enterFullScreen browserVendorMsg
