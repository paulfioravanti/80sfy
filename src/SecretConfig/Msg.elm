module SecretConfig.Msg exposing (Msg(..))


type Msg
    = InitTags (List String)
    | ToggleInactivityPauseOverride
    | ToggleVisibility
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String
