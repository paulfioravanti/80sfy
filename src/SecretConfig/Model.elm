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

        giphyApiKey : String
        giphyApiKey =
            Value.extractStringWithDefault "" flags.giphyApiKey

        rawSoundCloudPlaylistUrl : String
        rawSoundCloudPlaylistUrl =
            Value.extractStringWithDefault
                SoundCloud.defaultPlaylistUrlString
                flags.soundCloudPlaylistUrl

        soundCloudPlaylistUrl : SoundCloudPlaylistUrl
        soundCloudPlaylistUrl =
            rawSoundCloudPlaylistUrl
                |> SoundCloud.playlistUrl
                |> Maybe.withDefault SoundCloud.defaultPlaylistUrl
    in
    { gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
    , gifDisplayIntervalSecondsField = gifDisplayIntervalSecondsField
    , giphyApiKey = Gif.giphyApiKey giphyApiKey
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , soundCloudPlaylistUrlField =
        SoundCloud.rawPlaylistUrl soundCloudPlaylistUrl
    , tags = []
    , tagsField = ""
    , visible = False
    , volumeAdjustmentRate = VolumeAdjustmentRate 20
    }


rawVolumeAdjustmentRate : VolumeAdjustmentRate -> Int
rawVolumeAdjustmentRate (VolumeAdjustmentRate rawVolumeAdjustmentRateInt) =
    rawVolumeAdjustmentRateInt
