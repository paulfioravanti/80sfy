module AudioPlayer exposing
    ( AudioPlayer
    , AudioPlayerId
    , AudioPlayerVolume
    , Msg
    , adjustVolumeMsg
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


adjustVolumeMsg : (Msg -> msg) -> String -> msg
adjustVolumeMsg audioPlayerMsg sliderVolume =
    Msg.adjustVolume audioPlayerMsg sliderVolume


isMuted : AudioPlayer -> Bool
isMuted audioPlayer =
    Status.isMuted audioPlayer.status


isPlaying : AudioPlayer -> Bool
isPlaying audioPlayer =
    Status.isPlaying audioPlayer.status


nextTrackMsg : Msg
nextTrackMsg =
    Msg.NextTrack


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
subscriptions parentMsgs audioPlayer =
    Subscriptions.subscriptions parentMsgs audioPlayer


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


update :
    Update.ParentMsgs msgs msg
    -> Msg
    -> AudioPlayer
    -> ( AudioPlayer, Cmd msg )
update parentMsgs msg audioPlayer =
    Update.update parentMsgs msg audioPlayer
