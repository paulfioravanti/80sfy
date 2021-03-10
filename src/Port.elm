port module Port exposing
    ( Msg
    , SoundCloudWidgetPayload
    , cmd
    , exitFullscreenMsg
    , haltVideosMsg
    , inbound
    , initSoundCloudWidget
    , log
    , logError
    , outbound
    , pauseAudioMsg
    , pauseAudioPortMsg
    , pauseVideosMsg
    , pauseVideosPortMsg
    , playAudioMsg
    , playAudioPortMsg
    , playVideosMsg
    , playVideosPortMsg
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
    | HaltVideos
    | PauseAudio
    | PauseVideos
    | PlayAudio
    | PlayVideos
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

        HaltVideos ->
            outbound (PortMessage.withTag "HALT_VIDEOS")

        PauseAudio ->
            outbound (PortMessage.withTag "PAUSE_AUDIO")

        PauseVideos ->
            outbound (PortMessage.withTag "PAUSE_VIDEOS")

        PlayAudio ->
            outbound (PortMessage.withTag "PLAY_AUDIO")

        PlayVideos ->
            outbound (PortMessage.withTag "PLAY_VIDEOS")

        ToggleFullscreen ->
            outbound (PortMessage.withTag "TOGGLE_FULL_SCREEN")


exitFullscreenMsg : Msg
exitFullscreenMsg =
    ExitFullscreen


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portMsg =
    portMsg HaltVideos


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


pauseAudioMsg : Msg
pauseAudioMsg =
    PauseAudio


pauseAudioPortMsg : (Msg -> msg) -> msg
pauseAudioPortMsg portMsg =
    portMsg PauseAudio


pauseVideosMsg : Msg
pauseVideosMsg =
    PauseVideos


pauseVideosPortMsg : (Msg -> msg) -> msg
pauseVideosPortMsg portMsg =
    portMsg PauseVideos


playAudioMsg : Msg
playAudioMsg =
    PlayAudio


playAudioPortMsg : (Msg -> msg) -> msg
playAudioPortMsg portMsg =
    portMsg PlayAudio


playVideosMsg : Msg
playVideosMsg =
    PlayVideos


playVideosPortMsg : (Msg -> msg) -> msg
playVideosPortMsg portMsg =
    portMsg PlayVideos


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
