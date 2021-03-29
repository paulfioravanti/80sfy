module SecretConfig.Model exposing (SecretConfig, init, update)

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)


type alias SecretConfig =
    { gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : List Tag
    , visible : Bool
    }


init : SoundCloudPlaylistUrl -> GifDisplayIntervalSeconds -> SecretConfig
init soundCloudPlaylistUrl gifDisplayIntervalSeconds =
    { gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = []
    , visible = False
    }


update :
    SoundCloudPlaylistUrl
    -> List Tag
    -> GifDisplayIntervalSeconds
    -> SecretConfig
    -> SecretConfig
update soundCloudPlaylistUrl tags gifDisplayIntervalSeconds config =
    let
        ignoreNonPositiveSeconds : Float -> GifDisplayIntervalSeconds
        ignoreNonPositiveSeconds seconds =
            if seconds < 1 then
                config.gifDisplayIntervalSeconds

            else
                Gif.displayIntervalSeconds seconds

        displayIntervalSeconds : GifDisplayIntervalSeconds
        displayIntervalSeconds =
            gifDisplayIntervalSeconds
                |> Gif.rawDisplayIntervalSeconds
                |> ignoreNonPositiveSeconds
    in
    { config
        | gifDisplayIntervalSeconds = displayIntervalSeconds
        , soundCloudPlaylistUrl = soundCloudPlaylistUrl
        , tags = tags
    }
