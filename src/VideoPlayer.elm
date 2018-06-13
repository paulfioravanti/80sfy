module VideoPlayer
    exposing
        ( Msg
        , VideoPlayer
        , exitFullScreen
        , fetchRandomGifMsg
        , init
        , subscriptions
        , toggleFullScreenMsg
        , update
        , view
        )

import Html.Styled exposing (Html)
import Http exposing (Error)
import MsgRouter exposing (MsgRouter)
import VideoPlayer.Context exposing (Context)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.Subscriptions as Subscriptions
import VideoPlayer.Ports as Ports
import VideoPlayer.Update as Update
import VideoPlayer.View as View


type alias VideoPlayer =
    Model.VideoPlayer


type alias Msg =
    Msg.Msg


init : String -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    Model.init id visible zIndex


exitFullScreen : Cmd msg
exitFullScreen =
    Ports.exitFullScreen ()


fetchRandomGifMsg : String -> Result Error String -> Msg
fetchRandomGifMsg =
    Msg.FetchRandomGif


subscriptions : MsgRouter msg -> Bool -> VideoPlayer -> Sub msg
subscriptions msgRouter fetchNextGif videoPlayer1 =
    Subscriptions.subscriptions msgRouter fetchNextGif videoPlayer1


toggleFullScreenMsg : Msg
toggleFullScreenMsg =
    Msg.ToggleFullScreen


update :
    MsgRouter msg
    -> Context msg
    -> Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msgRouter context msg videoPlayer1 videoPlayer2 =
    Update.update msgRouter context msg videoPlayer1 videoPlayer2


view : MsgRouter msg -> VideoPlayer -> Html msg
view msgRouter videoPlayer =
    View.view msgRouter videoPlayer
