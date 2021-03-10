module Port.Msg exposing (Msg(..))


type Msg
    = RequestFullscreen


requestFullscreen : (Msg -> msg) -> msg
requestFullscreen portMsg =
    portMsg RequestFullscreen
