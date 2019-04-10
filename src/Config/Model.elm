module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)


type alias Config =
    { gifDisplaySeconds : Float
    , giphyApiKey : String
    , soundCloudPlaylistUrl : String
    , tags : List String
    , volumeAdjustmentRate : Int
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
    { gifDisplaySeconds = 4
    , giphyApiKey = giphyApiKey
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = []
    , volumeAdjustmentRate = 20
    }


extractStringValue : String -> Value -> String
extractStringValue fallbackString flag =
    flag
        |> Decode.decodeValue Decode.string
        |> Result.withDefault fallbackString
