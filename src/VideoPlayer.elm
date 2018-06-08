module VideoPlayer
    exposing
        ( Msg
        , VideoPlayer
        , fetchRandomGifMsg
        , init
        , subscriptions
        , toggleFullScreenMsg
        , togglePlayingMsg
        , update
        , view
        )

import Animation
import Html.Styled exposing (Html)
import Http exposing (Error)
import MsgConfig exposing (MsgConfig)
import RemoteData exposing (RemoteData(Success), WebData)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.Ports as Ports
import VideoPlayer.Subscriptions as Subscriptions
import VideoPlayer.Update as Update
import VideoPlayer.View as View


type alias VideoPlayer =
    Model.VideoPlayer


type alias Msg =
    Msg.Msg


init : String -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    Model.init id visible zIndex


fetchRandomGifMsg : String -> Result Error String -> Msg
fetchRandomGifMsg =
    Msg.FetchRandomGif


subscriptions : MsgConfig msg -> Bool -> VideoPlayer -> Sub msg
subscriptions msgConfig fetchNextGif videoPlayer1 =
    Subscriptions.subscriptions msgConfig fetchNextGif videoPlayer1


toggleFullScreenMsg : Msg
toggleFullScreenMsg =
    Msg.ToggleFullScreen


togglePlayingMsg : Bool -> Msg
togglePlayingMsg =
    Msg.TogglePlaying


update :
    MsgConfig msg
    -> Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msgConfig msg videoPlayer1 videoPlayer2 =
    Update.update msgConfig msg videoPlayer1 videoPlayer2


view : MsgConfig msg -> VideoPlayer -> Html msg
view msgConfig videoPlayer =
    View.view msgConfig videoPlayer
