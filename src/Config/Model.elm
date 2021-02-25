module Config.Model exposing
    ( Config
    , init
    , update
    )

import Flags exposing (Flags)
import Gif exposing (GiphyAPIKey)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import Value


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

        rawSoundCloudPlaylistUrlString =
            Value.extractStringWithDefault
                SoundCloud.defaultPlaylistUrlString
                flags.soundCloudPlaylistUrl
    in
    { gifDisplaySeconds = 4
    , giphyApiKey = Gif.giphyApiKey rawGiphyApiKeyString
    , soundCloudPlaylistUrl =
        SoundCloud.playlistUrl rawSoundCloudPlaylistUrlString
    , tags = []
    , volumeAdjustmentRate = 20
    }


update : SoundCloudPlaylistUrl -> String -> String -> Config -> Config
update soundCloudPlaylistUrl tagsString gifDisplaySecondsString config =
    let
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
        , tags = Tag.tagList tagsString
    }
