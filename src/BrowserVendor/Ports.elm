port module BrowserVendor.Ports exposing
    ( cancelFullScreen
    , fullScreenToggle
    , mozCancelFullScreen
    , mozFullScreenToggle
    , mozRequestFullScreen
    , otherExitFullScreen
    , otherFullScreenToggle
    , otherRequestFullScreen
    , requestFullScreen
    , webkitExitFullScreen
    , webkitFullScreenToggle
    , webkitRequestFullScreen
    )

import PortMessage exposing (PortMessage)


port toBrowserVendor : PortMessage -> Cmd msg


cancelFullScreen : Cmd msg
cancelFullScreen =
    toBrowserVendor (PortMessage.new "EXIT_FULL_SCREEN")


fullScreenToggle : Cmd msg
fullScreenToggle =
    toBrowserVendor (PortMessage.new "FULL_SCREEN_TOGGLE")


requestFullScreen : Cmd msg
requestFullScreen =
    toBrowserVendor (PortMessage.new "REQUEST_FULL_SCREEN")


mozCancelFullScreen : Cmd msg
mozCancelFullScreen =
    toBrowserVendor (PortMessage.new "EXIT_FULL_SCREEN")


mozFullScreenToggle : Cmd msg
mozFullScreenToggle =
    toBrowserVendor (PortMessage.new "FULL_SCREEN_TOGGLE")


{-| NOTE: Currently does not seem to work as Firefox requires this event to
occur in the same clock tick as the user click. Currently, in the console,
you will see "Request for fullscreen was denied because
Element.requestFullscreen() was not called from inside a short running
user-generated event handler.". I don't currently know how to fix this.
See src/browserVendor.js for workaround.
More information can be found at:

  - <https://groups.google.com/d/msg/elm-dev/hhNu6SGOM54/TS0pDPtKCAAJ>
  - <https://stackoverflow.com/q/43240352/567863>

-}
mozRequestFullScreen : Cmd msg
mozRequestFullScreen =
    toBrowserVendor (PortMessage.new "REQUEST_FULL_SCREEN")


otherExitFullScreen : Cmd msg
otherExitFullScreen =
    toBrowserVendor (PortMessage.new "EXIT_FULL_SCREEN")


otherFullScreenToggle : Cmd msg
otherFullScreenToggle =
    toBrowserVendor (PortMessage.new "FULL_SCREEN_TOGGLE")


otherRequestFullScreen : Cmd msg
otherRequestFullScreen =
    toBrowserVendor (PortMessage.new "REQUEST_FULL_SCREEN")


webkitExitFullScreen : Cmd msg
webkitExitFullScreen =
    toBrowserVendor (PortMessage.new "EXIT_FULL_SCREEN")


webkitFullScreenToggle : Cmd msg
webkitFullScreenToggle =
    toBrowserVendor (PortMessage.new "FULL_SCREEN_TOGGLE")


webkitRequestFullScreen : Cmd msg
webkitRequestFullScreen =
    toBrowserVendor (PortMessage.new "REQUEST_FULL_SCREEN")
