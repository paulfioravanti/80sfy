module SecretConfig.Msg exposing
    ( Msg(..)
    , initTags
    , updateGifDisplaySeconds
    , updateSoundCloudPlaylistUrl
    , updateTags
    )

import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)


type Msg
    = InitTags (List String)
    | Save SoundCloudPlaylistUrl (List Tag) GifDisplayIntervalSeconds
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateGifDisplaySeconds String
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String


initTags : (Msg -> msg) -> List String -> msg
initTags secretConfigMsg tags =
    secretConfigMsg (InitTags tags)


updateGifDisplaySeconds : (Msg -> msg) -> String -> msg
updateGifDisplaySeconds secretConfigMsg displaySeconds =
    secretConfigMsg (UpdateGifDisplaySeconds displaySeconds)


updateSoundCloudPlaylistUrl : (Msg -> msg) -> String -> msg
updateSoundCloudPlaylistUrl secretConfigMsg rawSoundCloudPlaylistUrl =
    secretConfigMsg (UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl)


updateTags : (Msg -> msg) -> String -> msg
updateTags secretConfigMsg tagsString =
    secretConfigMsg (UpdateTags tagsString)
