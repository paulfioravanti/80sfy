port module Ports exposing
    ( Msg
    , Payload
    , SoundCloudWidgetPayload
    , cmd
    , decodePayload
    , exitFullscreen
    , haltVideosMsg
    , inbound
    , initSoundCloudWidget
    , log
    , logError
    , pauseAudioMsg
    , pauseVideos
    , pauseVideosMsg
    , performPause
    , play
    , playAudioMsg
    , playMsg
    , playVideos
    , playVideosMsg
    , setVolume
    , skipToTrack
    , toggleFullscreenMsg
    )

import Http exposing (Error)
import Json.Encode exposing (Value)
import Ports.Cmd as Cmd
import Ports.Msg as Msg
import Ports.Payload as Payload
import Ports.Task as Task


type alias Msg =
    Msg.Msg


type alias Payload =
    Payload.Payload


type alias SoundCloudWidgetPayload =
    Msg.SoundCloudWidgetPayload


port inbound : (Value -> msg) -> Sub msg


cmd : Msg -> Cmd msg
cmd msg =
    Cmd.cmd msg


decodePayload : Value -> Payload
decodePayload payload =
    Payload.decode payload


exitFullscreen : Cmd msg
exitFullscreen =
    Cmd.exitFullscreen


haltVideosMsg : Msg
haltVideosMsg =
    Msg.HaltVideos


initSoundCloudWidget : SoundCloudWidgetPayload -> Cmd msg
initSoundCloudWidget data =
    Cmd.initSoundCloudWidget data


log : Value -> Cmd msg
log data =
    Cmd.log data


logError : String -> Error -> Cmd msg
logError message error =
    Cmd.logError message error


pauseAudioMsg : Msg
pauseAudioMsg =
    Msg.PauseAudio


pauseVideos : Cmd msg
pauseVideos =
    Cmd.pauseVideos


pauseVideosMsg : Msg
pauseVideosMsg =
    Msg.PauseVideos


performPause : (Msg -> msg) -> Cmd msg
performPause portsMsg =
    Task.performPause portsMsg


play : Cmd msg
play =
    Cmd.play


playMsg : Msg
playMsg =
    Msg.Play


playAudioMsg : Msg
playAudioMsg =
    Msg.PlayAudio


playVideos : Cmd msg
playVideos =
    Cmd.playVideos


playVideosMsg : Msg
playVideosMsg =
    Msg.PlayVideos


setVolume : Int -> Cmd msg
setVolume rawVolume =
    Cmd.setVolume rawVolume


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    Cmd.skipToTrack trackNumber


toggleFullscreenMsg : Msg
toggleFullscreenMsg =
    Msg.ToggleFullscreen
