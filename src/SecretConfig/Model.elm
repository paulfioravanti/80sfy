module SecretConfig.Model exposing (SecretConfig, init)


type alias SecretConfig =
    { fetchNextGif : Bool
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : String
    , tags : String
    , visible : Bool
    }


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    { fetchNextGif = True
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible = False
    }
