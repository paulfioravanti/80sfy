port module Port.Outbound exposing
    ( exitFullscreen
    , haltVideos
    , initSoundCloudWidget
    , log
    , pauseAudio
    , pauseVideos
    , playAudio
    , playVideos
    , requestFullscreen
    , setVolume
    , skipToTrack
    , toggleFullscreen
    )

import Json.Encode as Encode exposing (Value)
import PortMessage exposing (PortMessage)


port outbound : PortMessage -> Cmd msg


exitFullscreen : Cmd msg
exitFullscreen =
    outbound (PortMessage.withTag "EXIT_FULL_SCREEN")


haltVideos : Cmd msg
haltVideos =
    outbound (PortMessage.withTag "HALT_VIDEOS")


initSoundCloudWidget : ( String, Int ) -> Cmd msg
initSoundCloudWidget ( id, volume ) =
    let
        payload =
            Encode.object
                [ ( "id", Encode.string id )
                , ( "volume", Encode.int volume )
                ]

        portMessage =
            PortMessage.withTaggedPayload ( "INIT_WIDGET", payload )
    in
    outbound portMessage


log : Value -> Cmd msg
log payload =
    outbound (PortMessage.withTaggedPayload ( "LOG", payload ))


pauseAudio : Cmd msg
pauseAudio =
    outbound (PortMessage.withTag "PAUSE_AUDIO")


pauseVideos : Cmd msg
pauseVideos =
    outbound (PortMessage.withTag "PAUSE_VIDEOS")


playAudio : Cmd msg
playAudio =
    outbound (PortMessage.withTag "PLAY_AUDIO")


playVideos : Cmd msg
playVideos =
    outbound (PortMessage.withTag "PLAY_VIDEOS")


requestFullscreen : Cmd msg
requestFullscreen =
    outbound (PortMessage.withTag "REQUEST_FULLSCREEN")


setVolume : Int -> Cmd msg
setVolume volume =
    let
        payload =
            Encode.object [ ( "volume", Encode.int volume ) ]

        portMessage =
            PortMessage.withTaggedPayload ( "SET_VOLUME", payload )
    in
    outbound portMessage


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    let
        payload =
            Encode.object [ ( "trackNumber", Encode.int trackNumber ) ]

        portMessage =
            PortMessage.withTaggedPayload ( "SKIP_TO_TRACK", payload )
    in
    outbound portMessage


toggleFullscreen : Cmd msg
toggleFullscreen =
    outbound (PortMessage.withTag "TOGGLE_FULLSCREEN")
