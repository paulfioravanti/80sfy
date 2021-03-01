module BrowserVendor.Model exposing
    ( BrowserVendor
    , init
    , mozilla
    )

import Json.Decode exposing (Value)
import Value


type BrowserVendor
    = Mozilla
    | Other
    | Webkit


init : Value -> BrowserVendor
init browserVendorFlag =
    let
        browser =
            Value.extractStringWithDefault "other" browserVendorFlag
    in
    case browser of
        "mozilla" ->
            Mozilla

        "webkit" ->
            Webkit

        _ ->
            Other


mozilla : BrowserVendor
mozilla =
    Mozilla
