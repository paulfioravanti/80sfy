module VideoPlayer.Ports exposing (haltVideos, pauseVideos, playVideos)

import PortMessage
import Ports


haltVideos : Cmd msg
haltVideos =
    Ports.out (PortMessage.withTag "HALT_VIDEOS")


pauseVideos : Cmd msg
pauseVideos =
    Ports.out (PortMessage.withTag "PAUSE_VIDEOS")


playVideos : Cmd msg
playVideos =
    Ports.out (PortMessage.withTag "PLAY_VIDEOS")
