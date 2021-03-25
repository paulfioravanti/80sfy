module Ports.Msg exposing (Msg(..), SoundCloudWidgetPayload)

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
