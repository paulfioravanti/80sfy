module Player exposing (Player, PlayerId(..), init)

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


init : PlayerId -> Player
init id =
    let
        ( opacity, visibility ) =
            case id of
                Player1 ->
                    ( 1, True )

                Player2 ->
                    ( 0, False )
    in
        { gifUrl = NotRequested
        , id = id
        , style = Animation.style [ Animation.opacity opacity ]
        , visible = visibility
        }
