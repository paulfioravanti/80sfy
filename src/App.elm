module App exposing (showApplicationState)

import Model exposing (Model)


showApplicationState : Model -> ()
showApplicationState model =
    let
        _ =
            Debug.log "Config" model.secretConfig

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
