module Tag exposing (fetchTags, numToTag)

import Http exposing (Error)
import Json.Decode as Decode exposing (Decoder)


fetchTags : (Result Error (List String) -> msg) -> Cmd msg
fetchTags fetchTagsMsg =
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
