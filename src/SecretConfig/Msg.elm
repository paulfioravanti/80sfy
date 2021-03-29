module SecretConfig.Msg exposing
    ( Msg(..)
    , initTags
    , randomTagGenerated
    , updateGifDisplaySeconds
    , updateSoundCloudPlaylistUrl
    , updateTags
    )

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = InitTags (List String)
    | RandomTagGenerated VideoPlayerId Tag
    | Save SoundCloudPlaylistUrl (List Tag) GifDisplayIntervalSeconds
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateGifDisplaySeconds String
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String


initTags : (Msg -> msg) -> List String -> msg
initTags secretConfigMsg tags =
    secretConfigMsg (InitTags tags)


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


updateGifDisplaySeconds : (Msg -> msg) -> String -> msg
updateGifDisplaySeconds secretConfigMsg displaySeconds =
    secretConfigMsg (UpdateGifDisplaySeconds displaySeconds)


updateSoundCloudPlaylistUrl : (Msg -> msg) -> String -> msg
updateSoundCloudPlaylistUrl secretConfigMsg rawSoundCloudPlaylistUrl =
    secretConfigMsg (UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl)


updateTags : (Msg -> msg) -> String -> msg
updateTags secretConfigMsg tagsString =
    secretConfigMsg (UpdateTags tagsString)
