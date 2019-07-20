module Config.Model exposing (Config, init, update)

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
                |> Value.extractStringWithDefault ""

        soundCloudPlaylistUrl =
            flags.soundCloudPlaylistUrl
                |> Value.extractStringWithDefault
                    "https://api.soundcloud.com/playlists/193785575"
    in
    { gifDisplaySeconds = 4
    , giphyApiKey = giphyApiKey
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = []
    , volumeAdjustmentRate = 20
    }


update : String -> String -> String -> Config -> Config
update soundCloudPlaylistUrl tagsString gifDisplaySecondsString config =
    let
        tags =
            tagsString
                |> String.split ", "
                |> List.map String.trim

        ignoreNonPositiveSeconds seconds =
            if seconds < 1 then
                config.gifDisplaySeconds

            else
                seconds

        gifDisplaySeconds =
            gifDisplaySecondsString
                |> String.toFloat
                |> Maybe.map ignoreNonPositiveSeconds
                |> Maybe.withDefault config.gifDisplaySeconds
    in
    { config
        | gifDisplaySeconds = gifDisplaySeconds
        , soundCloudPlaylistUrl = soundCloudPlaylistUrl
        , tags = tags
    }
