port module Port exposing
    ( Msg
    , SoundCloudWidgetPayload
    , cmd
    , exitFullscreenMsg
    , haltVideos
    , inbound
    , initSoundCloudWidget
    , log
    , logError
    , outbound
    , pauseAudioMsg
    , pauseVideos
    , playAudio
    , playVideos
    , setVolume
    , skipToTrack
    , toggleFullscreenMsg
    )

import Error
import Http exposing (Error)
import Json.Encode as Encode exposing (Value)
import PortMessage exposing (PortMessage)


type Msg
    = ExitFullscreen
    | PauseAudio
    | ToggleFullscreen


type alias SoundCloudWidgetPayload =
    { id : String
    , volume : Int
    }


port inbound : (Value -> msg) -> Sub msg


port outbound : PortMessage -> Cmd msg


cmd : Msg -> Cmd msg
cmd msg =
    case msg of
        ExitFullscreen ->
            outbound (PortMessage.withTag "EXIT_FULL_SCREEN")

        PauseAudio ->
            outbound (PortMessage.withTag "PAUSE_AUDIO")

        ToggleFullscreen ->
            outbound (PortMessage.withTag "TOGGLE_FULL_SCREEN")


exitFullscreenMsg : Msg
exitFullscreenMsg =
    ExitFullscreen


haltVideos : Cmd msg
haltVideos =
    outbound (PortMessage.withTag "HALT_VIDEOS")


initSoundCloudWidget : SoundCloudWidgetPayload -> Cmd msg
initSoundCloudWidget { id, volume } =
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


logError : String -> Error -> Cmd msg
logError message error =
    let
        payload =
            Encode.object
                [ ( message
                  , Encode.string (Error.toString error)
                  )
                ]
    in
    log payload


pauseAudioMsg : (Msg -> msg) -> msg
pauseAudioMsg portMsg =
    portMsg PauseAudio


pauseVideos : Cmd msg
pauseVideos =
    outbound (PortMessage.withTag "PAUSE_VIDEOS")


playAudio : Cmd msg
playAudio =
    outbound (PortMessage.withTag "PLAY_AUDIO")


playVideos : Cmd msg
playVideos =
    outbound (PortMessage.withTag "PLAY_VIDEOS")


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


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portMsg =
    portMsg ToggleFullscreen
