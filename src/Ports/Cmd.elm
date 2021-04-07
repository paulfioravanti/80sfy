port module Ports.Cmd exposing
    ( cmd
    , exitFullscreen
    , initSoundCloudWidget
    , log
    , logError
    , pauseVideos
    , play
    , playVideos
    , setVolume
    , skipToTrack
    )

import Error
import Http exposing (Error)
import Json.Encode as Encode exposing (Value)
import Ports.Msg as Msg exposing (Msg, SoundCloudWidgetPayload)
import Ports.Payload as Payload


port outbound : Value -> Cmd msg


cmd : Msg -> Cmd msg
cmd msg =
    case msg of
        Msg.ExitFullscreen ->
            outbound (Payload.withTag "EXIT_FULL_SCREEN")

        Msg.HaltVideos ->
            outbound (Payload.withTag "HALT_VIDEOS")

        Msg.InitSoundCloudWidget { id, volume } ->
            let
                data : Value
                data =
                    Encode.object
                        [ ( "id", Encode.string id )
                        , ( "volume", Encode.int volume )
                        ]

                payload : Value
                payload =
                    Payload.withTaggedData ( "INIT_WIDGET", data )
            in
            outbound payload

        Msg.Log data ->
            outbound (Payload.withTaggedData ( "LOG", data ))

        Msg.PauseAudio ->
            outbound (Payload.withTag "PAUSE_AUDIO")

        Msg.PauseVideos ->
            outbound (Payload.withTag "PAUSE_VIDEOS")

        Msg.Play ->
            Cmd.batch
                [ outbound (Payload.withTag "PLAY_VIDEOS")
                , outbound (Payload.withTag "PLAY_AUDIO")
                ]

        Msg.PlayAudio ->
            outbound (Payload.withTag "PLAY_AUDIO")

        Msg.PlayVideos ->
            outbound (Payload.withTag "PLAY_VIDEOS")

        Msg.SetVolume volume ->
            let
                data : Value
                data =
                    Encode.object [ ( "volume", Encode.int volume ) ]

                payload : Value
                payload =
                    Payload.withTaggedData ( "SET_VOLUME", data )
            in
            outbound payload

        Msg.SkipToTrack trackNumber ->
            let
                data : Value
                data =
                    Encode.object [ ( "trackNumber", Encode.int trackNumber ) ]

                payload : Value
                payload =
                    Payload.withTaggedData ( "SKIP_TO_TRACK", data )
            in
            outbound payload

        Msg.ToggleFullscreen ->
            outbound (Payload.withTag "TOGGLE_FULL_SCREEN")


exitFullscreen : Cmd msg
exitFullscreen =
    cmd Msg.ExitFullscreen


initSoundCloudWidget : SoundCloudWidgetPayload -> Cmd msg
initSoundCloudWidget payload =
    cmd (Msg.InitSoundCloudWidget payload)


log : Value -> Cmd msg
log payload =
    cmd (Msg.Log payload)


logError : String -> Error -> Cmd msg
logError message error =
    let
        payload : Value
        payload =
            Encode.object
                [ ( message
                  , Encode.string (Error.toString error)
                  )
                ]
    in
    log payload


pauseVideos : Cmd msg
pauseVideos =
    cmd Msg.PauseVideos


play : Cmd msg
play =
    cmd Msg.Play


playVideos : Cmd msg
playVideos =
    cmd Msg.PlayVideos


setVolume : Int -> Cmd msg
setVolume rawVolume =
    cmd (Msg.SetVolume rawVolume)


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    cmd (Msg.SkipToTrack trackNumber)
