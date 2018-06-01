port module VideoPlayer
    exposing
        ( VideoPlayer
        , VideoPlayerId
        , init
        , animateStyle
        , newVisibility
        , setSuccessGifUrl
        , togglePlaying
        , toggleVideoPlay
        , updateVisibility
        , view
        )

import Animation
import Html.Styled exposing (Html)
import Msg exposing (Msg)
import RemoteData exposing (RemoteData(Success), WebData)
import VideoPlayer.Model as Model
import VideoPlayer.View as View


port toggleVideoPlay : Bool -> Cmd msg


type alias VideoPlayerId =
    Model.VideoPlayerId


type alias VideoPlayer =
    Model.VideoPlayer


init : VideoPlayerId -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    Model.init id visible zIndex


animateStyle : Animation.Msg -> VideoPlayer -> VideoPlayer
animateStyle msg videoPlayer =
    { videoPlayer | style = Animation.update msg videoPlayer.style }


newVisibility : VideoPlayer -> ( Bool, VideoPlayerId )
newVisibility videoPlayer1 =
    if videoPlayer1.visible then
        ( False, "1" )
    else
        ( True, "2" )


setSuccessGifUrl : String -> VideoPlayer -> VideoPlayer
setSuccessGifUrl gifUrl videoPlayer =
    { videoPlayer | gifUrl = Success gifUrl }


togglePlaying : Bool -> VideoPlayer -> VideoPlayer
togglePlaying playing videoPlayer =
    { videoPlayer | playing = playing }


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


view : VideoPlayer -> Html Msg
view videoPlayer =
    View.view videoPlayer
