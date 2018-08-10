port module Browser.Ports
    exposing
        ( enterFullScreen
        , performFullScreenToggle
        , leaveFullScreen
        )

import Browser.Model exposing (Browser(Mozilla, Other, Webkit))


port exitFullScreen : () -> Cmd msg


port fullScreenToggle : () -> Cmd msg


port mozCancelFullScreen : () -> Cmd msg


port mozFullScreenToggle : () -> Cmd msg


{-| NOTE: Currently does not seem to work as Firefox requires this event to
   occur in the same clock tick as the user click. Currently, in the console,
   you will see "Request for fullscreen was denied because
   Element.requestFullscreen() was not called from inside a short running
   user-generated event handler.". I don't currently know how to fix this.
   More information can be found in this message on the Elm mailing list:
   https://groups.google.com/d/msg/elm-dev/hhNu6SGOM54/TS0pDPtKCAAJ
-}
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

        Other ->
            requestFullScreen ()

        Webkit ->
            webkitRequestFullScreen ()


performFullScreenToggle : Browser -> Cmd msg
performFullScreenToggle browser =
    case browser of
        Mozilla ->
            mozFullScreenToggle ()

        Other ->
            fullScreenToggle ()

        Webkit ->
            webkitFullScreenToggle ()


leaveFullScreen : Browser -> Cmd msg
leaveFullScreen browser =
    case browser of
        Mozilla ->
            mozCancelFullScreen ()

        Other ->
            exitFullScreen ()

        Webkit ->
            webkitExitFullScreen ()
