port module Port exposing
    ( exitFullscreen
    , haltVideos
    , inbound
    , initSoundCloudWidget
    , log
    , outbound
    , pauseAudio
    , pauseVideos
    , playAudio
    , playVideos
    , requestFullscreen
    , setVolume
    , skipToTrack
    , toggleFullscreen
    )

import Json.Encode exposing (Value)
import Port.Outbound as Outbound
import PortMessage exposing (PortMessage)


port inbound : (Value -> msg) -> Sub msg


port outbound : PortMessage -> Cmd msg


exitFullscreen : Cmd msg
exitFullscreen =
    Outbound.exitFullscreen


haltVideos : Cmd msg
haltVideos =
    Outbound.haltVideos


initSoundCloudWidget : ( String, Int ) -> Cmd msg
initSoundCloudWidget payloadValues =
    Outbound.initSoundCloudWidget payloadValues


log : Value -> Cmd msg
log payload =
    Outbound.log payload


pauseAudio : Cmd msg
pauseAudio =
    Outbound.pauseAudio


pauseVideos : Cmd msg
pauseVideos =
    Outbound.pauseVideos


playAudio : Cmd msg
playAudio =
    Outbound.playAudio


playVideos : Cmd msg
playVideos =
    Outbound.playVideos


requestFullscreen : Cmd msg
requestFullscreen =
    Outbound.requestFullscreen


setVolume : Int -> Cmd msg
setVolume volume =
    Outbound.setVolume volume


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    Outbound.skipToTrack trackNumber


toggleFullscreen : Cmd msg
toggleFullscreen =
    Outbound.toggleFullscreen
