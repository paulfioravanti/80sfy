module SecretConfig.Msg exposing
    ( Msg(..)
    , initTags
    , toggleInactivityPauseOverride
    , toggleVisibility
    , updateGifDisplaySeconds
    , updateSoundCloudPlaylistUrl
    , updateTags
    )


type Msg
    = InitTags (List String)
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateGifDisplaySeconds String
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String


initTags : (Msg -> msg) -> List String -> msg
initTags secretConfigMsg tags =
    secretConfigMsg (InitTags tags)


toggleInactivityPauseOverride : (Msg -> msg) -> msg
toggleInactivityPauseOverride secretConfigMsg =
    secretConfigMsg ToggleInactivityPauseOverride


toggleVisibility : (Msg -> msg) -> msg
toggleVisibility secretConfigMsg =
    secretConfigMsg ToggleVisibility


updateGifDisplaySeconds : (Msg -> msg) -> String -> msg
updateGifDisplaySeconds secretConfigMsg displaySeconds =
    secretConfigMsg (UpdateGifDisplaySeconds displaySeconds)


updateSoundCloudPlaylistUrl : (Msg -> msg) -> String -> msg
updateSoundCloudPlaylistUrl secretConfigMsg rawSoundCloudPlaylistUrl =
    secretConfigMsg (UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl)


updateTags : (Msg -> msg) -> String -> msg
updateTags secretConfigMsg tagsString =
    secretConfigMsg (UpdateTags tagsString)
