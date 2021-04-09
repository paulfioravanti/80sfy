module SecretConfig.Model exposing
    ( SecretConfig
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


type alias SecretConfig =
    { gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , gifDisplayIntervalSecondsField : String
    , giphyApiKey : GiphyAPIKey
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , soundCloudPlaylistUrlField : String
    , tags : List Tag
    , tagsField : String
    , visible : Bool
    , volumeAdjustmentRate : VolumeAdjustmentRate
    }


init : Flags -> SecretConfig
init flags =
    let
        defaultGifDisplayIntervalSeconds : Float
        defaultGifDisplayIntervalSeconds =
            4

        gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
        gifDisplayIntervalSeconds =
            Gif.displayIntervalSeconds defaultGifDisplayIntervalSeconds

        gifDisplayIntervalSecondsString : String
        gifDisplayIntervalSecondsString =
            String.fromFloat defaultGifDisplayIntervalSeconds

        rawGiphyApiKeyString : String
        rawGiphyApiKeyString =
            Value.extractStringWithDefault "" flags.giphyApiKey

        rawSoundCloudPlaylistUrlString : String
        rawSoundCloudPlaylistUrlString =
            Value.extractStringWithDefault
                SoundCloud.defaultPlaylistUrlString
                flags.soundCloudPlaylistUrl
    in
    { gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
    , gifDisplayIntervalSecondsField = gifDisplayIntervalSecondsString
    , giphyApiKey = Gif.giphyApiKey rawGiphyApiKeyString
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl =
        SoundCloud.playlistUrl rawSoundCloudPlaylistUrlString
    , soundCloudPlaylistUrlField = rawSoundCloudPlaylistUrlString
    , tags = []
    , tagsField = ""
    , visible = False
    , volumeAdjustmentRate = VolumeAdjustmentRate 20
    }


rawVolumeAdjustmentRate : VolumeAdjustmentRate -> Int
rawVolumeAdjustmentRate (VolumeAdjustmentRate rawVolumeAdjustmentRateInt) =
    rawVolumeAdjustmentRateInt
