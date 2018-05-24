module VideoPlayer
    exposing
        ( VideoPlayer
        , VideoPlayerId(..)
        , animateStyle
        , init
        , setGifUrl
        , updateVisibility
        )

import Animation
import RemoteData exposing (RemoteData(NotRequested, Success), WebData)


type VideoPlayerId
    = Player1
    | Player2


type alias VideoPlayer =
    { gifUrl : WebData String
    , id : VideoPlayerId
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


setGifUrl : String -> VideoPlayer -> VideoPlayer
setGifUrl gifUrl player =
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
