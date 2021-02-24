module VideoPlayer exposing
    ( Msg
    , VideoPlayer
    , VideoPlayerId
    , gifUrlToString
    , id
    , init
    , pauseVideosMsg
    , playVideos
    , playVideosMsg
    , randomGifUrlFetchedMsg
    , rawId
    , statusToString
    , subscriptions
    , update
    , view
    )

import BrowserVendor exposing (BrowserVendor)
import Html.Styled exposing (Html)
import Http exposing (Error)
import RemoteData exposing (WebData)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.RemoteData as RemoteData
import VideoPlayer.Status as Status exposing (Status)
import VideoPlayer.Subscriptions as Subscriptions
import VideoPlayer.Task as Task
import VideoPlayer.Update as Update
import VideoPlayer.View as View


type alias VideoPlayer =
    Model.VideoPlayer


type alias VideoPlayerId =
    Model.VideoPlayerId


type alias Msg =
    Msg.Msg


init : String -> Int -> VideoPlayer
init idString zIndex =
    Model.init idString zIndex


id : String -> VideoPlayerId
id rawIdValue =
    Model.id rawIdValue


gifUrlToString : WebData String -> String
gifUrlToString webData =
    RemoteData.toString webData


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg videoPlayerMsg =
    Msg.pauseVideos videoPlayerMsg


playVideos : (Msg -> msg) -> Cmd msg
playVideos videoPlayerMsg =
    Task.playVideos videoPlayerMsg


playVideosMsg : (Msg -> msg) -> msg
playVideosMsg videoPlayerMsg =
    Msg.playVideos videoPlayerMsg


randomGifUrlFetchedMsg :
    (Msg -> msg)
    -> VideoPlayerId
    -> Result Error String
    -> msg
randomGifUrlFetchedMsg videoPlayerMsg videoPlayerId gifUrl =
    Msg.randomGifUrlFetched videoPlayerMsg videoPlayerId gifUrl


rawId : VideoPlayerId -> String
rawId videoPlayerId =
    Model.rawId videoPlayerId


statusToString : Status -> String
statusToString status =
    Status.toString status


subscriptions :
    Subscriptions.Msgs msgs msg
    -> Subscriptions.Context
    -> VideoPlayer
    -> Sub msg
subscriptions msgs context videoPlayer1 =
    Subscriptions.subscriptions msgs context videoPlayer1


update :
    (VideoPlayerId -> msg)
    -> Msg
    -> Update.Context a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg context =
    Update.update generateRandomGifMsg msg context


view : Bool -> View.Msgs msgs msg -> BrowserVendor -> VideoPlayer -> Html msg
view audioPlaying msgs browserVendor videoPlayer =
    View.view audioPlaying msgs browserVendor videoPlayer
