module BrowserVendor.Model exposing
    ( BrowserVendor
    , enterFullScreen
    , init
    , leaveFullScreen
    , mozilla
    , toggleFullScreen
    )

import BrowserVendor.Ports as Ports
import Json.Decode exposing (Value)
import Value


type BrowserVendor
    = Mozilla
    | Other
    | Webkit


init : Value -> BrowserVendor
init browserVendorFlag =
    let
        browser =
            Value.extractStringWithDefault "other" browserVendorFlag
    in
    case browser of
        "mozilla" ->
            Mozilla

        "webkit" ->
            Webkit

        _ ->
            Other


enterFullScreen : BrowserVendor -> Cmd msg
enterFullScreen browserVendor =
    case browserVendor of
        Mozilla ->
            Ports.mozRequestFullScreen ()

        Other ->
            Ports.otherRequestFullScreen ()

        Webkit ->
            Ports.webkitRequestFullScreen ()


mozilla : BrowserVendor
mozilla =
    Mozilla


toggleFullScreen : BrowserVendor -> Cmd msg
toggleFullScreen browserVendor =
    case browserVendor of
        Mozilla ->
            Ports.mozFullScreenToggle ()

        Other ->
            Ports.otherFullScreenToggle ()

        Webkit ->
            Ports.webkitFullScreenToggle ()


leaveFullScreen : BrowserVendor -> Cmd msg
leaveFullScreen browserVendor =
    case browserVendor of
        Mozilla ->
            Ports.mozCancelFullScreen ()

        Other ->
            Ports.otherExitFullScreen ()

        Webkit ->
            Ports.webkitExitFullScreen ()
