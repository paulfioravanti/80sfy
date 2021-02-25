module SecretConfig.Update exposing (update)

import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SoundCloud


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            let
                tags =
                    String.join ", " tagList
            in
            { secretConfig | tags = tags }

        Msg.ToggleInactivityPauseOverride ->
            let
                toggledOverrideInactivityPause =
                    not secretConfig.overrideInactivityPause
            in
            { secretConfig
                | overrideInactivityPause = toggledOverrideInactivityPause
            }

        Msg.ToggleVisibility ->
            { secretConfig | visible = not secretConfig.visible }

        Msg.UpdateGifDisplaySeconds seconds ->
            { secretConfig | gifDisplaySeconds = seconds }

        Msg.UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl ->
            let
                soundCloudPlaylistUrl =
                    SoundCloud.playlistUrl rawSoundCloudPlaylistUrl
            in
            { secretConfig | soundCloudPlaylistUrl = soundCloudPlaylistUrl }

        Msg.UpdateTags tags ->
            { secretConfig | tags = tags }
