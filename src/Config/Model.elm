module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)


type alias Config =
    { giphyApiKey : String
    , soundCloudPlaylistUrl : String
    , tags : List String
    }


init : Flags -> Config
init flags =
    let
        giphyApiKey =
            flags.giphyApiKey
                |> extractStringValue ""

        soundCloudPlaylistUrl =
            flags.soundCloudPlaylistUrl
                |> extractStringValue
                    "https://api.soundcloud.com/playlists/193785575"
    in
        { giphyApiKey = giphyApiKey
        , soundCloudPlaylistUrl = soundCloudPlaylistUrl
        , tags = []
        }


extractStringValue : String -> Value -> String
extractStringValue fallbackString flag =
    let
        stringValue =
            flag
                |> Decode.decodeValue Decode.string
    in
        case stringValue of
            Ok string ->
                string

            Err _ ->
                fallbackString
