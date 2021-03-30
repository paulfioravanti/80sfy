module Config.Model exposing (Config, VolumeAdjustmentRate, init, rawVolumeAdjustmentRate, update)

import Flags exposing (Flags)
import Gif exposing (GifDisplayIntervalSeconds, GiphyAPIKey)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import Value


type VolumeAdjustmentRate
    = VolumeAdjustmentRate Int


type alias Config =
    { gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , giphyApiKey : GiphyAPIKey
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : List Tag
    , visible : Bool
    , volumeAdjustmentRate : VolumeAdjustmentRate
    }


init : Flags -> Config
init flags =
    let
        rawGiphyApiKeyString : String
        rawGiphyApiKeyString =
            Value.extractStringWithDefault "" flags.giphyApiKey

        rawSoundCloudPlaylistUrlString : String
        rawSoundCloudPlaylistUrlString =
            Value.extractStringWithDefault
                SoundCloud.defaultPlaylistUrlString
                flags.soundCloudPlaylistUrl
    in
    { gifDisplayIntervalSeconds = Gif.displayIntervalSeconds 4
    , giphyApiKey = Gif.giphyApiKey rawGiphyApiKeyString
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl =
        SoundCloud.playlistUrl rawSoundCloudPlaylistUrlString
    , tags = []
    , visible = False
    , volumeAdjustmentRate = VolumeAdjustmentRate 20
    }


rawVolumeAdjustmentRate : VolumeAdjustmentRate -> Int
rawVolumeAdjustmentRate (VolumeAdjustmentRate rawVolumeAdjustmentRateInt) =
    rawVolumeAdjustmentRateInt


update :
    SoundCloudPlaylistUrl
    -> List Tag
    -> GifDisplayIntervalSeconds
    -> Config
    -> Config
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
