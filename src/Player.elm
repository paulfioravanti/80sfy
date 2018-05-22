module Player exposing (Player, PlayerId(..), init, setStyle)

import Animation
import RemoteData exposing (RemoteData(NotRequested), WebData)


type PlayerId
    = Player1
    | Player2


type alias Player =
    { gifUrl : WebData String
    , id : PlayerId
    , style : Animation.State
    , visible : Bool
    }


init : PlayerId -> Bool -> Player
init id visibility =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visibility
    }


setStyle : Animation.Msg -> Player -> Player
setStyle msg player =
    { player | style = Animation.update msg player.style }
