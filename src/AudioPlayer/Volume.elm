module AudioPlayer.Volume exposing (contain)


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
