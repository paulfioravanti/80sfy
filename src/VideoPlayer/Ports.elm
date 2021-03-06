module VideoPlayer.Ports exposing (haltVideos, pauseVideos, playVideos)

import PortMessage
import Ports


haltVideos : Cmd msg
haltVideos =
    Ports.outbound (PortMessage.withTag "HALT_VIDEOS")


pauseVideos : Cmd msg
pauseVideos =
    Ports.outbound (PortMessage.withTag "PAUSE_VIDEOS")


playVideos : Cmd msg
playVideos =
    Ports.outbound (PortMessage.withTag "PLAY_VIDEOS")
