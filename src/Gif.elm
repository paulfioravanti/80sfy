module Gif exposing
    ( GifUrl
    , GiphyAPIKey
    , fetchRandomGifUrl
    , giphyApiKey
    , rawGiphyApiKey
    , rawUrl
    , rawWebDataUrl
    , url
    )

import Error
import Http exposing (Error)
import Json.Decode as Decode
import RemoteData exposing (WebData)
import Tag exposing (Tag)


type GifUrl
    = GifUrl String


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

        giphyUrl =
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
        { url = giphyUrl
        , expect = Http.expectJson randomGifUrlFetchedMsg decodeGifUrl
        }


giphyApiKey : String -> GiphyAPIKey
giphyApiKey rawGiphyApiKeyString =
    GiphyAPIKey rawGiphyApiKeyString


rawGiphyApiKey : GiphyAPIKey -> String
rawGiphyApiKey (GiphyAPIKey rawGiphyApiKeyString) =
    rawGiphyApiKeyString


rawUrl : GifUrl -> String
rawUrl (GifUrl rawUrlString) =
    rawUrlString


rawWebDataUrl : WebData GifUrl -> String
rawWebDataUrl webData =
    case webData of
        RemoteData.NotAsked ->
            "NotAsked"

        RemoteData.Loading ->
            "Loading"

        RemoteData.Failure error ->
            "Failure: " ++ Error.toString error

        RemoteData.Success gifUrl ->
            rawUrl gifUrl


url : String -> GifUrl
url rawUrlString =
    GifUrl rawUrlString
