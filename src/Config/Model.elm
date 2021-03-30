module Config.Model exposing
    ( Config
    , VolumeAdjustmentRate
    , init
    , rawVolumeAdjustmentRate
    )

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
