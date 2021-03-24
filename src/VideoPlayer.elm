module VideoPlayer exposing
    ( Msg
    , VideoPlayer
    , VideoPlayerId
    , VideoPlayerSubscriptionsContext
    , VideoPlayerZIndex
    , crossFade
    , id
    , init
    , randomGifUrlFetchedMsg
    , rawId
    , rawZIndex
    , statusToString
    , subscriptions
    , update
    , view
    , zIndex
    )

import Html.Styled exposing (Html)
import Http exposing (Error)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.Status as Status exposing (Status)
import VideoPlayer.Subscriptions as Subscriptions
import VideoPlayer.Update as Update
import VideoPlayer.VideoPlayerId as VideoPlayerId
import VideoPlayer.View as View
import VideoPlayer.View.ParentMsgs exposing (ParentMsgs)


type alias Msg =
    Msg.Msg


type alias VideoPlayer =
    Model.VideoPlayer


type alias VideoPlayerId =
    VideoPlayerId.VideoPlayerId


type alias VideoPlayerSubscriptionsContext =
    Subscriptions.Context


type alias VideoPlayerZIndex =
    Model.VideoPlayerZIndex


init : VideoPlayerId -> VideoPlayerZIndex -> VideoPlayer
init videoPlayerId videoPlayerZIndex =
    Model.init videoPlayerId videoPlayerZIndex


crossFade :
    VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, VideoPlayerId )
crossFade videoPlayer1 videoPlayer2 =
    Model.crossFade videoPlayer1 videoPlayer2


id : String -> VideoPlayerId
id rawIdString =
    VideoPlayerId.id rawIdString


randomGifUrlFetchedMsg :
    (Msg -> msg)
    -> VideoPlayerId
    -> Result Error String
    -> msg
randomGifUrlFetchedMsg videoPlayerMsg videoPlayerId gifUrl =
    Msg.randomGifUrlFetched videoPlayerMsg videoPlayerId gifUrl


rawId : VideoPlayerId -> String
rawId videoPlayerId =
    VideoPlayerId.rawId videoPlayerId


rawZIndex : VideoPlayerZIndex -> Int
rawZIndex videoPlayerZIndex =
    Model.rawZIndex videoPlayerZIndex


statusToString : Status -> String
statusToString status =
    Status.toString status


subscriptions :
    Subscriptions.ParentMsgs msgs msg
    -> Subscriptions.Context
    -> VideoPlayer
    -> Sub msg
subscriptions parentMsgs context videoPlayer1 =
    Subscriptions.subscriptions parentMsgs context videoPlayer1


update : Msg -> Update.Context a -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msg context =
    Update.update msg context


view : ParentMsgs msgs msg -> Bool -> VideoPlayer -> Html msg
view parentMsgs audioPlaying videoPlayer =
    View.view parentMsgs audioPlaying videoPlayer


zIndex : Int -> VideoPlayerZIndex
zIndex rawZIndexInt =
    Model.zIndex rawZIndexInt
