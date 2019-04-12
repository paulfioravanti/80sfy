module BrowserVendor exposing (BrowserVendor(..), init)

import Flags exposing (Flags)
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
                |> Value.extractStringWithDefault "other"
    in
    case browser of
        "mozilla" ->
            Mozilla

        "webkit" ->
            Webkit

        _ ->
            Other
