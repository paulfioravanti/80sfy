port module Port exposing
    ( Msg
    , SoundCloudWidgetPayload
    , cmd
    , exitFullscreen
    , haltVideosMsg
    , inbound
    , initSoundCloudWidgetMsg
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
    , setVolumeMsg
    , skipToTrackMsg
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
    Cmd.cmd Msg.ExitFullscreen


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portMsg =
    Msg.haltVideosMsg portMsg


initSoundCloudWidgetMsg : SoundCloudWidgetPayload -> Msg
initSoundCloudWidgetMsg payload =
    Msg.initSoundCloudWidgetMsg payload


log : Value -> Cmd msg
log payload =
    cmd (Msg.logMsg payload)


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
    Cmd.cmd Msg.PauseVideos


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg portMsg =
    Msg.pauseVideosParentMsg portMsg


playAudio : Cmd msg
playAudio =
    Cmd.cmd Msg.PlayAudio


playAudioMsg : (Msg -> msg) -> msg
playAudioMsg portMsg =
    Msg.playAudioParentMsg portMsg


playVideos : Cmd msg
playVideos =
    Cmd.cmd Msg.PlayVideos


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg portMsg =
    Msg.playVideosMsg portMsg


setVolumeMsg : Int -> Msg
setVolumeMsg rawVolume =
    Msg.setVolumeMsg rawVolume


skipToTrackMsg : Int -> Msg
skipToTrackMsg trackNumber =
    Msg.skipToTrackMsg trackNumber


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portMsg =
    Msg.toggleFullscreenMsg portMsg
