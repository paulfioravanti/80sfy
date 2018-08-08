port module Browser.Ports
    exposing
        ( enterFullScreen
        , performFullScreenToggle
        , leaveFullScreen
        )

import Browser.Model as Model exposing (Browser(Mozilla, Unknown, Webkit))


port exitFullScreen : () -> Cmd msg


port fullScreenToggle : () -> Cmd msg


port mozCancelFullScreen : () -> Cmd msg


port mozFullScreenToggle : () -> Cmd msg


port mozRequestFullScreen : () -> Cmd msg


port requestFullScreen : () -> Cmd msg


port webkitExitFullScreen : () -> Cmd msg


port webkitFullScreenToggle : () -> Cmd msg


port webkitRequestFullScreen : () -> Cmd msg


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
