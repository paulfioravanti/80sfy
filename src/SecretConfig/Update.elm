module SecretConfig.Update exposing (update)

import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)


update : Msg -> SecretConfig -> ( SecretConfig, Cmd msg )
update msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            let
                tags =
                    tagList
                        |> String.join ", "
            in
            ( { secretConfig | tags = tags }, Cmd.none )

        Msg.ToggleInactivityPauseOverride ->
            ( { secretConfig
                | overrideInactivityPause =
                    not secretConfig.overrideInactivityPause
              }
            , Cmd.none
            )

        Msg.ToggleVisibility ->
            ( { secretConfig | visible = not secretConfig.visible }, Cmd.none )

        Msg.UpdateGifDisplaySeconds seconds ->
            ( { secretConfig | gifDisplaySeconds = seconds }, Cmd.none )

        Msg.UpdateSoundCloudPlaylistUrl url ->
            ( { secretConfig | soundCloudPlaylistUrl = url }, Cmd.none )

        Msg.UpdateTags tags ->
            ( { secretConfig | tags = tags }, Cmd.none )
