module BrowserVendor.Msg exposing
    ( Msg
    , exitFullscreen
    , requestFullscreen
    , toCmd
    , toggleFullscreen
    )

import Port


type Msg
    = ExitFullscreen
    | RequestFullscreen
    | ToggleFullscreen


exitFullscreen : (Msg -> msg) -> msg
exitFullscreen browserVendorMsg =
    browserVendorMsg ExitFullscreen


requestFullscreen : (Msg -> msg) -> msg
requestFullscreen browserVendorMsg =
    browserVendorMsg RequestFullscreen


toCmd : Msg -> Cmd msg
toCmd msg =
    case msg of
        RequestFullscreen ->
            Port.requestFullscreen

        ExitFullscreen ->
            Port.exitFullscreen

        ToggleFullscreen ->
            Port.toggleFullscreen


toggleFullscreen : (Msg -> msg) -> msg
toggleFullscreen browserVendorMsg =
    browserVendorMsg ToggleFullscreen
