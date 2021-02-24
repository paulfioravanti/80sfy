module Gif exposing (fetchRandomGifUrl)

import Http exposing (Error)
import Json.Decode as Decode


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
