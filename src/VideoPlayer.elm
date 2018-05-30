module VideoPlayer
    exposing
        ( VideoPlayer
        , VideoPlayerId
        , animateStyle
        , init
        , newVisibility
        , setSuccessGifUrl
        , updateVisibility
        , view
        )

import Animation
import Html.Styled as Html exposing (Html, div, text, video)
import Html.Styled.Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , property
        , src
        )
import Json.Encode as Encode
import RemoteData
    exposing
        ( RemoteData
            ( Failure
            , NotRequested
            , Requesting
            , Success
            )
        , WebData
        )
import Styles
import VideoPlayer.View as View


type alias VideoPlayerId =
    String


type alias VideoPlayer =
    { gifUrl : WebData String
    , id : String
    , style : Animation.State
    , visible : Bool
    , zIndex : Int
    }


animateStyle : Animation.Msg -> VideoPlayer -> VideoPlayer
animateStyle msg player =
    { player | style = Animation.update msg player.style }


init : VideoPlayerId -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }


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
