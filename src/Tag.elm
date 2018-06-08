module Tag exposing (fetchTags, random)

import Config.Msg exposing (Msg(RandomTag))
import Http exposing (Error)
import Json.Decode as Decode exposing (Decoder)
import MsgConfig exposing (MsgConfig)
import Random


fetchTags : (Result Error (List String) -> msg) -> Cmd msg
fetchTags fetchTagsMsg =
    let
        tagsDecoder =
            Decode.at [ "tags" ] (Decode.list Decode.string)
    in
        tagsDecoder
            |> Http.get "tags.json"
            |> Http.send fetchTagsMsg


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
