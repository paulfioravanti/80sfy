module BrowserVendor.Msg exposing
    ( Msg
    , exitFullScreen
    , requestFullScreen
    , toCmd
    , toggleFullScreen
    )

import Port


type Msg
    = ExitFullScreen
    | RequestFullScreen
    | ToggleFullScreen


exitFullScreen : (Msg -> msg) -> msg
exitFullScreen browserVendorMsg =
    browserVendorMsg ExitFullScreen


requestFullScreen : (Msg -> msg) -> msg
requestFullScreen browserVendorMsg =
    browserVendorMsg RequestFullScreen


toCmd : Msg -> Cmd msg
toCmd msg =
    case msg of
        RequestFullScreen ->
            Port.requestFullScreen

        ExitFullScreen ->
            Port.exitFullScreen

        ToggleFullScreen ->
            Port.toggleFullScreen


toggleFullScreen : (Msg -> msg) -> msg
toggleFullScreen browserVendorMsg =
    browserVendorMsg ToggleFullScreen
