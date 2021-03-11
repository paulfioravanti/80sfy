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


playAudioMsg : Msg
playAudioMsg =
    Msg.playAudioMsg


playAudioParentMsg : (Msg -> msg) -> msg
playAudioParentMsg portMsg =
    Msg.playAudioParentMsg portMsg


playVideosMsg : Msg
playVideosMsg =
    Msg.playVideosMsg


playVideosParentMsg : (Msg -> msg) -> msg
playVideosParentMsg portMsg =
    Msg.playVideosParentMsg portMsg


setVolumeMsg : Int -> Msg
setVolumeMsg rawVolume =
    Msg.setVolumeMsg rawVolume


skipToTrackMsg : Int -> Msg
skipToTrackMsg trackNumber =
    Msg.skipToTrackMsg trackNumber


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portMsg =
    Msg.toggleFullscreenMsg portMsg
