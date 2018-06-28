module SecretConfig.Msg exposing (Msg(..))


type Msg
    = InitTags (List String)
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateGifDisplaySeconds String
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String
