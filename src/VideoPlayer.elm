module VideoPlayer
    exposing
        ( VideoPlayer
        , VideoPlayerId
        , init
        , animateStyle
        , newVisibility
        , setSuccessGifUrl
        , updateVisibility
        , view
        )

import Animation
import Html.Styled exposing (Html)
import RemoteData exposing (RemoteData(Success), WebData)
import Styles
import VideoPlayer.Model as Model
import VideoPlayer.View as View


type alias VideoPlayerId =
    Model.VideoPlayerId


type alias VideoPlayer =
    Model.VideoPlayer


init : VideoPlayerId -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    Model.init id visible zIndex


animateStyle : Animation.Msg -> VideoPlayer -> VideoPlayer
animateStyle msg player =
    { player | style = Animation.update msg player.style }


newVisibility : VideoPlayer -> ( Bool, VideoPlayerId )
newVisibility player1 =
    if player1.visible then
        ( False, "1" )
    else
        ( True, "2" )


setSuccessGifUrl : String -> VideoPlayer -> VideoPlayer
setSuccessGifUrl gifUrl player =
    { player | gifUrl = Success gifUrl }


updateVisibility : Bool -> VideoPlayer -> VideoPlayer
updateVisibility visible player =
    let
        newOpacity =
            if player.visible then
                0
            else
                1

        animateToNewOpacity =
            Animation.interrupt
                [ Animation.to
                    [ Animation.opacity newOpacity ]
                ]
                player.style
    in
        { player | style = animateToNewOpacity, visible = visible }


view : VideoPlayer -> Html msg
view player =
    View.view player
