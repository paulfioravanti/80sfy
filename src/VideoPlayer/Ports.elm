port module VideoPlayer.Ports exposing (haltVideos, pauseVideos, playVideos)


port haltVideos : () -> Cmd msg


port pauseVideos : () -> Cmd msg


port playVideos : () -> Cmd msg
