module SecretConfig exposing (SecretConfig, init, setTags)

import Tag exposing (Tags)


type alias SecretConfig =
    { soundCloudPlaylistUrl : String
    , tags : String
    , visible : Bool
    }


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    { soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible =
        True
        -- FIXME change to False
    }


setTags : Tags -> SecretConfig -> SecretConfig
setTags tagsList secretConfig =
    let
        tags =
            tagsList
                |> String.join ", "
    in
        { secretConfig | tags = tags }
