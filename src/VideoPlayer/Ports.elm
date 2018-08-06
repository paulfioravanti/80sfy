port module VideoPlayer.Ports
    exposing
        ( exitFullScreen
        , haltVideos
        , pauseVideos
        , performFullScreenToggle
        , playVideos
        )


port exitFullScreen : () -> Cmd msg


port haltVideos : () -> Cmd msg


port pauseVideos : () -> Cmd msg


port playVideos : () -> Cmd msg


port performFullScreenToggle : () -> Cmd msg
