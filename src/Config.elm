module Config exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)


type alias Config =
    { giphyApiKey : String }


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
        { giphyApiKey = giphyApiKey }
