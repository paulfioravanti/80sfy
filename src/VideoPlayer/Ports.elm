port module VideoPlayer.Ports exposing (toggleFullScreen, toggleVideoPlay)


port toggleFullScreen : () -> Cmd msg


port toggleVideoPlay : Bool -> Cmd msg
