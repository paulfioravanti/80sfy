port module BrowserVendor.Ports exposing
    ( exitFullScreen
    , fullScreenToggle
    , mozCancelFullScreen
    , mozFullScreenToggle
    , mozRequestFullScreen
    , requestFullScreen
    , webkitExitFullScreen
    , webkitFullScreenToggle
    , webkitRequestFullScreen
    )


port exitFullScreen : () -> Cmd msg


port fullScreenToggle : () -> Cmd msg


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


port requestFullScreen : () -> Cmd msg


port webkitExitFullScreen : () -> Cmd msg


port webkitFullScreenToggle : () -> Cmd msg


port webkitRequestFullScreen : () -> Cmd msg