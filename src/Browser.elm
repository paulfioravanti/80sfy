module Browser exposing (Browser, init)

import Json.Decode as Decode exposing (Value)
import Flags exposing (Flags)


type Browser
    = Mozilla
    | Unknown
    | Webkit


init : Flags -> Browser
init flags =
    let
        browser =
            flags.browser
                |> Decode.decodeValue Decode.string
                |> Result.withDefault "unknown"
    in
        case browser of
            "mozilla" ->
                Mozilla

            "webkit" ->
                Webkit

            _ ->
                Unknown
