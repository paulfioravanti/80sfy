port module BrowserVendor.Subscriptions exposing (Msgs, subscriptions)

import BrowserVendor.Msg as Msg exposing (Msg)
import Json.Decode as Decode exposing (Decoder, Value, bool, string)
import Json.Decode.Pipeline exposing (required)
import Value


port fromBrowserVendor : (Value -> msg) -> Sub msg


type alias Msgs msgs msg =
    { msgs
        | browserVendorMsg : Msg -> msg
        , noOpMsg : msg
    }


type alias SubMessage =
    { tag : String
    , payload : Bool
    }


subscriptions : Msgs msgs msg -> Sub msg
subscriptions msgs =
    fromBrowserVendor (handleSubMessage msgs)



-- PRIVATE


decoder : Decoder SubMessage
decoder =
    Decode.succeed SubMessage
        |> required "tag" string
        |> required "payload" bool


handleSubMessage : Msgs msgs msg -> Value -> msg
handleSubMessage { browserVendorMsg, noOpMsg } subMessageFlag =
    let
        subMessage =
            Decode.decodeValue decoder subMessageFlag
    in
    case subMessage of
        Ok { tag, payload } ->
            case tag of
                "IS_FULL_SCREEN" ->
                    if payload then
                        Msg.leaveFullScreen browserVendorMsg

                    else
                        Msg.enterFullScreen browserVendorMsg

                _ ->
                    noOpMsg

        Err _ ->
            noOpMsg
