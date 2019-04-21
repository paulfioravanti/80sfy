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
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Ports as Ports
import AudioPlayer.Status as Status exposing (Status)
import AudioPlayer.Subscriptions as Subscriptions
import AudioPlayer.Update as Update
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
    Playlist.generate audioPlayerMsg playlistLength


initAudioPlayer : Flags -> Cmd msg
initAudioPlayer flags =
    Ports.initAudioPlayer flags


isMuted : AudioPlayer -> Bool
isMuted audioPlayer =
    Status.isMuted audioPlayer.status


isPlaying : AudioPlayer -> Bool
isPlaying audioPlayer =
    Status.isPlaying audioPlayer.status


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


subscriptions : Subscriptions.Msgs msgs msg -> AudioPlayer -> Sub msg
subscriptions msgs audioPlayer =
    Subscriptions.subscriptions msgs audioPlayer


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


update : Update.Msgs msgs msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msgs msg audioPlayer =
    Update.update msgs msg audioPlayer
