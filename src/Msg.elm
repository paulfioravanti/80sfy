module Msg exposing (Msg(..))

import AudioPlayer
import Animation
import Http exposing (Error)
import Time exposing (Time)


type Msg
    = AnimateControlPanel Animation.Msg
    | AnimateVideoPlayer Animation.Msg
    | AudioPlayerMsg AudioPlayer.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
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
    | TogglePlaying Bool
    | ToggleSecretConfigVisibility
    | UpdateSecretConfigSoundCloudPlaylistUrl String
    | UpdateSecretConfigTags String
    | UseControlPanel Bool
