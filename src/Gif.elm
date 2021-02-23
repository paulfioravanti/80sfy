module Gif exposing (fetchRandomGifUrl, random)

import Http exposing (Error)
import Json.Decode as Decode
import Random
import Tags


fetchRandomGifUrl : (Result Error String -> msg) -> String -> String -> Cmd msg
fetchRandomGifUrl randomGifUrlFetchedMsg giphyApiKey tag =
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

        decodeGifUrl =
            Decode.at [ "data", "image_mp4_url" ] Decode.string
    in
    Http.get
        { url = url
        , expect = Http.expectJson randomGifUrlFetchedMsg decodeGifUrl
        }


random : (String -> msg) -> List String -> Cmd msg
random randomTagGeneratedMsg tags =
    let
        tagsLength =
            List.length tags - 1

        randomTagIndex =
            Random.int 1 tagsLength

        generator =
            Random.map (Tags.tagAtIndex tags) randomTagIndex
    in
    Random.generate randomTagGeneratedMsg generator
