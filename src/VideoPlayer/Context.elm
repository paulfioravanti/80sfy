module VideoPlayer.Context exposing (Context)


type alias Context msg =
    { generateRandomGifMsg : String -> msg }
