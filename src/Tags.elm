module Tags exposing (init, numToTag)

import Http exposing (Error)
import Json.Decode as Decode


init : (Result Error (List String) -> msg) -> Cmd msg
init fetchTagsMsg =
    let
        tagsDecoder =
            Decode.at [ "tags" ] (Decode.list Decode.string)
    in
        tagsDecoder
            |> Http.get "tags.json"
            |> Http.send fetchTagsMsg


numToTag : List String -> Int -> String
numToTag tags numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"
