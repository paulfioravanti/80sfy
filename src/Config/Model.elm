module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Value


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
                |> Value.extractString ""

        soundCloudPlaylistUrl =
            flags.soundCloudPlaylistUrl
                |> Value.extractString
                    "https://api.soundcloud.com/playlists/193785575"
    in
    { gifDisplaySeconds = 4
    , giphyApiKey = giphyApiKey
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = []
    , volumeAdjustmentRate = 20
    }
