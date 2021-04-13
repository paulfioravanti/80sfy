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
        gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
        gifDisplayIntervalSeconds =
            Gif.defaultDisplayIntervalSeconds

        gifDisplayIntervalSecondsField : String
        gifDisplayIntervalSecondsField =
            gifDisplayIntervalSeconds
                |> Gif.rawDisplayIntervalSeconds
                |> String.fromFloat

        rawGiphyApiKeyString : String
        rawGiphyApiKeyString =
            Value.extractStringWithDefault "" flags.giphyApiKey

        rawSoundCloudPlaylistUrlField : String
        rawSoundCloudPlaylistUrlField =
            Value.extractStringWithDefault
                SoundCloud.defaultPlaylistUrlString
                flags.soundCloudPlaylistUrl
    in
    { gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
    , gifDisplayIntervalSecondsField = gifDisplayIntervalSecondsField
    , giphyApiKey = Gif.giphyApiKey rawGiphyApiKeyString
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl =
        SoundCloud.playlistUrl rawSoundCloudPlaylistUrlField
    , soundCloudPlaylistUrlField = rawSoundCloudPlaylistUrlField
    , tags = []
    , tagsField = ""
    , visible = False
    , volumeAdjustmentRate = VolumeAdjustmentRate 20
    }


rawVolumeAdjustmentRate : VolumeAdjustmentRate -> Int
rawVolumeAdjustmentRate (VolumeAdjustmentRate rawVolumeAdjustmentRateInt) =
    rawVolumeAdjustmentRateInt
