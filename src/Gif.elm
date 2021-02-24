module Gif exposing (fetchRandomGifUrl, random)

import Http exposing (Error)
import Json.Decode as Decode
import Random
import Tag exposing (Tag)


fetchRandomGifUrl : (Result Error String -> msg) -> String -> String -> Cmd msg
fetchRandomGifUrl randomGifUrlFetchedMsg rawGiphyApiKey rawTag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        url =
            host
                ++ path
                ++ "?api_key="
                ++ rawGiphyApiKey
                ++ "&tag="
                ++ rawTag
                ++ "&rating=pg-13"

        decodeGifUrl =
            Decode.at [ "data", "image_mp4_url" ] Decode.string
    in
    Http.get
        { url = url
        , expect = Http.expectJson randomGifUrlFetchedMsg decodeGifUrl
        }


random : (Tag -> msg) -> List Tag -> Cmd msg
random randomTagGeneratedMsg tags =
    let
        tagsLength =
            List.length tags - 1

        randomTagIndex =
            Random.int 1 tagsLength

        generator =
            Random.map (Tag.atIndex tags) randomTagIndex
    in
    Random.generate randomTagGeneratedMsg generator
