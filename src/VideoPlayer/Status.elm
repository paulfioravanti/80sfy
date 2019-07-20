module VideoPlayer.Status exposing
    ( Status
    , halted
    , paused
    , playing
    , toString
    )


type Status
    = Playing
    | Paused
    | Halted


halted : Status
halted =
    Halted


paused : Status
paused =
    Paused


playing : Status
playing =
    Playing


toString : Status -> String
toString status =
    case status of
        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Halted ->
            "Halted"
