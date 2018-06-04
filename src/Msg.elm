module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Time exposing (Time)


type Msg
    = AdjustVolume String
    | AnimateControlPanel Animation.Msg
    | AnimateVideoPlayer Animation.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
    | FetchNextGif String
    | FetchRandomGif String (Result Error String)
    | FetchTags (Result Error (List String))
    | HideControlPanel ()
    | InitSecretConfigTags (List String)
    | RandomTag String String
    | SaveConfig
    | ShowControlPanel
    | ToggleGifRotation Bool
    | ToggleFullScreen
    | ToggleInactivityPause
    | ToggleMute
    | TogglePlayPause
    | ToggleSecretConfigVisibility
    | UpdateSecretConfigSoundCloudPlaylistUrl String
    | UpdateSecretConfigTags String
    | UseControlPanel Bool
