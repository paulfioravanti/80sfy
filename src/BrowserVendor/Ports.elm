port module BrowserVendor.Ports exposing
    ( mozCancelFullScreen
    , mozFullScreenToggle
    , mozRequestFullScreen
    , otherExitFullScreen
    , otherFullScreenToggle
    , otherRequestFullScreen
    , webkitExitFullScreen
    , webkitFullScreenToggle
    , webkitRequestFullScreen
    )

import PortMessage exposing (PortMessage)


port toBrowserVendor : PortMessage -> Cmd msg


port mozCancelFullScreen : () -> Cmd msg


port mozFullScreenToggle : () -> Cmd msg


{-| NOTE: Currently does not seem to work as Firefox requires this event to
occur in the same clock tick as the user click. Currently, in the console,
you will see "Request for fullscreen was denied because
Element.requestFullscreen() was not called from inside a short running
user-generated event handler.". I don't currently know how to fix this.
More information can be found at:

  - <https://groups.google.com/d/msg/elm-dev/hhNu6SGOM54/TS0pDPtKCAAJ>
  - <https://stackoverflow.com/q/43240352/567863>

-}
port mozRequestFullScreen : () -> Cmd msg


port otherExitFullScreen : () -> Cmd msg


port otherFullScreenToggle : () -> Cmd msg


port otherRequestFullScreen : () -> Cmd msg


webkitExitFullScreen : Cmd msg
webkitExitFullScreen =
    toBrowserVendor (PortMessage.new "EXIT_FULL_SCREEN")


webkitFullScreenToggle : Cmd msg
webkitFullScreenToggle =
    toBrowserVendor (PortMessage.new "FULL_SCREEN_TOGGLE")


webkitRequestFullScreen : Cmd msg
webkitRequestFullScreen =
    toBrowserVendor (PortMessage.new "REQUEST_FULL_SCREEN")
