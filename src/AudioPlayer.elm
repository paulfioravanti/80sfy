module AudioPlayer exposing
    ( AudioPlayer
    , AudioPlayerId
    , AudioPlayerVolume
    , Msg
    , adjustVolume
    , adjustVolumeDown
    , adjustVolumeMsg
    , adjustVolumeUp
    , generatePlaylist
    , init
    , isMuted
    , isPlaying
    , nextTrack
    , nextTrackMsg
    , pauseAudioMsg
    , playAudio
    , playAudioMsg
    , rawId
    , rawVolume
    , resetAudioPlayer
    , statusToString
    , subscriptions
    , toggleMuteMsg
    , update
    )

import AudioPlayer.Model as Model
import AudioPlayer.Msg as Msg
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Status as Status exposing (Status)
import AudioPlayer.Subscriptions as Subscriptions
import AudioPlayer.Task as Task
import AudioPlayer.Update as Update
import AudioPlayer.Volume as Volume
import SoundCloud exposing (SoundCloudPlaylistUrl)


type alias AudioPlayer =
    Model.AudioPlayer


type alias AudioPlayerId =
    Model.AudioPlayerId


type alias AudioPlayerVolume =
    Volume.AudioPlayerVolume


type alias Msg =
    Msg.Msg


init : SoundCloudPlaylistUrl -> AudioPlayer
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


adjustVolume : (Msg -> msg) -> String -> Cmd msg
adjustVolume audioPlayerMsg sliderVolume =
    Task.adjustVolume audioPlayerMsg sliderVolume


adjustVolumeDown : AudioPlayerVolume -> Int -> AudioPlayerVolume
adjustVolumeDown audioPlayerVolume volumeAdjustmentRate =
    Volume.adjustDown audioPlayerVolume volumeAdjustmentRate


adjustVolumeMsg : (Msg -> msg) -> String -> msg
adjustVolumeMsg audioPlayerMsg sliderVolume =
    Msg.adjustVolume audioPlayerMsg sliderVolume


adjustVolumeUp : AudioPlayerVolume -> Int -> AudioPlayerVolume
adjustVolumeUp audioPlayerVolume volumeAdjustmentRate =
    Volume.adjustUp audioPlayerVolume volumeAdjustmentRate


generatePlaylist : (Msg -> msg) -> Int -> Cmd msg
generatePlaylist audioPlayerMsg playlistLength =
    Playlist.generate audioPlayerMsg playlistLength


isMuted : AudioPlayer -> Bool
isMuted audioPlayer =
    Status.isMuted audioPlayer.status


isPlaying : AudioPlayer -> Bool
isPlaying audioPlayer =
    Status.isPlaying audioPlayer.status


nextTrack : (Msg -> msg) -> Cmd msg
nextTrack audioPlayerMsg =
    Task.nextTrack audioPlayerMsg


nextTrackMsg : (Msg -> msg) -> msg
nextTrackMsg audioPlayerMsg =
    Msg.nextTrack audioPlayerMsg


pauseAudioMsg : (Msg -> msg) -> msg
pauseAudioMsg audioPlayerMsg =
    Msg.pauseAudio audioPlayerMsg


playAudio : (Msg -> msg) -> Cmd msg
playAudio audioPlayerMsg =
    Task.playAudio audioPlayerMsg


playAudioMsg : (Msg -> msg) -> msg
playAudioMsg audioPlayerMsg =
    Msg.playAudio audioPlayerMsg


rawId : AudioPlayerId -> String
rawId audioPlayerId =
    Model.rawId audioPlayerId


rawVolume : AudioPlayerVolume -> Int
rawVolume audioPlayerVolume =
    Volume.rawVolume audioPlayerVolume


resetAudioPlayer : (Msg -> msg) -> SoundCloudPlaylistUrl -> Cmd msg
resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    Task.resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl


statusToString : Status -> String
statusToString status =
    Status.toString status


subscriptions : Subscriptions.Msgs msgs msg -> AudioPlayer -> Sub msg
subscriptions msgs audioPlayer =
    Subscriptions.subscriptions msgs audioPlayer


toggleMuteMsg : (Msg -> msg) -> msg
toggleMuteMsg audioPlayerMsg =
    Msg.toggleMute audioPlayerMsg


update : Update.Msgs msgs msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msgs msg audioPlayer =
    Update.update msgs msg audioPlayer
