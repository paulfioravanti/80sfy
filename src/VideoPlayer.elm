module VideoPlayer
    exposing
        ( VideoPlayer
        , init
        , animateStyle
        , newVisibility
        , setSuccessGifUrl
        , subscriptions
        , toggleFullScreen
        , togglePlaying
        , toggleVideoPlay
        , update
        , updateVisibility
        , view
        )

import Animation
import Html.Styled exposing (Html)
import MsgConfig exposing (MsgConfig)
import RemoteData exposing (RemoteData(Success), WebData)
import Task
import VideoPlayer.Model as Model
import VideoPlayer.Msg
import VideoPlayer.Ports as Ports
import VideoPlayer.Subscriptions as Subscriptions
import VideoPlayer.View as View
import VideoPlayer.Update as Update


type alias VideoPlayer =
    Model.VideoPlayer


init : String -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    Model.init id visible zIndex


animateStyle : Animation.Msg -> VideoPlayer -> VideoPlayer
animateStyle msg videoPlayer =
    { videoPlayer | style = Animation.update msg videoPlayer.style }


newVisibility : VideoPlayer -> ( Bool, String )
newVisibility videoPlayer1 =
    if videoPlayer1.visible then
        ( False, "1" )
    else
        ( True, "2" )


setSuccessGifUrl : String -> VideoPlayer -> VideoPlayer
setSuccessGifUrl gifUrl videoPlayer =
    { videoPlayer | gifUrl = Success gifUrl }


subscriptions : MsgConfig msg -> Bool -> VideoPlayer -> Sub msg
subscriptions msgConfig fetchNextGif videoPlayer1 =
    Subscriptions.subscriptions msgConfig fetchNextGif videoPlayer1


toggleFullScreen : Cmd msg
toggleFullScreen =
    Ports.toggleFullScreen ()


togglePlaying : Bool -> VideoPlayer -> VideoPlayer
togglePlaying playing videoPlayer =
    { videoPlayer | playing = playing }


toggleVideoPlay : Bool -> Cmd msg
toggleVideoPlay play =
    Ports.toggleVideoPlay play


update :
    MsgConfig msg
    -> VideoPlayer.Msg.Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msgConfig msg videoPlayer1 videoPlayer2 =
    Update.update msgConfig msg videoPlayer1 videoPlayer2


updateVisibility : Bool -> VideoPlayer -> VideoPlayer
updateVisibility visible videoPlayer =
    let
        newOpacity =
            if videoPlayer.visible then
                0
            else
                1

        animateToNewOpacity =
            Animation.interrupt
                [ Animation.to
                    [ Animation.opacity newOpacity ]
                ]
                videoPlayer.style
    in
        { videoPlayer | style = animateToNewOpacity, visible = visible }


view : MsgConfig msg -> VideoPlayer -> Html msg
view msgConfig videoPlayer =
    View.view msgConfig videoPlayer
