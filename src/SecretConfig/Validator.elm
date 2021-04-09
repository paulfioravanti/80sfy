module SecretConfig.Validator exposing
    ( validateGifDisplayIntervalSeconds
    , validateSoundCloudPlaylistUrl
    , validateTags
    )

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)


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
        ( currentTags, Tag.tagListToString currentTags )

    else
        ( Tag.stringToTagList tagsField, tagsField )
