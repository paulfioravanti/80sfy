module Ports.Msg exposing
    ( Msg(..)
    , SoundCloudWidgetPayload
    , exitFullscreenMsg
    , haltVideosMsg
    , initSoundCloudWidgetMsg
    , pauseAudioMsg
    , pauseVideosMsg
    , pauseVideosParentMsg
    , playAudioMsg
    , playAudioParentMsg
    , playVideosMsg
    , setVolumeMsg
    , skipToTrackMsg
    , toggleFullscreenMsg
    )

import Json.Encode exposing (Value)


type alias SoundCloudWidgetPayload =
    { id : String
    , volume : Int
    }


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


exitFullscreenMsg : Msg
exitFullscreenMsg =
    ExitFullscreen


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portsMsg =
    portsMsg HaltVideos


initSoundCloudWidgetMsg : SoundCloudWidgetPayload -> Msg
initSoundCloudWidgetMsg payload =
    InitSoundCloudWidget payload


pauseAudioMsg : (Msg -> msg) -> msg
pauseAudioMsg portsMsg =
    portsMsg PauseAudio


pauseVideosMsg : Msg
pauseVideosMsg =
    PauseVideos


pauseVideosParentMsg : (Msg -> msg) -> msg
pauseVideosParentMsg portsMsg =
    portsMsg PauseVideos


playAudioMsg : Msg
playAudioMsg =
    PlayAudio


playAudioParentMsg : (Msg -> msg) -> msg
playAudioParentMsg portsMsg =
    portsMsg PlayAudio


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg portsMsg =
    portsMsg PlayVideos


setVolumeMsg : Int -> Msg
setVolumeMsg rawVolume =
    SetVolume rawVolume


skipToTrackMsg : Int -> Msg
skipToTrackMsg trackNumber =
    SkipToTrack trackNumber


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portsMsg =
    portsMsg ToggleFullscreen
