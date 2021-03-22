module AudioPlayer exposing
    ( AudioPlayer
    , AudioPlayerId
    , AudioPlayerVolume
    , Msg
    , adjustVolumeDown
    , adjustVolumeMsg
    , adjustVolumeUp
    , audioPausedMsg
    , audioPlayingMsg
    , generatePlaylist
    , init
    , isMuted
    , isPlaying
    , nextTrackMsg
    , performAudioPlayerReset
    , performNextTrackSelection
    , performVolumeAdjustment
    , rawId
    , rawTrackIndex
    , rawVolume
    , soundCloudWidgetPayload
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
import Ports exposing (SoundCloudWidgetPayload)
import SoundCloud exposing (SoundCloudPlaylistUrl)


type alias AudioPlayer =
    Model.AudioPlayer


type alias AudioPlayerId =
    Model.AudioPlayerId


type alias AudioPlayerVolume =
    Volume.AudioPlayerVolume


type alias Msg =
    Msg.Msg


type alias TrackIndex =
    Playlist.TrackIndex


init : SoundCloudPlaylistUrl -> AudioPlayer
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


adjustVolumeDown : AudioPlayerVolume -> Int -> AudioPlayerVolume
adjustVolumeDown audioPlayerVolume volumeAdjustmentRate =
    Volume.adjustDown audioPlayerVolume volumeAdjustmentRate


adjustVolumeMsg : (Msg -> msg) -> String -> msg
adjustVolumeMsg audioPlayerMsg sliderVolume =
    Msg.adjustVolume audioPlayerMsg sliderVolume


adjustVolumeUp : AudioPlayerVolume -> Int -> AudioPlayerVolume
adjustVolumeUp audioPlayerVolume volumeAdjustmentRate =
    Volume.adjustUp audioPlayerVolume volumeAdjustmentRate


audioPausedMsg : Msg
audioPausedMsg =
    Msg.AudioPaused


audioPlayingMsg : Msg
audioPlayingMsg =
    Msg.AudioPlaying


generatePlaylist : (Msg -> msg) -> Int -> Cmd msg
generatePlaylist audioPlayerMsg playlistLength =
    Playlist.generate audioPlayerMsg playlistLength


isMuted : AudioPlayer -> Bool
isMuted audioPlayer =
    Status.isMuted audioPlayer.status


isPlaying : AudioPlayer -> Bool
isPlaying audioPlayer =
    Status.isPlaying audioPlayer.status


nextTrackMsg : (Msg -> msg) -> msg
nextTrackMsg audioPlayerMsg =
    Msg.nextTrack audioPlayerMsg


performAudioPlayerReset : (Msg -> msg) -> SoundCloudPlaylistUrl -> Cmd msg
performAudioPlayerReset audioPlayerMsg soundCloudPlaylistUrl =
    Task.performAudioPlayerReset audioPlayerMsg soundCloudPlaylistUrl


performNextTrackSelection : (Msg -> msg) -> Cmd msg
performNextTrackSelection audioPlayerMsg =
    Task.performNextTrackSelection audioPlayerMsg


performVolumeAdjustment : (Msg -> msg) -> String -> Cmd msg
performVolumeAdjustment audioPlayerMsg sliderVolume =
    Task.performVolumeAdjustment audioPlayerMsg sliderVolume


rawId : AudioPlayerId -> String
rawId audioPlayerId =
    Model.rawId audioPlayerId


rawTrackIndex : TrackIndex -> Int
rawTrackIndex trackIndex =
    Playlist.rawTrackIndex trackIndex


rawVolume : AudioPlayerVolume -> Int
rawVolume audioPlayerVolume =
    Volume.rawVolume audioPlayerVolume


soundCloudWidgetPayload : AudioPlayer -> SoundCloudWidgetPayload
soundCloudWidgetPayload audioPlayer =
    Model.soundCloudWidgetPayload audioPlayer


statusToString : Status -> String
statusToString status =
    Status.toString status


subscriptions : Subscriptions.ParentMsgs msgs msg -> AudioPlayer -> Sub msg
subscriptions msgs audioPlayer =
    Subscriptions.subscriptions msgs audioPlayer


toggleMuteMsg : (Msg -> msg) -> msg
toggleMuteMsg audioPlayerMsg =
    Msg.toggleMute audioPlayerMsg


update : (Msg -> msg) -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update audioPlayerMsg msg audioPlayer =
    Update.update audioPlayerMsg msg audioPlayer
