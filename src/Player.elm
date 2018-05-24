module Player
    exposing
        ( Player
        , PlayerId(..)
        , init
        , setGifUrl
        , setVisibility
        , updateStyle
        , updateVisibility
        )

import Animation
import RemoteData exposing (RemoteData(NotRequested, Success), WebData)
import Visibility exposing (Visibility(Hidden, Visible))


type PlayerId
    = Player1
    | Player2


type alias Player =
    { gifUrl : WebData String
    , id : PlayerId
    , style : Animation.State
    , visibility : Visibility
    , zIndex : Int
    }


init : PlayerId -> Visibility -> Int -> Player
init id visibility zIndex =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visibility = visibility
    , zIndex = zIndex
    }


setGifUrl : String -> Player -> Player
setGifUrl gifUrl player =
    { player | gifUrl = Success gifUrl }


setVisibility : Visibility -> Player -> Player
setVisibility visibility player =
    { player | visibility = visibility }


updateStyle : Animation.Msg -> Player -> Player
updateStyle msg player =
    { player | style = Animation.update msg player.style }


updateVisibility : Visibility -> Player -> Player
updateVisibility visibility player =
    let
        newOpacity =
            if player.visibility == Visible then
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
            , visibility = visibility
        }
