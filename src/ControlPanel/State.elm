module ControlPanel.State exposing
    ( State
    , idleSeconds
    , inUse
    , invisible
    , isIdle
    , keepVisible
    , setIdle
    , toString
    , toggleHideWhenInactive
    )


type State
    = Idle Int
    | InUse
    | Invisible
    | KeepVisible


idleSeconds : State -> Int
idleSeconds state =
    case state of
        Idle seconds ->
            seconds

        _ ->
            0


inUse : State
inUse =
    InUse


invisible : State
invisible =
    Invisible


isIdle : State -> Bool
isIdle state =
    case state of
        Idle _ ->
            True

        _ ->
            False


keepVisible : State
keepVisible =
    KeepVisible


setIdle : Int -> State
setIdle seconds =
    Idle seconds


toggleHideWhenInactive : State -> State
toggleHideWhenInactive state =
    case state of
        KeepVisible ->
            Idle 0

        _ ->
            KeepVisible


toString : State -> String
toString state =
    case state of
        Idle seconds ->
            "Idle " ++ String.fromInt seconds

        InUse ->
            "InUse"

        Invisible ->
            "Invisible"

        KeepVisible ->
            "KeepVisible"
