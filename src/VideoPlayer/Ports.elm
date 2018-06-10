port module VideoPlayer.Ports
    exposing
        ( pauseVideos
        , playVideos
        , toggleFullScreen
        )


port pauseVideos : () -> Cmd msg


port playVideos : () -> Cmd msg


port toggleFullScreen : () -> Cmd msg
