module SecretConfig.Msg exposing (Msg(..))


type Msg
    = InitTags (List String)
    | ToggleGifRotation Bool
    | ToggleInactivityPause
    | ToggleVisibility
    | UpdateSoundCloudPlaylistUrl String
    | UpdateTags String
