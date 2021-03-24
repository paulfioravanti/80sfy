port module Ports.Cmd exposing
    ( cmd
    , exitFullscreen
    , initSoundCloudWidget
    , log
    , logError
    , pauseVideos
    , playAudio
    , playVideos
    , setVolume
    , skipToTrack
    )

import Error
import Http exposing (Error)
import Json.Encode as Encode exposing (Value)
import PortMessage
import Ports.Msg as Msg exposing (Msg, SoundCloudWidgetPayload)


port outbound : Value -> Cmd msg


cmd : Msg -> Cmd msg
cmd msg =
    case msg of
        Msg.ExitFullscreen ->
            outbound (PortMessage.withTag "EXIT_FULL_SCREEN")

        Msg.HaltVideos ->
            outbound (PortMessage.withTag "HALT_VIDEOS")

        Msg.InitSoundCloudWidget { id, volume } ->
            let
                payload : Value
                payload =
                    Encode.object
                        [ ( "id", Encode.string id )
                        , ( "volume", Encode.int volume )
                        ]

                portMessage : Value
                portMessage =
                    PortMessage.withTaggedPayload ( "INIT_WIDGET", payload )
            in
            outbound portMessage

        Msg.Log payload ->
            outbound (PortMessage.withTaggedPayload ( "LOG", payload ))

        Msg.PauseAudio ->
            outbound (PortMessage.withTag "PAUSE_AUDIO")

        Msg.PauseVideos ->
            outbound (PortMessage.withTag "PAUSE_VIDEOS")

        Msg.PlayAudio ->
            outbound (PortMessage.withTag "PLAY_AUDIO")

        Msg.PlayVideos ->
            outbound (PortMessage.withTag "PLAY_VIDEOS")

        Msg.SetVolume volume ->
            let
                payload : Value
                payload =
                    Encode.object [ ( "volume", Encode.int volume ) ]

                portMessage : Value
                portMessage =
                    PortMessage.withTaggedPayload ( "SET_VOLUME", payload )
            in
            outbound portMessage

        Msg.SkipToTrack trackNumber ->
            let
                payload : Value
                payload =
                    Encode.object [ ( "trackNumber", Encode.int trackNumber ) ]

                portMessage : Value
                portMessage =
                    PortMessage.withTaggedPayload ( "SKIP_TO_TRACK", payload )
            in
            outbound portMessage

        Msg.ToggleFullscreen ->
            outbound (PortMessage.withTag "TOGGLE_FULL_SCREEN")


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


playAudio : Cmd msg
playAudio =
    cmd Msg.PlayAudio


playVideos : Cmd msg
playVideos =
    cmd Msg.PlayVideos


setVolume : Int -> Cmd msg
setVolume rawVolume =
    cmd (Msg.SetVolume rawVolume)


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    cmd (Msg.SkipToTrack trackNumber)
