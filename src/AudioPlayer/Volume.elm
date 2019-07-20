module AudioPlayer.Volume exposing (setWithDefault)


setWithDefault : Int -> String -> Int
setWithDefault currentVolume sliderVolume =
    case String.toInt sliderVolume of
        Just volume ->
            contain volume

        Nothing ->
            currentVolume



-- PRIVATE


contain : Int -> Int
contain volume =
    let
        maxVolume =
            100

        minVolume =
            0
    in
    if volume < minVolume then
        minVolume

    else if volume > maxVolume then
        maxVolume

    else
        volume
