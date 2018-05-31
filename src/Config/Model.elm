module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)
import Tag exposing (Tags)


type alias Config =
    { giphyApiKey : String
    , soundCloudPlaylistUrl : String
    , tags : Tags
    }


init : Flags -> Config
init flags =
    let
        giphyApiKey =
            flags.giphyApiKey
                |> fetchGiphyApiKey

        soundCloudPlaylistUrl =
            flags.soundCloudPlaylistUrl
                |> fetchSoundCloudPlaylistUrl
    in
        { giphyApiKey = giphyApiKey
        , soundCloudPlaylistUrl = soundCloudPlaylistUrl
        , tags = []
        }


fetchGiphyApiKey : Value -> String
fetchGiphyApiKey giphyApiKeyFlag =
    let
        giphyApiKey =
            giphyApiKeyFlag
                |> Decode.decodeValue Decode.string
    in
        case giphyApiKey of
            Ok apiKey ->
                apiKey

            Err _ ->
                ""


fetchSoundCloudPlaylistUrl : Value -> String
fetchSoundCloudPlaylistUrl soundCloudPlaylistUrlFlag =
    let
        soundCloudPlaylistUrl =
            soundCloudPlaylistUrlFlag
                |> Decode.decodeValue Decode.string
    in
        case soundCloudPlaylistUrl of
            Ok playlistUrl ->
                playlistUrl

            Err _ ->
                "http://api.soundcloud.com/playlists/193785575"
