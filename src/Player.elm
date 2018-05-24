module Player
    exposing
        ( Player
        , PlayerId(..)
        , animateStyle
        , init
        , setGifUrl
        , updateVisibility
        )

import Animation
import RemoteData exposing (RemoteData(NotRequested, Success), WebData)


type PlayerId
    = Player1
    | Player2


type alias Player =
    { gifUrl : WebData String
    , id : PlayerId
    , style : Animation.State
    , visible : Bool
    , zIndex : Int
    }


animateStyle : Animation.Msg -> Player -> Player
animateStyle msg player =
    { player | style = Animation.update msg player.style }


init : PlayerId -> Bool -> Int -> Player
init id visible zIndex =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }


setGifUrl : String -> Player -> Player
setGifUrl gifUrl player =
    { player | gifUrl = Success gifUrl }


updateVisibility : Bool -> Player -> Player
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
        { player
            | style = animateToNewOpacity
            , visible = visible
        }
