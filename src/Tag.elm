module Tag exposing (Tag, fetchTags, generateRandomTag, rawTag, tag, tagList)

import Http exposing (Error)
import Json.Decode as Decode
import Random


type Tag
    = Tag String


fetchTags : (Result Error (List String) -> msg) -> Cmd msg
fetchTags tagsFetchedMsg =
    let
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
        tagsLength =
            List.length tags - 1

        randomTagIndex =
            Random.int 1 tagsLength

        generator =
            Random.map (atIndex tags) randomTagIndex
    in
    Random.generate randomTagGeneratedMsg generator


rawTag : Tag -> String
rawTag (Tag tagString) =
    tagString


tag : String -> Tag
tag tagString =
    Tag tagString


tagList : String -> List Tag
tagList tagsString =
    tagsString
        |> String.split ", "
        |> List.map String.trim
        |> List.map tag



-- PRIVATE


atIndex : List Tag -> Int -> Tag
atIndex tags index =
    let
        defaultTag =
            Tag "80s"
    in
    tags
        |> List.drop index
        |> List.head
        |> Maybe.withDefault defaultTag
