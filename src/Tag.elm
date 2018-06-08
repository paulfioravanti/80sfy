module Tag exposing (fetchTags, random)

import Config.Msg exposing (Msg(FetchTags, RandomTag))
import Http
import Json.Decode as Decode exposing (Decoder)
import MsgConfig exposing (MsgConfig)
import Random


fetchTags : MsgConfig msg -> Cmd msg
fetchTags { configMsg } =
    let
        tagsDecoder =
            Decode.at [ "tags" ] (Decode.list Decode.string)
    in
        tagsDecoder
            |> Http.get "tags.json"
            |> Http.send (configMsg << FetchTags)


random : MsgConfig msg -> List String -> String -> Cmd msg
random { configMsg } tags videoPlayerId =
    let
        tagsLength =
            List.length tags - 1

        generator =
            Random.int 1 tagsLength
                |> Random.map (numToTag tags)
    in
        generator
            |> Random.generate (configMsg << RandomTag videoPlayerId)


numToTag : List String -> Int -> String
numToTag tags numberOfMembers =
    tags
        |> List.drop numberOfMembers
        |> List.head
        |> Maybe.withDefault "80s"
