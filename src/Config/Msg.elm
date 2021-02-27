module Config.Msg exposing (Msg(..), randomTagGenerated, save, tagsFetched)

import Gif exposing (GifDisplayIntervalSeconds)
import Http exposing (Error)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = TagsFetched (Result Error (List String))
    | RandomTagGenerated VideoPlayerId Tag
    | Save SoundCloudPlaylistUrl String GifDisplayIntervalSeconds


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


save :
    (Msg -> msg)
    -> SoundCloudPlaylistUrl
    -> String
    -> GifDisplayIntervalSeconds
    -> msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds =
    configMsg (Save soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)
