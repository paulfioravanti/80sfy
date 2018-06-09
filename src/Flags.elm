module Flags exposing (Flags)

import Json.Decode exposing (Value)


type alias Flags =
    { giphyApiKey : Value
    , soundCloudClientId : Value
    , soundCloudPlaylistUrl : Value
    }
