module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , initAudioPlayer
        , adjustVolumeMsg
        , generatePlaylistTrackOrder
        , nextTrackMsg
        , pauseAudioMsg
        , playAudioMsg
        , subscriptions
        , toggleMuteMsg
        , update
        )

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg(GeneratePlaylistTrackOrder))
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


generatePlaylistTrackOrder : (Msg -> msg) -> Cmd msg
generatePlaylistTrackOrder audioPlayerMsg =
    Utils.generatePlaylistTrackOrder audioPlayerMsg


initAudioPlayer : Int -> Cmd msg
initAudioPlayer volume =
    Ports.initAudioPlayer volume


nextTrackMsg : Msg
nextTrackMsg =
    Msg.NextTrack


pauseAudioMsg : Msg
pauseAudioMsg =
    Msg.PauseAudio


playAudioMsg : Msg
playAudioMsg =
    Msg.PlayAudio


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions msgRouter audioPlayer =
    Subscriptions.subscriptions msgRouter audioPlayer


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


update : MsgRouter msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msgRouter msg audioPlayer =
    Update.update msgRouter msg audioPlayer
