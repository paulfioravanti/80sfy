module Gif exposing (fetchRandomGif, random)

import Http
import Json.Decode as Decode
import MsgConfig exposing (MsgConfig)
import Random
import Tags
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
