module AudioPlayer exposing
    ( AudioPlayer
    , AudioPlayerId
    , Msg
    , adjustVolume
    , adjustVolumeMsg
    , generatePlaylist
    , init
    , initAudioPlayer
    , isMuted
    , isPlaying
    , nextTrack
    , nextTrackMsg
    , pauseAudioMsg
    , playAudio
    , playAudioMsg
    , rawId
    , reInitAudioPlayer
    , statusToString
    , subscriptions
    , toggleMuteMsg
    , update
    )

import AudioPlayer.Flags exposing (Flags)
import AudioPlayer.Model as Model
import AudioPlayer.Msg as Msg
import AudioPlayer.Playlist as Playlist
import AudioPlayer.Ports as Ports
import AudioPlayer.Status as Status exposing (Status)
import AudioPlayer.Subscriptions as Subscriptions
import AudioPlayer.Task as Task
import AudioPlayer.Update as Update


type alias AudioPlayer =
    Model.AudioPlayer


type alias AudioPlayerId =
    Model.AudioPlayerId


type alias Msg =
    Msg.Msg


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


adjustVolume : (Msg -> msg) -> String -> Cmd msg
adjustVolume audioPlayerMsg volume =
    Task.adjustVolume audioPlayerMsg volume


adjustVolumeMsg : (Msg -> msg) -> String -> msg
adjustVolumeMsg audioPlayerMsg volume =
    Msg.adjustVolume audioPlayerMsg volume


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


reInitAudioPlayer : (Msg -> msg) -> String -> Cmd msg
reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    Task.reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl


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
