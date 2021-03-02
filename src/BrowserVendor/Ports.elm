port module BrowserVendor.Ports exposing
    ( exitFullScreen
    , requestFullScreen
    , toggleFullScreen
    )

import PortMessage exposing (PortMessage)


port toBrowserVendor : PortMessage -> Cmd msg


exitFullScreen : Cmd msg
exitFullScreen =
    toBrowserVendor (PortMessage.withTag "EXIT_FULL_SCREEN")


toggleFullScreen : Cmd msg
toggleFullScreen =
    toBrowserVendor (PortMessage.withTag "TOGGLE_FULL_SCREEN")


requestFullScreen : Cmd msg
requestFullScreen =
    toBrowserVendor (PortMessage.withTag "REQUEST_FULL_SCREEN")
