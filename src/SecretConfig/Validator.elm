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
    case String.toFloat gifDisplayIntervalSecondsField of
        Just gifDisplayIntervalSecondsFloat ->
            let
                gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
                gifDisplayIntervalSeconds =
                    gifDisplayIntervalSecondsFloat
                        |> Gif.displayIntervalSeconds
                        |> Maybe.withDefault currentGifDisplayIntervalSeconds
            in
            ( gifDisplayIntervalSeconds
            , gifDisplayIntervalSecondsField
            )

        Nothing ->
            let
                currentGifDisplayIntervalSecondsString : String
                currentGifDisplayIntervalSecondsString =
                    currentGifDisplayIntervalSeconds
                        |> Gif.rawDisplayIntervalSeconds
                        |> String.fromFloat
            in
            ( currentGifDisplayIntervalSeconds
            , currentGifDisplayIntervalSecondsString
            )


validateSoundCloudPlaylistUrl :
    SoundCloudPlaylistUrl
    -> String
    -> ( SoundCloudPlaylistUrl, String )
validateSoundCloudPlaylistUrl currentSoundCloudPlaylistUrl soundCloudPlaylistUrlField =
    case SoundCloud.playlistUrl soundCloudPlaylistUrlField of
        Just soundCloudPlaylistUrl ->
            ( soundCloudPlaylistUrl
            , soundCloudPlaylistUrlField
            )

        Nothing ->
            ( currentSoundCloudPlaylistUrl
            , SoundCloud.rawPlaylistUrl currentSoundCloudPlaylistUrl
            )


validateTags : List Tag -> String -> ( List Tag, String )
validateTags currentTags tagsField =
    case Tag.stringToTagList tagsField of
        Just tagList ->
            ( tagList, tagsField )

        Nothing ->
            ( currentTags, Tag.tagListToString currentTags )
