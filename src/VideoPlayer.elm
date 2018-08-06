module VideoPlayer
    exposing
        ( Msg
        , VideoPlayer
        , exitFullScreen
        , fetchRandomGifMsg
        , init
        , pauseVideosMsg
        , performFullScreenToggleMsg
        , playVideosMsg
        , subscriptions
        , update
        , view
        )

import Html.Styled exposing (Html)
import Http exposing (Error)
import MsgRouter exposing (MsgRouter)
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


init : String -> Int -> VideoPlayer
init id zIndex =
    Model.init id zIndex


exitFullScreen : Cmd msg
exitFullScreen =
    Ports.exitFullScreen ()


fetchRandomGifMsg : String -> Result Error String -> Msg
fetchRandomGifMsg =
    Msg.FetchRandomGif


pauseVideosMsg : Msg
pauseVideosMsg =
    Msg.PauseVideos


playVideosMsg : Msg
playVideosMsg =
    Msg.PlayVideos


subscriptions : MsgRouter msg -> String -> Float -> Bool -> VideoPlayer -> Sub msg
subscriptions msgRouter audioPlayerId gifDisplaySeconds overrideInactivityPause videoPlayer1 =
    Subscriptions.subscriptions
        msgRouter
        audioPlayerId
        gifDisplaySeconds
        overrideInactivityPause
        videoPlayer1


performFullScreenToggleMsg : Msg
performFullScreenToggleMsg =
    Msg.PerformFullScreenToggle


update :
    (String -> msg)
    -> Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg videoPlayer1 videoPlayer2 =
    Update.update generateRandomGifMsg msg videoPlayer1 videoPlayer2


view : MsgRouter msg -> Bool -> VideoPlayer -> Html msg
view msgRouter audioPlaying videoPlayer =
    View.view msgRouter audioPlaying videoPlayer
