module VideoPlayer exposing
    ( Msg
    , VideoPlayer
    , fetchRandomGifMsg
    , init
    , pauseVideosMsg
    , playVideosMsg
    , subscriptions
    , update
    , view
    )

import BrowserVendor exposing (Vendor)
import FullScreen
import Html.Styled exposing (Html)
import Http exposing (Error)
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


subscriptions : msg -> (Msg -> msg) -> Context -> VideoPlayer -> Sub msg
subscriptions noOpMsg videoPlayerMsg context videoPlayer1 =
    Subscriptions.subscriptions noOpMsg videoPlayerMsg context videoPlayer1


update :
    (String -> msg)
    -> Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg videoPlayer1 videoPlayer2 =
    Update.update generateRandomGifMsg msg videoPlayer1 videoPlayer2


view :
    (FullScreen.Msg -> msg)
    -> msg
    -> (Msg -> msg)
    -> Vendor
    -> Bool
    -> VideoPlayer
    -> Html msg
view fullScreenMsg noOpMsg videoPlayerMsg vendor audioPlaying videoPlayer =
    View.view
        fullScreenMsg
        noOpMsg
        videoPlayerMsg
        vendor
        audioPlaying
        videoPlayer
