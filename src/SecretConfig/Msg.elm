module SecretConfig.Msg exposing (Msg(..))


type Msg
    = InitSecretConfigTags (List String)
    | ToggleGifRotation Bool
    | ToggleInactivityPause
    | ToggleSecretConfigVisibility
    | UpdateSecretConfigSoundCloudPlaylistUrl String
    | UpdateSecretConfigTags String
