module Tags exposing (fetchTags, tagAtIndex)

import Http exposing (Error)
import Json.Decode as Decode


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


tagAtIndex : List String -> Int -> String
tagAtIndex tags numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"
