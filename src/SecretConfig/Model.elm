module SecretConfig.Model exposing (SecretConfig, init)


type alias SecretConfig =
    { soundCloudPlaylistUrl : String
    , tags : String
    , visible : Bool
    }


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    { soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible = False
    }
