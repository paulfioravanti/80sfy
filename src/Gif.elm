module Gif exposing
    ( GiphyAPIKey
    , fetchRandomGifUrl
    , giphyApiKey
    , rawGiphyApiKey
    )

import Http exposing (Error)
import Json.Decode as Decode
import Tag exposing (Tag)


type GiphyAPIKey
    = GiphyAPIKey String


fetchRandomGifUrl :
    (Result Error String -> msg)
    -> GiphyAPIKey
    -> Tag
    -> Cmd msg
fetchRandomGifUrl randomGifUrlFetchedMsg apiKey tag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        rawTag =
            Tag.rawTag tag

        url =
            host
                ++ path
                ++ "?api_key="
                ++ rawGiphyApiKey apiKey
                ++ "&tag="
                ++ rawTag
                ++ "&rating="
                ++ "pg-13"

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
