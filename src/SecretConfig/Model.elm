module SecretConfig.Model exposing (SecretConfig, init, update)

import Flags exposing (Flags)
import Gif exposing (GifDisplayIntervalSeconds, GiphyAPIKey)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import Value


type alias SecretConfig =
    { gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , giphyApiKey : GiphyAPIKey
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : List Tag
    , visible : Bool
    }


init : Flags -> SoundCloudPlaylistUrl -> GifDisplayIntervalSeconds -> SecretConfig
init flags soundCloudPlaylistUrl gifDisplayIntervalSeconds =
    let
        rawGiphyApiKeyString : String
        rawGiphyApiKeyString =
            Value.extractStringWithDefault "" flags.giphyApiKey
    in
    { gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
    , giphyApiKey = Gif.giphyApiKey rawGiphyApiKeyString
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
