module Gif exposing
    ( GifDisplayIntervalSeconds
    , GifUrl
    , GiphyAPIKey
    , displayIntervalSeconds
    , fetchRandomGifUrl
    , giphyApiKey
    , rawDisplayIntervalSeconds
    , rawUrl
    , rawUrlFromWebData
    , updateDisplayIntervalSeconds
    , url
    )

import Error
import Http exposing (Error)
import Json.Decode as Decode exposing (Decoder)
import RemoteData exposing (WebData)
import Tag exposing (Tag)


type GifDisplayIntervalSeconds
    = GifDisplayIntervalSeconds Float


type GifUrl
    = GifUrl String


type GiphyAPIKey
    = GiphyAPIKey String


displayIntervalSeconds : Float -> GifDisplayIntervalSeconds
displayIntervalSeconds rawDisplayIntervalSecondsFloat =
    GifDisplayIntervalSeconds rawDisplayIntervalSecondsFloat


fetchRandomGifUrl :
    (Result Error String -> msg)
    -> GiphyAPIKey
    -> Tag
    -> Cmd msg
fetchRandomGifUrl randomGifUrlFetchedMsg (GiphyAPIKey apiKey) tag =
    let
        host : String
        host =
            "https://api.giphy.com"

        path : String
        path =
            "/v1/gifs/random"

        rawTag : String
        rawTag =
            Tag.rawTag tag

        giphyUrl : String
        giphyUrl =
            String.join
                ""
                [ host
                , path
                , "?api_key="
                , apiKey
                , "&tag="
                , rawTag
                , "&rating="
                , "pg-13"
                ]

        decodeGifUrl : Decoder String
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


rawDisplayIntervalSeconds : GifDisplayIntervalSeconds -> Float
rawDisplayIntervalSeconds (GifDisplayIntervalSeconds rawDisplayIntervalSecondsFloat) =
    rawDisplayIntervalSecondsFloat


rawUrl : GifUrl -> String
rawUrl (GifUrl rawUrlString) =
    rawUrlString


rawUrlFromWebData : WebData GifUrl -> String
rawUrlFromWebData webData =
    case webData of
        RemoteData.NotAsked ->
            "NotAsked"

        RemoteData.Loading ->
            "Loading"

        RemoteData.Failure error ->
            "Failure: " ++ Error.toString error

        RemoteData.Success gifUrl ->
            rawUrl gifUrl


updateDisplayIntervalSeconds :
    String
    -> GifDisplayIntervalSeconds
    -> GifDisplayIntervalSeconds
updateDisplayIntervalSeconds seconds defaultDisplayIntervalSeconds =
    let
        defaultGifDisplayIntervalSeconds : Float
        defaultGifDisplayIntervalSeconds =
            rawDisplayIntervalSeconds defaultDisplayIntervalSeconds
    in
    seconds
        |> String.toFloat
        |> Maybe.withDefault defaultGifDisplayIntervalSeconds
        |> displayIntervalSeconds


url : String -> GifUrl
url rawUrlString =
    GifUrl rawUrlString
