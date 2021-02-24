module Config.Model exposing
    ( Config
    , GiphyAPIKey
    , init
    , rawGiphyApiKey
    , update
    )

import Flags exposing (Flags)
import Tag exposing (Tag)
import Value


type GiphyAPIKey
    = GiphyAPIKey String


type alias Config =
    { gifDisplaySeconds : Float
    , giphyApiKey : GiphyAPIKey
    , soundCloudPlaylistUrl : String
    , tags : List Tag
    , volumeAdjustmentRate : Int
    }


init : Flags -> Config
init flags =
    let
        rawGiphyApiKeyValue =
            Value.extractStringWithDefault "" flags.giphyApiKey

        defaultSoundCloudPlaylistUrl =
            "https://api.soundcloud.com/playlists/193785575"

        soundCloudPlaylistUrl =
            flags.soundCloudPlaylistUrl
                |> Value.extractStringWithDefault defaultSoundCloudPlaylistUrl
    in
    { gifDisplaySeconds = 4
    , giphyApiKey = GiphyAPIKey rawGiphyApiKeyValue
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = []
    , volumeAdjustmentRate = 20
    }


rawGiphyApiKey : GiphyAPIKey -> String
rawGiphyApiKey (GiphyAPIKey rawGiphyApiKeyValue) =
    rawGiphyApiKeyValue


update : String -> String -> String -> Config -> Config
update soundCloudPlaylistUrl tagsString gifDisplaySecondsString config =
    let
        tags =
            tagsString
                |> String.split ", "
                |> List.map String.trim
                |> List.map Tag.tag

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
