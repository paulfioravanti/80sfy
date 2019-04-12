module ControlPanel.State exposing (State(..), toString)


type State
    = Idle Int
    | InUse
    | Invisible
    | KeepVisible


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
