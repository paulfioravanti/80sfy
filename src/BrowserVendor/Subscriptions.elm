port module BrowserVendor.Subscriptions exposing (subscriptions)

import BrowserVendor.Msg as Msg exposing (Msg)
import Json.Decode exposing (Value)
import Value


port toggleFullScreen : (Value -> msg) -> Sub msg


subscriptions : (Msg -> msg) -> Sub msg
subscriptions browserVendorMsg =
    let
        handleIsFullScreenFlag isFullScreenFlag =
            if Value.extractBoolWithDefault False isFullScreenFlag then
                Msg.leaveFullScreen browserVendorMsg

            else
                Msg.enterFullScreen browserVendorMsg
    in
    toggleFullScreen handleIsFullScreenFlag
