module Gif exposing
    ( GiphyAPIKey
    , fetchRandomGifUrl
    , giphyApiKey
    , rawGiphyApiKey
    )

import Http exposing (Error)
import Json.Decode as Decode


type GiphyAPIKey
    = GiphyAPIKey String


fetchRandomGifUrl :
    (Result Error String -> msg)
    -> GiphyAPIKey
    -> String
    -> Cmd msg
fetchRandomGifUrl randomGifUrlFetchedMsg apiKey rawTag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        url =
            host
                ++ path
                ++ "?api_key="
                ++ rawGiphyApiKey apiKey
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


giphyApiKey : String -> GiphyAPIKey
giphyApiKey rawGiphyApiKeyString =
    GiphyAPIKey rawGiphyApiKeyString


rawGiphyApiKey : GiphyAPIKey -> String
rawGiphyApiKey (GiphyAPIKey rawGiphyApiKeyString) =
    rawGiphyApiKeyString
