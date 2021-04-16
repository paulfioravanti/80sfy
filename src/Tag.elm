module Tag exposing
    ( Tag
    , fetchTags
    , generateRandomTag
    , rawTag
    , stringTagsToString
    , stringTagsToTagList
    , stringToTagList
    , tagListToString
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


stringTagsToString : List String -> String
stringTagsToString tagsList =
    String.join separator tagsList


stringTagsToTagList : List String -> List Tag
stringTagsToTagList tagsList =
    List.map tag tagsList


stringToTagList : String -> Maybe (List Tag)
stringToTagList tagsString =
    let
        tagsStringIsEmpty : Bool
        tagsStringIsEmpty =
            tagsString
                |> String.trim
                |> String.isEmpty
    in
    if tagsStringIsEmpty then
        Nothing

    else
        let
            tagList : List Tag
            tagList =
                tagsString
                    |> String.split separator
                    |> List.map String.trim
                    |> stringTagsToTagList
        in
        Just tagList


tagListToString : List Tag -> String
tagListToString tagsList =
    tagsList
        |> List.map rawTag
        |> stringTagsToString



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
    ","


tag : String -> Tag
tag rawTagString =
    Tag rawTagString
