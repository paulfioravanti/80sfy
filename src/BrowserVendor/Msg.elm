module BrowserVendor.Msg exposing
    ( Msg
    , exitFullscreen
    , toCmd
    , toggleFullscreen
    )

import Port


type Msg
    = ExitFullscreen
    | ToggleFullscreen


exitFullscreen : (Msg -> msg) -> msg
exitFullscreen browserVendorMsg =
    browserVendorMsg ExitFullscreen


toCmd : Msg -> Cmd msg
toCmd msg =
    case msg of
        ExitFullscreen ->
            Port.exitFullscreen

        ToggleFullscreen ->
            Port.toggleFullscreen


toggleFullscreen : (Msg -> msg) -> msg
toggleFullscreen browserVendorMsg =
    browserVendorMsg ToggleFullscreen
