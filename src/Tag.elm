module Tag exposing (fetchTags, random)

import Http
import Json.Decode as Decode exposing (Decoder)
import Msg exposing (Msg(FetchTags, RandomTag))
import Random


fetchTags : Cmd Msg
fetchTags =
    let
        tagsDecoder =
            Decode.at [ "tags" ] (Decode.list Decode.string)
    in
        tagsDecoder
            |> Http.get "tags.json"
            |> Http.send FetchTags


random : List String -> String -> Cmd Msg
random tags videoPlayerId =
    let
        tagsLength =
            List.length tags - 1

        generator =
            Random.int 1 tagsLength
                |> Random.map (numToTag tags)
    in
        generator
            |> Random.generate (RandomTag videoPlayerId)


numToTag : List String -> Int -> String
numToTag tags numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"
