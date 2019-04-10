module BrowserVendor exposing (Vendor(..), init)

import Flags exposing (Flags)
import Json.Decode as Decode


type Vendor
    = Mozilla
    | Other
    | Webkit


init : Flags -> Vendor
init flags =
    let
        browser =
            flags.browserVendor
                |> Decode.decodeValue Decode.string
                |> Result.withDefault "other"
    in
    case browser of
        "mozilla" ->
            Mozilla

        "webkit" ->
            Webkit

        _ ->
            Other
