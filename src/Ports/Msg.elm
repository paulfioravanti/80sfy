module Ports.Msg exposing
    ( Msg(..)
    , SoundCloudWidgetPayload
    , haltVideosMsg
    , pauseAudioMsg
    , pauseVideosMsg
    , playAudioMsg
    , playVideosMsg
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


haltVideosMsg : (Msg -> msg) -> msg
haltVideosMsg portsMsg =
    portsMsg HaltVideos


pauseAudioMsg : (Msg -> msg) -> msg
pauseAudioMsg portsMsg =
    portsMsg PauseAudio


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg portsMsg =
    portsMsg PauseVideos


playAudioMsg : (Msg -> msg) -> msg
playAudioMsg portsMsg =
    portsMsg PlayAudio


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg portsMsg =
    portsMsg PlayVideos


toggleFullscreenMsg : (Msg -> msg) -> msg
toggleFullscreenMsg portsMsg =
    portsMsg ToggleFullscreen
