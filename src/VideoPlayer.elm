module VideoPlayer exposing
    ( Msg
    , VideoPlayer
    , VideoPlayerId
    , id
    , init
    , pauseVideosMsg
    , performPauseVideos
    , performPlayVideos
    , playVideosMsg
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
import Tag exposing (Tag)
import VideoPlayer.Model as Model
import VideoPlayer.Msg as Msg
import VideoPlayer.Status as Status exposing (Status)
import VideoPlayer.Subscriptions as Subscriptions
import VideoPlayer.Task as Task
import VideoPlayer.Update as Update
import VideoPlayer.View as View


type alias VideoPlayer =
    Model.VideoPlayer


type alias VideoPlayerId =
    Model.VideoPlayerId


type alias VideoPlayerZIndex =
    Model.VideoPlayerZIndex


type alias Msg =
    Msg.Msg


init : VideoPlayerId -> VideoPlayerZIndex -> VideoPlayer
init videoPlayerId videoPlayerZIndex =
    Model.init videoPlayerId videoPlayerZIndex


id : String -> VideoPlayerId
id rawIdString =
    Model.id rawIdString


pauseVideosMsg : (Msg -> msg) -> msg
pauseVideosMsg videoPlayerMsg =
    Msg.pauseVideos videoPlayerMsg


performPauseVideos : (Msg -> msg) -> Cmd msg
performPauseVideos videoPlayerMsg =
    Task.performPauseVideos videoPlayerMsg


performPlayVideos : (Msg -> msg) -> Cmd msg
performPlayVideos videoPlayerMsg =
    Task.performPlayVideos videoPlayerMsg


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


rawZIndex : VideoPlayerZIndex -> Int
rawZIndex videoPlayerZIndex =
    Model.rawZIndex videoPlayerZIndex


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
    (VideoPlayerId -> Tag -> msg)
    -> List Tag
    -> Msg
    -> Update.Context a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update randomTagGeneratedMsg tags msg context =
    Update.update randomTagGeneratedMsg tags msg context


view : Bool -> View.Msgs msgs msg -> VideoPlayer -> Html msg
view audioPlaying msgs videoPlayer =
    View.view audioPlaying msgs videoPlayer


zIndex : Int -> VideoPlayerZIndex
zIndex rawZIndexInt =
    Model.zIndex rawZIndexInt
