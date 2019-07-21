module SecretConfig.Msg exposing
    ( Msg(..)
    , initTags
    , toggleInactivityPauseOverride
    , updateGifDisplaySeconds
    , updateSoundCloudPlaylistUrl
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


updateGifDisplaySeconds : (Msg -> msg) -> String -> msg
updateGifDisplaySeconds secretConfigMsg displaySeconds =
    secretConfigMsg (UpdateGifDisplaySeconds displaySeconds)


updateSoundCloudPlaylistUrl : (Msg -> msg) -> String -> msg
updateSoundCloudPlaylistUrl secretConfigMsg soundCloudPlaylistUrl =
    secretConfigMsg (UpdateSoundCloudPlaylistUrl soundCloudPlaylistUrl)
