module SecretConfig.Msg exposing (Msg(..))


type Msg
    = InitTags (List String)
    | ToggleInactivityPause
    | ToggleVisibility
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String
