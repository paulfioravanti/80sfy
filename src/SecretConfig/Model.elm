module SecretConfig.Model exposing
    ( SecretConfig
    , VolumeAdjustmentRate
    , init
    , rawVolumeAdjustmentRate
    , validateGifDisplayIntervalSeconds
    , validateSoundCloudPlaylistUrl
    , validateTags
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


validateGifDisplayIntervalSeconds :
    GifDisplayIntervalSeconds
    -> String
    -> ( GifDisplayIntervalSeconds, String )
validateGifDisplayIntervalSeconds currentGifDisplayIntervalSeconds gifDisplayIntervalSecondsField =
    let
        parsedGifDisplayIntervalSeconds : Maybe Float
        parsedGifDisplayIntervalSeconds =
            String.toFloat gifDisplayIntervalSecondsField
    in
    case parsedGifDisplayIntervalSeconds of
        Just gifDisplayIntervalSeconds ->
            ( Gif.displayIntervalSeconds gifDisplayIntervalSeconds
            , gifDisplayIntervalSecondsField
            )

        Nothing ->
            let
                gifDisplayIntervalSecondsString : String
                gifDisplayIntervalSecondsString =
                    currentGifDisplayIntervalSeconds
                        |> Gif.rawDisplayIntervalSeconds
                        |> String.fromFloat
            in
            ( currentGifDisplayIntervalSeconds
            , gifDisplayIntervalSecondsString
            )


validateSoundCloudPlaylistUrl :
    SoundCloudPlaylistUrl
    -> String
    -> ( SoundCloudPlaylistUrl, String )
validateSoundCloudPlaylistUrl currentSoundCloudPlaylistUrl soundCloudPlaylistUrlField =
    let
        isValidUrl : Bool
        isValidUrl =
            String.startsWith
                SoundCloud.playlistUrlPrefix
                soundCloudPlaylistUrlField
    in
    if isValidUrl then
        ( SoundCloud.playlistUrl soundCloudPlaylistUrlField
        , soundCloudPlaylistUrlField
        )

    else
        ( currentSoundCloudPlaylistUrl
        , SoundCloud.rawPlaylistUrl currentSoundCloudPlaylistUrl
        )


validateTags : List Tag -> String -> ( List Tag, String )
validateTags currentTags tagsField =
    let
        tagsFieldIsEmpty : Bool
        tagsFieldIsEmpty =
            tagsField
                |> String.trim
                |> String.isEmpty
    in
    if tagsFieldIsEmpty then
        ( currentTags, Tag.rawTagsString currentTags )

    else
        ( Tag.tagList tagsField, tagsField )
