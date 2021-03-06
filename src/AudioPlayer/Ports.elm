module AudioPlayer.Ports exposing
    ( pauseAudio
    , playAudio
    , setVolume
    , skipToTrack
    )

import Json.Encode as Encode
import PortMessage
import Ports


pauseAudio : Cmd msg
pauseAudio =
    Ports.outbound (PortMessage.withTag "PAUSE_AUDIO")


playAudio : Cmd msg
playAudio =
    Ports.outbound (PortMessage.withTag "PLAY_AUDIO")


setVolume : Int -> Cmd msg
setVolume volume =
    let
        payload =
            Encode.object [ ( "volume", Encode.int volume ) ]

        portMessage =
            PortMessage.withTaggedPayload ( "SET_VOLUME", payload )
    in
    Ports.outbound portMessage


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    let
        payload =
            Encode.object [ ( "trackNumber", Encode.int trackNumber ) ]

        portMessage =
            PortMessage.withTaggedPayload ( "SKIP_TO_TRACK", payload )
    in
    Ports.outbound portMessage
