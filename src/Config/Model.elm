module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)


type alias Config =
    { giphyApiKey : String
    , soundCloudClientId : String
    , soundCloudPlaylistUrl : String
    , tags : List String
    }


init : Flags -> Config
init flags =
    let
        giphyApiKey =
            flags.giphyApiKey
                |> fetchGiphyApiKey

        soundCloudClientId =
            flags.soundCloudClientId
                |> fetchSoundCloudClientId

        soundCloudPlaylistUrl =
            flags.soundCloudPlaylistUrl
                |> fetchSoundCloudPlaylistUrl
    in
        { giphyApiKey = giphyApiKey
        , soundCloudClientId = soundCloudClientId
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


fetchSoundCloudClientId : Value -> String
fetchSoundCloudClientId soundCloudClientIdFlag =
    let
        soundCloudClientId =
            soundCloudClientIdFlag
                |> Decode.decodeValue Decode.string
    in
        case soundCloudClientId of
            Ok clientId ->
                clientId

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
