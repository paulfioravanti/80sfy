module Utils exposing (showApplicationState)

import Debug
import Model exposing (Model)


showApplicationState : Model -> ()
showApplicationState model =
    let
        _ =
            Debug.log "Secret Config" model.secretConfig

        _ =
            -- don't output Giphy API key
            Debug.log "Config"
                { gifDisplaySeconds = model.config.gifDisplaySeconds
                , soundCloudPlaylisturl = model.config.soundCloudPlaylistUrl
                , tags = model.config.tags
                , volumeAdjustmentRate = model.config.volumeAdjustmentRate
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
