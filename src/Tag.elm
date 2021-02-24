module Tag exposing (Tag, atIndex, fetchTags, rawTag, tag)

import Http exposing (Error)
import Json.Decode as Decode


type Tag
    = Tag String


atIndex : List Tag -> Int -> Tag
atIndex tags index =
    tags
        |> List.drop index
        |> List.head
        |> Maybe.withDefault (Tag "80s")


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


rawTag : Tag -> String
rawTag (Tag tagString) =
    tagString


tag : String -> Tag
tag tagString =
    Tag tagString
