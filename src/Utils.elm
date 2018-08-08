module Utils exposing (showApplicationState)

import Model exposing (Model)


showApplicationState : Model -> ()
showApplicationState ({ config } as model) =
    let
        _ =
            Debug.log "Secret Config" model.secretConfig

        _ =
            -- don't output Giphy API key
            Debug.log "Config"
                { gifDisplaySeconds = config.gifDisplaySeconds
                , soundCloudPlaylisturl = config.soundCloudPlaylistUrl
                , tags = config.tags
                , volumeAdjustmentRate = config.volumeAdjustmentRate
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
