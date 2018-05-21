module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import Player exposing (Id)
import Msg exposing (Msg(GetRandomGif))
import Tag


fetchRandomGif : Id -> String -> Cmd Msg
fetchRandomGif playerId tag =
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
                ++ "&rating=pg-13"
    in
        decodeGifUrl
            |> Http.get url
            |> Http.send (GetRandomGif playerId)


random : Id -> Cmd Msg
random playerId =
    Tag.random playerId


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
