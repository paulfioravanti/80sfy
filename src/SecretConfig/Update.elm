module SecretConfig.Update exposing (update)

import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            let
                tags =
                    tagList
                        |> String.join ", "
            in
            { secretConfig | tags = tags }

        Msg.ToggleInactivityPauseOverride ->
            { secretConfig
                | overrideInactivityPause =
                    not secretConfig.overrideInactivityPause
            }

        Msg.ToggleVisibility ->
            { secretConfig | visible = not secretConfig.visible }

        Msg.UpdateGifDisplaySeconds seconds ->
            { secretConfig | gifDisplaySeconds = seconds }

        Msg.UpdateSoundCloudPlaylistUrl url ->
            { secretConfig | soundCloudPlaylistUrl = url }

        Msg.UpdateTags tags ->
            { secretConfig | tags = tags }
