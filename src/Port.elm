port module Port exposing
    ( Msg
    , SoundCloudWidgetPayload
    , cmd
    , exitFullscreen
    , haltVideosMsg
    , inbound
    , initSoundCloudWidget
    , log
    , logError
    , pauseAudioMsg
    , pauseAudioParentMsg
    , pauseVideos
    , pauseVideosMsg
    , playAudio
    , playAudioMsg
    , playVideos
    , playVideosMsg
    , setVolume
    , skipToTrack
    , toggleFullscreenMsg
    )

import Error
import Http exposing (Error)
import Json.Encode as Encode exposing (Value)
import Port.Cmd as Cmd
import Port.Msg as Msg


type alias Msg =
    Msg.Msg


type alias SoundCloudWidgetPayload =
    Msg.SoundCloudWidgetPayload


port inbound : (Value -> msg) -> Sub msg


cmd : Msg -> Cmd msg
cmd msg =
    Cmd.cmd msg


exitFullscreen : Cmd msg
exitFullscreen =
    cmd Msg.ExitFullscreen


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portMsg =
    Msg.haltVideosMsg portMsg


initSoundCloudWidget : SoundCloudWidgetPayload -> Cmd msg
initSoundCloudWidget payload =
    cmd (Msg.InitSoundCloudWidget payload)


log : Value -> Cmd msg
log payload =
    cmd (Msg.Log payload)


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
    Msg.pauseAudioMsg


pauseAudioParentMsg : (Msg -> msg) -> msg
pauseAudioParentMsg portMsg =
    Msg.pauseAudioParentMsg portMsg


pauseVideos : Cmd msg
pauseVideos =
    cmd Msg.PauseVideos


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg portMsg =
    Msg.pauseVideosParentMsg portMsg


playAudio : Cmd msg
playAudio =
    cmd Msg.PlayAudio


playAudioMsg : (Msg -> msg) -> msg
playAudioMsg portMsg =
    Msg.playAudioParentMsg portMsg


playVideos : Cmd msg
playVideos =
    cmd Msg.PlayVideos


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg portMsg =
    Msg.playVideosMsg portMsg


setVolume : Int -> Cmd msg
setVolume rawVolume =
    cmd (Msg.SetVolume rawVolume)


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    cmd (Msg.SkipToTrack trackNumber)


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portMsg =
    Msg.toggleFullscreenMsg portMsg
