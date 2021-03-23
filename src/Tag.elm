module Tag exposing
    ( Tag
    , TagsString
    , fetchTags
    , generateRandomTag
    , listToTagsString
    , rawTag
    , rawTagsString
    , tag
    , tagList
    , tagsString
    )

import Http exposing (Error)
import Json.Decode as Decode exposing (Decoder)
import Random exposing (Generator)


type Tag
    = Tag String


type TagsString
    = TagsString String


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


listToTagsString : List String -> TagsString
listToTagsString tags =
    tags
        |> String.join ", "
        |> tagsString


rawTag : Tag -> String
rawTag (Tag tagString) =
    tagString


rawTagsString : TagsString -> String
rawTagsString (TagsString tagsStringString) =
    tagsStringString


tag : String -> Tag
tag rawTagString =
    Tag rawTagString


tagList : TagsString -> List Tag
tagList (TagsString rawTagsStringString) =
    rawTagsStringString
        |> String.split ", "
        |> List.map String.trim
        |> List.map tag


tagsString : String -> TagsString
tagsString rawTagsStringString =
    TagsString rawTagsStringString



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
