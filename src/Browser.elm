port module Browser
    exposing
        ( Browser
        , init
        , enterFullScreen
        , leaveFullScreen
        , performFullScreenToggle
        )

import Json.Decode as Decode
import Flags exposing (Flags)


port exitFullScreen : () -> Cmd msg


port fullScreenToggle : () -> Cmd msg


port mozCancelFullScreen : () -> Cmd msg


port mozFullScreenToggle : () -> Cmd msg


port mozRequestFullScreen : () -> Cmd msg


port requestFullScreen : () -> Cmd msg


port webkitExitFullScreen : () -> Cmd msg


port webkitFullScreenToggle : () -> Cmd msg


port webkitRequestFullScreen : () -> Cmd msg


type Browser
    = Mozilla
    | Unknown
    | Webkit


init : Flags -> Browser
init flags =
    let
        browser =
            flags.browser
                |> Decode.decodeValue Decode.string
                |> Result.withDefault "unknown"
    in
        case browser of
            "mozilla" ->
                Mozilla

            "webkit" ->
                Webkit

            _ ->
                Unknown


enterFullScreen : Browser -> Cmd msg
enterFullScreen browser =
    case browser of
        Mozilla ->
            mozRequestFullScreen ()

        Unknown ->
            requestFullScreen ()

        Webkit ->
            webkitRequestFullScreen ()


performFullScreenToggle : Browser -> Cmd msg
performFullScreenToggle browser =
    case browser of
        Mozilla ->
            mozFullScreenToggle ()

        Unknown ->
            fullScreenToggle ()

        Webkit ->
            webkitFullScreenToggle ()


leaveFullScreen : Browser -> Cmd msg
leaveFullScreen browser =
    case browser of
        Mozilla ->
            mozCancelFullScreen ()

        Unknown ->
            exitFullScreen ()

        Webkit ->
            webkitExitFullScreen ()
