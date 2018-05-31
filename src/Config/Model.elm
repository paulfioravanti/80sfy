module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)
import Tag exposing (Tags)


type alias Config =
    { giphyApiKey : String
    , playlistUrl : String
    , tags : Tags
    , visible : Bool
    }


init : Flags -> Config
init flags =
    let
        giphyApiKeyFlag =
            flags.giphyApiKey
                |> Decode.decodeValue Decode.string

        giphyApiKey =
            case giphyApiKeyFlag of
                Ok apiKey ->
                    apiKey

                Err _ ->
                    ""

        playlistUrl =
            "http://api.soundcloud.com/playlists/193785575"
    in
        { giphyApiKey = giphyApiKey
        , playlistUrl = playlistUrl
        , tags = []
        , visible = True
        }
