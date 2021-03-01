port module BrowserVendor.Ports exposing
    ( exitFullScreen
    , requestFullScreen
    , toggleFullScreen
    )

import PortMessage exposing (PortMessage)


port toBrowserVendor : PortMessage -> Cmd msg


exitFullScreen : Cmd msg
exitFullScreen =
    toBrowserVendor (PortMessage.new "EXIT_FULL_SCREEN")


toggleFullScreen : Cmd msg
toggleFullScreen =
    toBrowserVendor (PortMessage.new "TOGGLE_FULL_SCREEN")


requestFullScreen : Cmd msg
requestFullScreen =
    toBrowserVendor (PortMessage.new "REQUEST_FULL_SCREEN")
