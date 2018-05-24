module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import Msg exposing (Msg(FetchRandomGif))
import Tag
import VideoPlayer exposing (VideoPlayerId)


fetchRandomGif : VideoPlayerId -> String -> Cmd Msg
fetchRandomGif videoPlayerId tag =
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
            |> Http.send (FetchRandomGif videoPlayerId)


random : VideoPlayerId -> Cmd Msg
random videoPlayerId =
    Tag.random videoPlayerId


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
