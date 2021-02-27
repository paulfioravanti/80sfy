module SecretConfig.Model exposing (SecretConfig, init)

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)


type alias SecretConfig =
    { gifDisplaySeconds : GifDisplayIntervalSeconds
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : TagsString
    , visible : Bool
    }


init : SoundCloudPlaylistUrl -> GifDisplayIntervalSeconds -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    { gifDisplaySeconds = gifDisplaySeconds
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = Tag.tagsString ""
    , visible = False
    }
