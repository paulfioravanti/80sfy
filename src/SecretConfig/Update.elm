module SecretConfig.Update exposing (update)

import Gif exposing (GifDisplayIntervalSeconds)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            { secretConfig | tags = Tag.listToTagsString tagList }

        Msg.ToggleInactivityPauseOverride ->
            let
                toggledOverrideInactivityPause : Bool
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
                gifDisplaySeconds : GifDisplayIntervalSeconds
                gifDisplaySeconds =
                    Gif.updateDisplayIntervalSeconds
                        seconds
                        secretConfig.gifDisplaySeconds
            in
            { secretConfig | gifDisplaySeconds = gifDisplaySeconds }

        Msg.UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl ->
            let
                soundCloudPlaylistUrl : SoundCloudPlaylistUrl
                soundCloudPlaylistUrl =
                    SoundCloud.playlistUrl rawSoundCloudPlaylistUrl
            in
            { secretConfig | soundCloudPlaylistUrl = soundCloudPlaylistUrl }

        Msg.UpdateTags tags ->
            { secretConfig | tags = Tag.tagsString tags }
