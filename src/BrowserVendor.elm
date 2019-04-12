module BrowserVendor exposing (BrowserVendor(..), init)

import Flags exposing (Flags)
import Json.Decode as Decode
import Value


type BrowserVendor
    = Mozilla
    | Other
    | Webkit


init : Flags -> BrowserVendor
init flags =
    let
        browser =
            flags.browserVendor
                |> Value.extractString "other"
    in
    case browser of
        "mozilla" ->
            Mozilla

        "webkit" ->
            Webkit

        _ ->
            Other
