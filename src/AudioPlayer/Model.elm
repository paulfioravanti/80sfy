module AudioPlayer.Model exposing (AudioPlayer, init)


type alias AudioPlayer =
    { muted : Bool
    , playing : Bool
    , volume : String
    }


init : AudioPlayer
init =
    { muted = False
    , playing = False
    , volume = "80"
    }
