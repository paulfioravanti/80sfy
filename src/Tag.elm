module Tag exposing (random)

import Player exposing (Player)
import Msg exposing (Msg(RandomTag))
import Random


random : Player -> Cmd Msg
random player =
    let
        generator =
            Random.int 1 (List.length tags - 1)
                |> Random.map numToTag
    in
        generator
            |> Random.generate (RandomTag player)


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
    , "tron"
    , "grid"
    , "nes"
    , "8bit"
    , "pixel"
    , "neon"
    , "geometry"
    , "kidmograph"
    ]
