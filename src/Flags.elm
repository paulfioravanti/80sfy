module Flags exposing (Flags)

import Json.Decode exposing (Value)


type alias Flags =
    { browserVendor : Value
    , giphyApiKey : Value
    , soundCloudPlaylistUrl : Value
    }
