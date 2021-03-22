module AudioPlayer.Volume exposing
    ( AudioPlayerVolume
    , rawVolume
    , setWithDefault
    , volume
    )


type AudioPlayerVolume
    = AudioPlayerVolume Int


rawVolume : AudioPlayerVolume -> Int
rawVolume (AudioPlayerVolume rawVolumeInt) =
    rawVolumeInt


setWithDefault : AudioPlayerVolume -> String -> AudioPlayerVolume
setWithDefault currentVolume sliderVolume =
    case String.toInt sliderVolume of
        Just rawVolumeInt ->
            AudioPlayerVolume (contain rawVolumeInt)

        Nothing ->
            currentVolume


volume : Int -> AudioPlayerVolume
volume rawVolumeInt =
    AudioPlayerVolume rawVolumeInt



-- PRIVATE


contain : Int -> Int
contain rawVolumeInt =
    let
        maxVolume =
            100

        minVolume =
            0
    in
    if rawVolumeInt < minVolume then
        minVolume

    else if rawVolumeInt > maxVolume then
        maxVolume

    else
        rawVolumeInt
