module SecretConfig.Update exposing (update)

import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg
    exposing
        ( Msg
            ( InitTags
            , ToggleInactivityPauseOverride
            , ToggleVisibility
            , UpdateSoundCloudPlaylistUrl
            , UpdateTags
            )
        )


update : Msg -> SecretConfig -> ( SecretConfig, Cmd msg )
update msg secretConfig =
    case msg of
        InitTags tagList ->
            let
                tags =
                    tagList
                        |> String.join ", "
            in
                ( { secretConfig | tags = tags }, Cmd.none )

        ToggleInactivityPauseOverride ->
            ( { secretConfig
                | overrideInactivityPause =
                    not secretConfig.overrideInactivityPause
              }
            , Cmd.none
            )

        ToggleVisibility ->
            ( { secretConfig | visible = not secretConfig.visible }, Cmd.none )

        UpdateSoundCloudPlaylistUrl url ->
            ( { secretConfig | soundCloudPlaylistUrl = url }, Cmd.none )

        UpdateTags tags ->
            ( { secretConfig | tags = tags }, Cmd.none )
