port module Port exposing
    ( Msg
    , SoundCloudWidgetPayload
    , cmd
    , exitFullscreenMsg
    , haltVideosMsg
    , inbound
    , initSoundCloudWidgetMsg
    , log
    , logError
    , outbound
    , pauseAudioMsg
    , pauseAudioParentMsg
    , pauseVideosMsg
    , pauseVideosParentMsg
    , playAudioMsg
    , playAudioParentMsg
    , playVideosMsg
    , playVideosParentMsg
    , setVolumeMsg
    , skipToTrackMsg
    , toggleFullscreenMsg
    )

import Error
import Http exposing (Error)
import Json.Encode as Encode exposing (Value)
import PortMessage exposing (PortMessage)


type Msg
    = ExitFullscreen
    | HaltVideos
    | InitSoundCloudWidget SoundCloudWidgetPayload
    | Log Value
    | PauseAudio
    | PauseVideos
    | PlayAudio
    | PlayVideos
    | SetVolume Int
    | SkipToTrack Int
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

        InitSoundCloudWidget { id, volume } ->
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

        Log payload ->
            outbound (PortMessage.withTaggedPayload ( "LOG", payload ))

        PauseAudio ->
            outbound (PortMessage.withTag "PAUSE_AUDIO")

        PauseVideos ->
            outbound (PortMessage.withTag "PAUSE_VIDEOS")

        PlayAudio ->
            outbound (PortMessage.withTag "PLAY_AUDIO")

        PlayVideos ->
            outbound (PortMessage.withTag "PLAY_VIDEOS")

        SetVolume volume ->
            let
                payload =
                    Encode.object [ ( "volume", Encode.int volume ) ]

                portMessage =
                    PortMessage.withTaggedPayload ( "SET_VOLUME", payload )
            in
            outbound portMessage

        SkipToTrack trackNumber ->
            let
                payload =
                    Encode.object [ ( "trackNumber", Encode.int trackNumber ) ]

                portMessage =
                    PortMessage.withTaggedPayload ( "SKIP_TO_TRACK", payload )
            in
            outbound portMessage

        ToggleFullscreen ->
            outbound (PortMessage.withTag "TOGGLE_FULL_SCREEN")


exitFullscreenMsg : Msg
exitFullscreenMsg =
    ExitFullscreen


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portMsg =
    portMsg HaltVideos


initSoundCloudWidgetMsg : SoundCloudWidgetPayload -> Msg
initSoundCloudWidgetMsg payload =
    InitSoundCloudWidget payload


log : Value -> Cmd msg
log payload =
    cmd (Log payload)


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
    cmd (Log payload)


pauseAudioMsg : Msg
pauseAudioMsg =
    PauseAudio


pauseAudioParentMsg : (Msg -> msg) -> msg
pauseAudioParentMsg portMsg =
    portMsg PauseAudio


pauseVideosMsg : Msg
pauseVideosMsg =
    PauseVideos


pauseVideosParentMsg : (Msg -> msg) -> msg
pauseVideosParentMsg portMsg =
    portMsg PauseVideos


playAudioMsg : Msg
playAudioMsg =
    PlayAudio


playAudioParentMsg : (Msg -> msg) -> msg
playAudioParentMsg portMsg =
    portMsg PlayAudio


playVideosMsg : Msg
playVideosMsg =
    PlayVideos


playVideosParentMsg : (Msg -> msg) -> msg
playVideosParentMsg portMsg =
    portMsg PlayVideos


setVolumeMsg : Int -> Msg
setVolumeMsg rawVolume =
    SetVolume rawVolume


skipToTrackMsg : Int -> Msg
skipToTrackMsg trackNumber =
    SkipToTrack trackNumber


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portMsg =
    portMsg ToggleFullscreen
