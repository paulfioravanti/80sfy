module Port.Msg exposing
    ( Msg(..)
    , SoundCloudWidgetPayload
    , exitFullscreenMsg
    , haltVideosMsg
    , initSoundCloudWidgetMsg
    , logMsg
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
haltVideosMsg portMsg =
    portMsg HaltVideos


initSoundCloudWidgetMsg : SoundCloudWidgetPayload -> Msg
initSoundCloudWidgetMsg payload =
    InitSoundCloudWidget payload


logMsg : Value -> Msg
logMsg payload =
    Log payload


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
