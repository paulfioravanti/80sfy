module Tag exposing (Tags, fetchTags, random)

import Http
import Json.Decode as Decode exposing (Decoder)
import Msg exposing (Msg(FetchTags, RandomTag))
import Random
import VideoPlayer exposing (VideoPlayerId)


type alias Tags =
    List String


fetchTags : Cmd Msg
fetchTags =
    tagsDecoder
        |> Http.get "tags.json"
        |> Http.send FetchTags


random : Tags -> VideoPlayerId -> Cmd Msg
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


numToTag : Tags -> Int -> String
numToTag tags numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"


tagsDecoder : Decoder Tags
tagsDecoder =
    Decode.at [ "tags" ] (Decode.list Decode.string)
