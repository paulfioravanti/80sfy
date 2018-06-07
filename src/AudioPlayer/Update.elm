module AudioPlayer.Update exposing (update)

import AudioPlayer.Config exposing (Config)
import AudioPlayer.Msg exposing (Msg(AdjustVolume, ToggleMute, TogglePlayPause))
import AudioPlayer.Model exposing (AudioPlayer)
import Task
import VideoPlayer.Msg exposing (Msg(TogglePlaying))


update :
    Config msg
    -> AudioPlayer.Msg.Msg
    -> AudioPlayer
    -> ( AudioPlayer, Cmd msg )
update { videoPlayerMsg } msg audioPlayer =
    case msg of
        AdjustVolume volume ->
            ( { audioPlayer | muted = False, volume = volume }, Cmd.none )

        ToggleMute ->
            ( { audioPlayer | muted = not audioPlayer.muted }, Cmd.none )

        TogglePlayPause ->
            ( { audioPlayer | playing = not audioPlayer.playing }
            , Task.succeed (not audioPlayer.playing)
                |> Task.perform (videoPlayerMsg << TogglePlaying)
            )
