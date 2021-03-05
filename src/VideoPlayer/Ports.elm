port module VideoPlayer.Ports exposing (haltVideos, pauseVideos, playVideos)

import PortMessage exposing (PortMessage)


port videoPlayerOut : PortMessage -> Cmd msg


haltVideos : Cmd msg
haltVideos =
    videoPlayerOut (PortMessage.withTag "HALT_VIDEOS")


pauseVideos : Cmd msg
pauseVideos =
    videoPlayerOut (PortMessage.withTag "PAUSE_VIDEOS")


playVideos : Cmd msg
playVideos =
    videoPlayerOut (PortMessage.withTag "PLAY_VIDEOS")
