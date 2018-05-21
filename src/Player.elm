module Player exposing (Id(..), Player, init)

import Animation
import RemoteData exposing (RemoteData(NotRequested), WebData)


type Id
    = Player1
    | Player2


type alias Player =
    { gifUrl : WebData String
    , id : Id
    , style : Animation.State
    , visible : Bool
    }


init : Id -> Player
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
