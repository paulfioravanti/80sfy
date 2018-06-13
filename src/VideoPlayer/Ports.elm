port module VideoPlayer.Ports
    exposing
        ( exitFullScreen
        , pauseVideos
        , playVideos
        , toggleFullScreen
        )


port exitFullScreen : () -> Cmd msg


port pauseVideos : () -> Cmd msg


port playVideos : () -> Cmd msg


port toggleFullScreen : () -> Cmd msg
