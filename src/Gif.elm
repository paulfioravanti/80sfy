module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import Msg exposing (Msg(FetchRandomGif))
import Tag exposing (Tags)
import VideoPlayer exposing (VideoPlayerId)


fetchRandomGif : String -> VideoPlayerId -> String -> Cmd Msg
fetchRandomGif giphyApiKey videoPlayerId tag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        url =
            host
                ++ path
                ++ "?"
                ++ "api_key="
                ++ giphyApiKey
                ++ "&tag="
                ++ tag
                ++ "&rating=pg-13"
    in
        decodeGifUrl
            |> Http.get url
            |> Http.send (FetchRandomGif videoPlayerId)


random : Tags -> VideoPlayerId -> Cmd Msg
random tags videoPlayerId =
    Tag.random tags videoPlayerId


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
