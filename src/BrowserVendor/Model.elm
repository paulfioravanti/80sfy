module BrowserVendor.Model exposing
    ( BrowserVendor(..)
    , enterFullScreen
    , init
    , leaveFullScreen
    , mozilla
    , performFullScreenToggle
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
            browserVendorFlag
                |> Value.extractStringWithDefault "other"
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
            Ports.requestFullScreen ()

        Webkit ->
            Ports.webkitRequestFullScreen ()


mozilla : BrowserVendor
mozilla =
    Mozilla


performFullScreenToggle : BrowserVendor -> Cmd msg
performFullScreenToggle browserVendor =
    case browserVendor of
        Mozilla ->
            Ports.mozFullScreenToggle ()

        Other ->
            Ports.fullScreenToggle ()

        Webkit ->
            Ports.webkitFullScreenToggle ()


leaveFullScreen : BrowserVendor -> Cmd msg
leaveFullScreen browserVendor =
    case browserVendor of
        Mozilla ->
            Ports.mozCancelFullScreen ()

        Other ->
            Ports.exitFullScreen ()

        Webkit ->
            Ports.webkitExitFullScreen ()
