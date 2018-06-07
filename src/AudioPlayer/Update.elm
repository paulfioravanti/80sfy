module AudioPlayer.Update exposing (updateModel, updateCmd)

import AudioPlayer.Config exposing (Config)
import AudioPlayer.Msg exposing (Msg(AdjustVolume, ToggleMute, TogglePlayPause))
import AudioPlayer.Model exposing (AudioPlayer)
import Task
import VideoPlayer.Msg exposing (Msg(TogglePlaying))


updateModel : AudioPlayer.Msg.Msg -> AudioPlayer -> AudioPlayer
updateModel msg audioPlayer =
    case msg of
        AdjustVolume volume ->
            { audioPlayer | muted = False, volume = volume }

        ToggleMute ->
            { audioPlayer | muted = not audioPlayer.muted }

        TogglePlayPause ->
            { audioPlayer | playing = not audioPlayer.playing }


updateCmd : Config msg -> AudioPlayer.Msg.Msg -> AudioPlayer -> Cmd msg
updateCmd { videoPlayerMsg } msg audioPlayer =
    case msg of
        AdjustVolume volume ->
            Cmd.none

        ToggleMute ->
            Cmd.none

        TogglePlayPause ->
            Task.succeed (not audioPlayer.playing)
                |> Task.perform (videoPlayerMsg << TogglePlaying)
