module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import Msg exposing (Msg(GetRandomGif))
import Tag
import VideoPlayer exposing (VideoPlayer)


fetchRandomGif : VideoPlayer -> String -> Cmd Msg
fetchRandomGif videoPlayer tag =
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
            |> Http.send (GetRandomGif videoPlayer.id)


random : VideoPlayer -> Cmd Msg
random player =
    Tag.random player


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
