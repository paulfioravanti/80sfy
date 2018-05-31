module Config.Model exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)
import Tag exposing (Tags)


type alias Config =
    { giphyApiKey : String
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
    in
        { giphyApiKey = giphyApiKey
        , tags = []
        , visible = True
        }
