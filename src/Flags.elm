module Flags exposing (Flags)

import Json.Decode exposing (Value)


type alias Flags =
    { browser : Value
    , giphyApiKey : Value
    , soundCloudPlaylistUrl : Value
    }
