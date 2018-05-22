module Player
    exposing
        ( Player
        , PlayerId(..)
        , init
        , setGifUrl
        , setVisible
        , updateStyle
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


init : PlayerId -> Bool -> Int -> Player
init id visible zIndex =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }


updateVisibility : Player -> Player
updateVisibility player =
    let
        newOpacity =
            if player.visible then
                0
            else
                1
    in
        { player
            | style =
                Animation.interrupt
                    [ Animation.to
                        [ Animation.opacity newOpacity ]
                    ]
                    player.style
            , visible = not player.visible
        }


updateStyle : Animation.Msg -> Player -> Player
updateStyle msg player =
    { player | style = Animation.update msg player.style }


setGifUrl : String -> Player -> Player
setGifUrl gifUrl player =
    { player | gifUrl = Success gifUrl }


setVisible : Bool -> Player -> Player
setVisible visible player =
    { player | visible = visible }
