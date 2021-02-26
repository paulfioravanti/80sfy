module AudioPlayer.Volume exposing
    ( AudioPlayerVolume
    , adjustDown
    , adjustUp
    , rawVolume
    , setWithDefault
    , volume
    )


type AudioPlayerVolume
    = AudioPlayerVolume Int


adjustDown : AudioPlayerVolume -> Int -> AudioPlayerVolume
adjustDown (AudioPlayerVolume rawAudioPlayerVolumeInt) volumeAdjustmentRate =
    AudioPlayerVolume (rawAudioPlayerVolumeInt - volumeAdjustmentRate)


adjustUp : AudioPlayerVolume -> Int -> AudioPlayerVolume
adjustUp (AudioPlayerVolume rawAudioPlayerVolumeInt) volumeAdjustmentRate =
    AudioPlayerVolume (rawAudioPlayerVolumeInt + volumeAdjustmentRate)


setWithDefault : AudioPlayerVolume -> String -> AudioPlayerVolume
setWithDefault currentVolume sliderVolume =
    case String.toInt sliderVolume of
        Just rawVolumeInt ->
            AudioPlayerVolume (contain rawVolumeInt)

        Nothing ->
            currentVolume


rawVolume : AudioPlayerVolume -> Int
rawVolume (AudioPlayerVolume rawVolumeInt) =
    rawVolumeInt


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
