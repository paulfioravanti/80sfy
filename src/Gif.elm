module Gif exposing (fetchRandomGif, random)

import Http exposing (Error)
import Json.Decode as Decode
import Random
import Tags


fetchRandomGif : (Result Error String -> msg) -> String -> String -> Cmd msg
fetchRandomGif fetchRandomGifMsg giphyApiKey tag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        url =
            host
                ++ path
                ++ "?api_key="
                ++ giphyApiKey
                ++ "&tag="
                ++ tag
                ++ "&rating=pg-13"
    in
        decodeGifUrl
            |> Http.get url
            |> Http.send fetchRandomGifMsg


random : (String -> msg) -> List String -> Cmd msg
random randomTagMsg tags =
    let
        tagsLength =
            List.length tags - 1

        generator =
            Random.int 1 tagsLength
                |> Random.map (Tags.numToTag tags)
    in
        generator
            |> Random.generate randomTagMsg


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
