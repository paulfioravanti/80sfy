module SecretConfig.Update exposing (update)

import MsgRouter exposing (MsgRouter)
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
import VideoPlayer.Msg exposing (Msg(PauseVideos, PlayVideos))


update :
    MsgRouter msg
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
            let
                videoMsg =
                    if bool then
                        PlayVideos
                    else
                        PauseVideos
            in
                ( { secretConfig | fetchNextGif = bool }
                , Task.succeed ()
                    |> Task.perform (videoPlayerMsg << videoMsg)
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
