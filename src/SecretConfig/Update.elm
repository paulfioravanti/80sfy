module SecretConfig.Update exposing (update)

import MsgConfig exposing (MsgConfig)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg
    exposing
        ( Msg
            ( InitTags
            , ToggleGifRotation
            , ToggleInactivityPause
            , ToggleVisibility
            , UpdateSoundCloudPlaylistUrl
            , UpdateTags
            )
        )
import Task
import VideoPlayer.Msg exposing (Msg(TogglePlaying))


update :
    MsgConfig msg
    -> SecretConfig.Msg.Msg
    -> SecretConfig
    -> ( SecretConfig, Cmd msg )
update { videoPlayerMsg } msg secretConfig =
    case msg of
        InitTags tagList ->
            let
                tags =
                    tagList
                        |> String.join ", "
            in
                ( { secretConfig | tags = tags }, Cmd.none )

        ToggleGifRotation bool ->
            ( { secretConfig | fetchNextGif = bool }
            , Task.succeed bool
                |> Task.perform (videoPlayerMsg << TogglePlaying)
            )

        ToggleInactivityPause ->
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
