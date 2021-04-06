module Tag exposing
    ( Tag
    , fetchTags
    , generateRandomTag
    , rawTag
    , rawTagsString
    , stringTagsToString
    , stringTagsToTagList
    , tagList
    )

import Http exposing (Error)
import Json.Decode as Decode exposing (Decoder)
import Random exposing (Generator)


type Tag
    = Tag String


fetchTags : (Result Error (List String) -> msg) -> Cmd msg
fetchTags tagsFetchedMsg =
    let
        tagsDecoder : Decoder (List String)
        tagsDecoder =
            Decode.at [ "tags" ] (Decode.list Decode.string)
    in
    Http.get
        { url = "tags.json"
        , expect = Http.expectJson tagsFetchedMsg tagsDecoder
        }


generateRandomTag : (Tag -> msg) -> List Tag -> Cmd msg
generateRandomTag randomTagGeneratedMsg tags =
    let
        tagsLength : Int
        tagsLength =
            List.length tags - 1

        randomTagIndex : Generator Int
        randomTagIndex =
            Random.int 0 tagsLength

        generator : Generator Tag
        generator =
            Random.map (atIndex tags) randomTagIndex
    in
    Random.generate randomTagGeneratedMsg generator


rawTag : Tag -> String
rawTag (Tag tagString) =
    tagString


rawTagsString : List Tag -> String
rawTagsString tagsList =
    tagsList
        |> List.map rawTag
        |> stringTagsToString


stringTagsToString : List String -> String
stringTagsToString tagsList =
    String.join separator tagsList


stringTagsToTagList : List String -> List Tag
stringTagsToTagList tagsList =
    List.map tag tagsList


tagList : String -> List Tag
tagList tagsString =
    tagsString
        |> String.split separator
        |> List.map String.trim
        |> stringTagsToTagList



-- PRIVATE


atIndex : List Tag -> Int -> Tag
atIndex tags index =
    let
        defaultTag : Tag
        defaultTag =
            Tag "80s"
    in
    tags
        |> List.drop index
        |> List.head
        |> Maybe.withDefault defaultTag


separator : String
separator =
    ", "


tag : String -> Tag
tag rawTagString =
    Tag rawTagString
