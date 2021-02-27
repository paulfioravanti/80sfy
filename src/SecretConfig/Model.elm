module SecretConfig.Model exposing (SecretConfig, init)

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)


type alias SecretConfig =
    { gifDisplaySeconds : GifDisplayIntervalSeconds
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : String
    , visible : Bool
    }


init : SoundCloudPlaylistUrl -> GifDisplayIntervalSeconds -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    { gifDisplaySeconds = gifDisplaySeconds
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible = False
    }
