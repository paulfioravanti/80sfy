module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , initAudioPlayer
        , adjustVolumeMsg
        , generatePlaylistTrackOrder
        , isMuted
        , isPlaying
        , nextTrackMsg
        , pauseAudioMsg
        , playAudioMsg
        , reInitAudioPlayerMsg
        , subscriptions
        , toggleMuteMsg
        , update
        )

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Ports as Ports
import AudioPlayer.Subscriptions as Subscriptions
import AudioPlayer.Update as Update
import AudioPlayer.Utils as Utils
import MsgRouter exposing (MsgRouter)


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


generatePlaylistTrackOrder : (Msg -> msg) -> Int -> Cmd msg
generatePlaylistTrackOrder audioPlayerMsg playlistLength =
    Utils.generatePlaylistTrackOrder audioPlayerMsg playlistLength


initAudioPlayer : Int -> Cmd msg
initAudioPlayer volume =
    Ports.initAudioPlayer volume


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


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions msgRouter audioPlayer =
    Subscriptions.subscriptions msgRouter audioPlayer


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


update : MsgRouter msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msgRouter msg audioPlayer =
    Update.update msgRouter msg audioPlayer
