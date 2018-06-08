module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import MsgConfig exposing (MsgConfig)
import Tag
import VideoPlayer.Msg exposing (Msg(FetchRandomGif))


fetchRandomGif : MsgConfig msg -> String -> String -> String -> Cmd msg
fetchRandomGif { videoPlayerMsg } giphyApiKey videoPlayerId tag =
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
            |> Http.send (videoPlayerMsg << (FetchRandomGif videoPlayerId))


random : MsgConfig msg -> List String -> String -> Cmd msg
random msgConfig tags videoPlayerId =
    Tag.random msgConfig tags videoPlayerId


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string
