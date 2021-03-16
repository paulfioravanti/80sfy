module SecretConfig.Update exposing (update)

import Gif
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SoundCloud
import Tag


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            { secretConfig | tags = Tag.listToTagsString tagList }

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
            let
                gifDisplaySeconds =
                    Gif.updateDisplayIntervalSeconds
                        seconds
                        secretConfig.gifDisplaySeconds
            in
            { secretConfig | gifDisplaySeconds = gifDisplaySeconds }

        Msg.UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl ->
            let
                soundCloudPlaylistUrl =
                    SoundCloud.playlistUrl rawSoundCloudPlaylistUrl
            in
            { secretConfig | soundCloudPlaylistUrl = soundCloudPlaylistUrl }

        Msg.UpdateTags tags ->
            { secretConfig | tags = Tag.tagsString tags }
