module SecretConfig.Model exposing (SecretConfig, init)

import SoundCloud exposing (SoundCloudPlaylistUrl)


type alias SecretConfig =
    { gifDisplaySeconds : String
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : String
    , visible : Bool
    }


init : SoundCloudPlaylistUrl -> Float -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    { gifDisplaySeconds = String.fromFloat gifDisplaySeconds
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible = False
    }
