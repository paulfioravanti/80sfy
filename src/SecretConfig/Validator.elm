module SecretConfig.Validator exposing (ValidatedFields, validate)

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)


type alias Context a =
    { a
        | gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
        , gifDisplayIntervalSecondsField : String
        , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
        , soundCloudPlaylistUrlField : String
        , tags : List Tag
        , tagsField : String
    }


type alias ValidatedFields =
    { gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , gifDisplayIntervalSecondsField : String
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , soundCloudPlaylistUrlField : String
    , tags : List Tag
    , tagsField : String
    }


validate : Context a -> ValidatedFields
validate context =
    let
        ( gifDisplayIntervalSeconds, gifDisplayIntervalSecondsField ) =
            validateGifDisplayIntervalSeconds
                context.gifDisplayIntervalSeconds
                context.gifDisplayIntervalSecondsField

        ( soundCloudPlaylistUrl, soundCloudPlaylistUrlField ) =
            validateSoundCloudPlaylistUrl
                context.soundCloudPlaylistUrl
                context.soundCloudPlaylistUrlField

        ( tags, tagsField ) =
            validateTags
                context.tags
                context.tagsField
    in
    { gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
    , gifDisplayIntervalSecondsField = gifDisplayIntervalSecondsField
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , soundCloudPlaylistUrlField = soundCloudPlaylistUrlField
    , tags = tags
    , tagsField = tagsField
    }



-- PRIVATE


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
