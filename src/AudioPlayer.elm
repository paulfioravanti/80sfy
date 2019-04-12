module AudioPlayer exposing
    ( AudioPlayer
    , Msg
    , adjustVolumeMsg
    , generatePlaylist
    , init
    , initAudioPlayer
    , isMuted
    , isPlaying
    , nextTrackMsg
    , pauseAudioMsg
    , playAudioMsg
    , reInitAudioPlayerMsg
    , statusToString
    , subscriptions
    , toggleMuteMsg
    , update
    )

import AudioPlayer.Flags exposing (Flags)
import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Ports as Ports
import AudioPlayer.Status as Status exposing (Status)
import AudioPlayer.Subscriptions as Subscriptions
import AudioPlayer.Update as Update
import AudioPlayer.Utils as Utils
import VideoPlayer


type alias AudioPlayer =
    Model.AudioPlayer


type alias Msg =
    Msg.Msg


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


adjustVolumeMsg : String -> Msg
adjustVolumeMsg =
    Msg.AdjustVolume


generatePlaylist : (Msg -> msg) -> Int -> Cmd msg
generatePlaylist audioPlayerMsg playlistLength =
    Utils.generatePlaylist audioPlayerMsg playlistLength


initAudioPlayer : Flags -> Cmd msg
initAudioPlayer flags =
    Ports.initAudioPlayer flags


isMuted : AudioPlayer -> Bool
isMuted audioPlayer =
    Model.isMuted audioPlayer


isPlaying : AudioPlayer -> Bool
isPlaying audioPlayer =
    Model.isPlaying audioPlayer


nextTrackMsg : Msg
nextTrackMsg =
    Msg.NextTrack


pauseAudioMsg : Msg
pauseAudioMsg =
    Msg.PauseAudio


playAudioMsg : Msg
playAudioMsg =
    Msg.PlayAudio


reInitAudioPlayerMsg : String -> Msg
reInitAudioPlayerMsg =
    Msg.ReInitAudioPlayer


statusToString : Status -> String
statusToString status =
    Status.toString status


subscriptions :
    (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> AudioPlayer
    -> Sub msg
subscriptions audioPlayerMsg noOpMsg videoPlayerMsg audioPlayer =
    Subscriptions.subscriptions
        audioPlayerMsg
        noOpMsg
        videoPlayerMsg
        audioPlayer


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


update :
    (Msg -> msg)
    -> (VideoPlayer.Msg -> msg)
    -> Msg
    -> AudioPlayer
    -> ( AudioPlayer, Cmd msg )
update audioPlayerMsg videoPlayerMsg msg audioPlayer =
    Update.update audioPlayerMsg videoPlayerMsg msg audioPlayer
