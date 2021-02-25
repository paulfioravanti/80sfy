module Config.Model exposing
    ( Config
    , GiphyAPIKey
    , SoundCloudPlaylistUrl
    , init
    , rawGiphyApiKey
    , rawSoundCloudPlaylistUrl
    , update
    )

import Flags exposing (Flags)
import Tag exposing (Tag)
import Value


type GiphyAPIKey
    = GiphyAPIKey String


type SoundCloudPlaylistUrl
    = SoundCloudPlaylistUrl String


type alias Config =
    { gifDisplaySeconds : Float
    , giphyApiKey : GiphyAPIKey
    , soundCloudPlaylistUrl : SoundCloudPlaylistUrl
    , tags : List Tag
    , volumeAdjustmentRate : Int
    }


init : Flags -> Config
init flags =
    let
        rawGiphyApiKeyString =
            Value.extractStringWithDefault "" flags.giphyApiKey

        defaultSoundCloudPlaylistUrlString =
            "https://api.soundcloud.com/playlists/193785575"

        rawSoundCloudPlaylistUrlString =
            Value.extractStringWithDefault
                defaultSoundCloudPlaylistUrlString
                flags.soundCloudPlaylistUrl
    in
    { gifDisplaySeconds = 4
    , giphyApiKey = GiphyAPIKey rawGiphyApiKeyString
    , soundCloudPlaylistUrl =
        SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString
    , tags = []
    , volumeAdjustmentRate = 20
    }


rawGiphyApiKey : GiphyAPIKey -> String
rawGiphyApiKey (GiphyAPIKey rawGiphyApiKeyValue) =
    rawGiphyApiKeyValue


rawSoundCloudPlaylistUrl : SoundCloudPlaylistUrl -> String
rawSoundCloudPlaylistUrl (SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString) =
    rawSoundCloudPlaylistUrlString


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
        , soundCloudPlaylistUrl = SoundCloudPlaylistUrl soundCloudPlaylistUrl
        , tags = tags
    }
