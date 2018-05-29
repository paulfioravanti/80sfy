module Tag exposing (Tags, fetchTags, random)

import Http
import Json.Decode as Decode exposing (Decoder)
import Msg exposing (Msg(FetchTags, RandomTag))
import Random
import VideoPlayer exposing (VideoPlayerId)


type alias Tags =
    List String


tagsDecoder : Decoder Tags
tagsDecoder =
    Decode.at [ "tags" ] (Decode.list Decode.string)


fetchTags : Cmd Msg
fetchTags =
    tagsDecoder
        |> Http.get "tags.json"
        |> Http.send FetchTags


random : VideoPlayerId -> Cmd Msg
random videoPlayerId =
    let
        tagsLength =
            List.length tags - 1

        generator =
            Random.int 1 tagsLength
                |> Random.map numToTag
    in
        generator
            |> Random.generate (RandomTag videoPlayerId)


numToTag : Int -> String
numToTag numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"


tags : List String
tags =
    [ "80s"
    , "1980"
    , "80s art"
    , "80s animation"
    , "80s tv"
    , "80s food"
    , "80s movie"
    , "80s music"
    , "80s miami"
    , "80s fashion"
    , "80s scifi"
    , "80s anime"
    , "80s video games"
    , "80s video"
    , "vhs"
    , "synthwave"
    , "80s tron"
    , "grid"
    , "nes"
    , "8bit"
    , "pixel"
    , "neon"
    , "geometry"
    , "kidmograph"
    ]
