port module VideoPlayer.Ports
    exposing
        ( exitFullScreen
        , haltVideos
        , pauseVideos
        , playVideos
        , toggleFullScreen
        )


port exitFullScreen : () -> Cmd msg


port haltVideos : () -> Cmd msg


port pauseVideos : () -> Cmd msg


port playVideos : () -> Cmd msg


port toggleFullScreen : () -> Cmd msg
