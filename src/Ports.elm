port module Ports exposing
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
import Ports.Cmd as Cmd
import Ports.Msg as Msg


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
haltVideosMsg portsMsg =
    Msg.haltVideosMsg portsMsg


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
pauseAudioMsg portsMsg =
    Msg.pauseAudioMsg portsMsg


pauseVideos : Cmd msg
pauseVideos =
    Cmd.pauseVideos


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg portsMsg =
    Msg.pauseVideosMsg portsMsg


playAudio : Cmd msg
playAudio =
    Cmd.playAudio


playAudioMsg : (Msg -> msg) -> msg
playAudioMsg portsMsg =
    Msg.playAudioMsg portsMsg


playVideos : Cmd msg
playVideos =
    Cmd.playVideos


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg portsMsg =
    Msg.playVideosMsg portsMsg


setVolume : Int -> Cmd msg
setVolume rawVolume =
    Cmd.setVolume rawVolume


skipToTrack : Int -> Cmd msg
skipToTrack trackNumber =
    Cmd.skipToTrack trackNumber


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portsMsg =
    Msg.toggleFullscreenMsg portsMsg
