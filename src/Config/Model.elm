module Config.Model exposing
    ( Config
    , init
    , update
    )

import Flags exposing (Flags)
import Gif exposing (GifDisplayIntervalSeconds, GiphyAPIKey)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import Value


type alias Config =
    { gifDisplaySeconds : GifDisplayIntervalSeconds
    , giphyApiKey : GiphyAPIKey
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : List Tag
    , volumeAdjustmentRate : Int
    }


init : Flags -> Config
init flags =
    let
        rawGiphyApiKeyString =
            Value.extractStringWithDefault "" flags.giphyApiKey

        rawSoundCloudPlaylistUrlString =
            Value.extractStringWithDefault
                SoundCloud.defaultPlaylistUrlString
                flags.soundCloudPlaylistUrl
    in
    { gifDisplaySeconds = Gif.displayIntervalSeconds 4
    , giphyApiKey = Gif.giphyApiKey rawGiphyApiKeyString
    , soundCloudPlaylistUrl =
        SoundCloud.playlistUrl rawSoundCloudPlaylistUrlString
    , tags = []
    , volumeAdjustmentRate = 20
    }


update :
    SoundCloudPlaylistUrl
    -> String
    -> GifDisplayIntervalSeconds
    -> Config
    -> Config
update soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds config =
    let
        ignoreNonPositiveSeconds seconds =
            if seconds < 1 then
                config.gifDisplaySeconds

            else
                Gif.displayIntervalSeconds seconds

        gifDisplaySeconds =
            gifDisplayIntervalSeconds
                |> Gif.rawDisplayIntervalSeconds
                |> ignoreNonPositiveSeconds
    in
    { config
        | gifDisplaySeconds = gifDisplaySeconds
        , soundCloudPlaylistUrl = soundCloudPlaylistUrl
        , tags = Tag.tagList tagsString
    }
