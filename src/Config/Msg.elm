module Config.Msg exposing
    ( Msg(..)
    , randomTagGenerated
    , tagsFetched
    , updateGifDisplaySeconds
    , updateSoundCloudPlaylistUrl
    , updateTags
    )

import Gif exposing (GifDisplayIntervalSeconds)
import Http exposing (Error)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = RandomTagGenerated VideoPlayerId Tag
    | Save SoundCloudPlaylistUrl (List Tag) GifDisplayIntervalSeconds
    | TagsFetched (Result Error (List String))
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateGifDisplaySeconds String
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)


updateGifDisplaySeconds : (Msg -> msg) -> String -> msg
updateGifDisplaySeconds secretConfigMsg displaySeconds =
    secretConfigMsg (UpdateGifDisplaySeconds displaySeconds)


updateSoundCloudPlaylistUrl : (Msg -> msg) -> String -> msg
updateSoundCloudPlaylistUrl secretConfigMsg rawSoundCloudPlaylistUrl =
    secretConfigMsg (UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl)


updateTags : (Msg -> msg) -> String -> msg
updateTags secretConfigMsg tagsString =
    secretConfigMsg (UpdateTags tagsString)
