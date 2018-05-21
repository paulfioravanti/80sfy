module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import Player exposing (Player)
import Msg exposing (Msg(GetRandomGif))
import Tag


fetchRandomGif : Player -> String -> Cmd Msg
fetchRandomGif player tag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        apiKey =
            "api_key=JASRREAAILxOCCf0awYF89DVBaH2BPl3"

        url =
            host
                ++ path
                ++ "?"
                ++ apiKey
                ++ "&tag="
                ++ tag
    in
        decodeGifUrl
            |> Http.get url
            |> Http.send (GetRandomGif player)


random : Player -> Cmd Msg
random player =
    Tag.random player


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
