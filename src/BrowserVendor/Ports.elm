module BrowserVendor.Ports exposing
    ( exitFullScreen
    , requestFullScreen
    , toggleFullScreen
    )

import PortMessage
import Ports


exitFullScreen : Cmd msg
exitFullScreen =
    Ports.outbound (PortMessage.withTag "EXIT_FULL_SCREEN")


toggleFullScreen : Cmd msg
toggleFullScreen =
    Ports.outbound (PortMessage.withTag "TOGGLE_FULL_SCREEN")


requestFullScreen : Cmd msg
requestFullScreen =
    Ports.outbound (PortMessage.withTag "REQUEST_FULL_SCREEN")
