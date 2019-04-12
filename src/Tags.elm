module Tags exposing (init, tagAtIndex)

import Http exposing (Error)
import Json.Decode as Decode


init : (Result Error (List String) -> msg) -> Cmd msg
init fetchTagsMsg =
    let
        tagsDecoder =
            Decode.at [ "tags" ] (Decode.list Decode.string)
    in
    Http.get
        { url = "tags.json"
        , expect = Http.expectJson fetchTagsMsg tagsDecoder
        }


tagAtIndex : List String -> Int -> String
tagAtIndex tags numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"
