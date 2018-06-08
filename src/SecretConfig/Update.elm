module SecretConfig.Update exposing (update)

import MsgConfig exposing (MsgConfig)
import SecretConfig.Model exposing (SecretConfig)
import SecretConfig.Msg
    exposing
        ( Msg
            ( ToggleGifRotation
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
        ToggleGifRotation bool ->
            ( { secretConfig | fetchNextGif = bool }
            , Task.succeed bool
                |> Task.perform (videoPlayerMsg << TogglePlaying)
            )
