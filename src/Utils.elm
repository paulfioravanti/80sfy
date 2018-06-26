module Utils exposing (showApplicationState)

import Debug
import Model exposing (Model)


showApplicationState : Model -> ()
showApplicationState model =
    let
        _ =
            Debug.log "Secret Config" model.secretConfig

        -- don't output Giphy API key
        { gifDisplaySeconds, soundCloudPlaylistUrl, tags, volumeAdjustmentRate } =
            model.config

        _ =
            Debug.log "Config"
                { gifDisplaySeconds = gifDisplaySeconds
                , soundCloudPlaylisturl = soundCloudPlaylistUrl
                , tags = tags
                , volumeAdjustmentRate = volumeAdjustmentRate
                }

        _ =
            Debug.log "Control Panel" model.controlPanel

        _ =
            Debug.log "VideoPlayer 2" model.videoPlayer2

        _ =
            Debug.log "VideoPlayer 1" model.videoPlayer1

        _ =
            Debug.log "Audio Player" model.audioPlayer
    in
        ()
