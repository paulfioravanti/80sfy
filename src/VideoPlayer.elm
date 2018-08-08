module VideoPlayer
    exposing
        ( Msg
        , VideoPlayer
        , fetchRandomGifMsg
        , init
        , pauseVideosMsg
        , performFullScreenToggleMsg
        , playVideosMsg
        , subscriptions
        , update
        , view
        )

import Browser exposing (Browser)
import Html.Styled exposing (Html)
import Http exposing (Error)
import MsgRouter exposing (MsgRouter)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.Subscriptions as Subscriptions exposing (Context)
import VideoPlayer.Update as Update
import VideoPlayer.View as View


type alias VideoPlayer =
    Model.VideoPlayer


type alias Msg =
    Msg.Msg


init : String -> Int -> VideoPlayer
init id zIndex =
    Model.init id zIndex


fetchRandomGifMsg : String -> Result Error String -> Msg
fetchRandomGifMsg =
    Msg.FetchRandomGif


pauseVideosMsg : Msg
pauseVideosMsg =
    Msg.PauseVideos


playVideosMsg : Msg
playVideosMsg =
    Msg.PlayVideos


subscriptions : MsgRouter msg -> Context -> VideoPlayer -> Sub msg
subscriptions msgRouter context videoPlayer1 =
    Subscriptions.subscriptions msgRouter context videoPlayer1


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle



-- FIXME: Passing browser is temporary


update :
    (String -> msg)
    -> Msg
    -> VideoPlayer
    -> VideoPlayer
    -> Browser
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg videoPlayer1 videoPlayer2 browser =
    Update.update generateRandomGifMsg msg videoPlayer1 videoPlayer2 browser


view : MsgRouter msg -> Bool -> VideoPlayer -> Html msg
view msgRouter audioPlaying videoPlayer =
    View.view msgRouter audioPlaying videoPlayer
