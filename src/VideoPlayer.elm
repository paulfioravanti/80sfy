module VideoPlayer exposing
    ( Msg
    , VideoPlayer
    , fetchRandomGifMsg
    , gifUrlToString
    , init
    , pauseVideosMsg
    , playVideosMsg
    , statusToString
    , subscriptions
    , update
    , view
    )

import BrowserVendor exposing (BrowserVendor)
import FullScreen
import Html.Styled exposing (Html)
import Http exposing (Error)
import RemoteData exposing (WebData)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.RemoteData as RemoteData
import VideoPlayer.Status as Status exposing (Status)
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


fetchRandomGifMsg : String -> Result Error String -> Msg
fetchRandomGifMsg =
    Msg.FetchRandomGif


gifUrlToString : WebData String -> String
gifUrlToString webData =
    RemoteData.toString webData


pauseVideosMsg : Msg
pauseVideosMsg =
    Msg.PauseVideos


playVideosMsg : Msg
playVideosMsg =
    Msg.PlayVideos


statusToString : Status -> String
statusToString status =
    Status.toString status


subscriptions :
    SubscriptionsMsgs msgs msg
    -> SubscriptionsContext
    -> VideoPlayer
    -> Sub msg
subscriptions msgs context videoPlayer1 =
    Subscriptions.subscriptions msgs context videoPlayer1


update :
    (String -> msg)
    -> Msg
    -> UpdateContext a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg context =
    Update.update generateRandomGifMsg msg context


view : Bool -> ViewMsgs msgs msg -> BrowserVendor -> VideoPlayer -> Html msg
view audioPlaying msgs browserVendor videoPlayer =
    View.view audioPlaying msgs browserVendor videoPlayer



-- PRIVATE


type alias SubscriptionsMsgs msgs msg =
    { msgs
        | noOpMsg : msg
        , videoPlayerMsg : Msg -> msg
    }


type alias ViewMsgs msgs msg =
    { msgs
        | fullScreenMsg : FullScreen.Msg -> msg
        , noOpMsg : msg
        , videoPlayerMsg : Msg -> msg
    }


type alias UpdateContext a =
    { a
        | videoPlayer1 : VideoPlayer
        , videoPlayer2 : VideoPlayer
    }


type alias SubscriptionsContext =
    { audioPlayerId : String
    , gifDisplaySeconds : Float
    , overrideInactivityPause : Bool
    }
