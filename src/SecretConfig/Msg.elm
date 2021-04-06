module SecretConfig.Msg exposing
    ( Msg(..)
    , initTags
    , randomTagGenerated
    , tagsFetched
    , updateGifDisplaySecondsField
    , updateSoundCloudPlaylistUrlField
    , updateTagsField
    )

import Http exposing (Error)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = InitTags (List String)
    | RandomTagGenerated VideoPlayerId Tag
    | Save
    | TagsFetched (Result Error (List String))
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateGifDisplaySecondsField String
    | UpdateSoundCloudPlaylistUrlField String
    | UpdateTagsField String


initTags : (Msg -> msg) -> List String -> msg
initTags secretConfigMsg tags =
    secretConfigMsg (InitTags tags)


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)


updateGifDisplaySecondsField : (Msg -> msg) -> String -> msg
updateGifDisplaySecondsField secretConfigMsg rawGifDisplayIntervalSeconds =
    secretConfigMsg (UpdateGifDisplaySecondsField rawGifDisplayIntervalSeconds)


updateSoundCloudPlaylistUrlField : (Msg -> msg) -> String -> msg
updateSoundCloudPlaylistUrlField secretConfigMsg rawSoundCloudPlaylistUrl =
    secretConfigMsg (UpdateSoundCloudPlaylistUrlField rawSoundCloudPlaylistUrl)


updateTagsField : (Msg -> msg) -> String -> msg
updateTagsField secretConfigMsg rawTags =
    secretConfigMsg (UpdateTagsField rawTags)
