module AudioPlayer.Status exposing (Status(..))


type Status
    = Playing
    | Paused
    | Muted Status
