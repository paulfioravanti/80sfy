module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , initAudioPlayer
        , adjustVolumeMsg
        , generatePlaylistTrackOrder
        , generatePlaylistTrackOrderMsg
        , nextTrackMsg
        , pauseAudioMsg
        , playAudioMsg
        , subscriptions
        , toggleMuteMsg
        , update
        )

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg
import AudioPlayer.Ports as Ports
import AudioPlayer.Subscriptions as Subscriptions
import AudioPlayer.Update as Update
import MsgRouter exposing (MsgRouter)
import Random
import Random.List


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


generatePlaylistTrackOrder : (List Int -> msg) -> Cmd msg
generatePlaylistTrackOrder generatePlaylistTrackOrderMsg =
    let
        trackList =
            List.range 0 (155 - 1)

        generator =
            Random.List.shuffle trackList
    in
        generator
            |> Random.generate generatePlaylistTrackOrderMsg


generatePlaylistTrackOrderMsg : List Int -> Msg
generatePlaylistTrackOrderMsg =
    Msg.GeneratePlaylistTrackOrder


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


update : Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msg audioPlayer =
    Update.update msg audioPlayer
