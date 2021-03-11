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

import Http exposing (Error)
import Json.Encode exposing (Value)
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
    Cmd.exitFullscreen


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portMsg =
    Msg.haltVideosMsg portMsg


initSoundCloudWidget : SoundCloudWidgetPayload -> Cmd msg
initSoundCloudWidget payload =
    Cmd.initSoundCloudWidget payload


log : Value -> Cmd msg
log payload =
    Cmd.log payload


logError : String -> Error -> Cmd msg
logError message error =
    Cmd.logError message error


pauseAudioMsg : (Msg -> msg) -> msg
pauseAudioMsg portMsg =
    Msg.pauseAudioMsg portMsg


pauseVideos : Cmd msg
pauseVideos =
    Cmd.pauseVideos


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg portMsg =
    Msg.pauseVideosParentMsg portMsg


playAudio : Cmd msg
playAudio =
    Cmd.playAudio


playAudioMsg : (Msg -> msg) -> msg
playAudioMsg portMsg =
    Msg.playAudioParentMsg portMsg


playVideos : Cmd msg
playVideos =
    Cmd.playVideos


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg portMsg =
    Msg.playVideosMsg portMsg


setVolume : Int -> Cmd msg
setVolume rawVolume =
    Cmd.setVolume rawVolume


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    Cmd.skipToTrack trackNumber


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portMsg =
    Msg.toggleFullscreenMsg portMsg
