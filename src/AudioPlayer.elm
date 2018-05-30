module AudioPlayer exposing (AudioPlayer, init)


type alias AudioPlayer =
    { playing : Bool }


init : AudioPlayer
init =
    { playing = False }
