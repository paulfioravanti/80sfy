module Utils exposing (showApplicationState)

import AudioPlayer
import ControlPanel
import Json.Encode as Encode
import Model exposing (Model)
import Ports
import VideoPlayer


showApplicationState : Model -> Cmd msg
showApplicationState ({ config, controlPanel, secretConfig } as model) =
    let
        { audioPlayer, videoPlayer1, videoPlayer2 } =
            model

        audioPlayerJson =
            Encode.object
                [ ( "id"
                  , Encode.string audioPlayer.id
                  )
                , ( "playlist"
                  , Encode.list Encode.int audioPlayer.playlist
                  )
                , ( "playlistLength"
                  , Encode.int audioPlayer.playlistLength
                  )
                , ( "soundCloudIframeUrl"
                  , Encode.string audioPlayer.soundCloudIframeUrl
                  )
                , ( "status"
                  , Encode.string
                        (AudioPlayer.statusToString audioPlayer.status)
                  )
                ]

        -- Do not output Giphy API key
        configJson =
            Encode.object
                [ ( "gifDisplaySeconds"
                  , Encode.float config.gifDisplaySeconds
                  )
                , ( "soundCloudPlaylistUrl"
                  , Encode.string config.soundCloudPlaylistUrl
                  )
                , ( "tags"
                  , Encode.list Encode.string config.tags
                  )
                , ( "volumeAdjustmentRate"
                  , Encode.int config.volumeAdjustmentRate
                  )
                ]

        -- Don't bother with printing the animation style state as it's too
        -- hard to encode and doens't provide any real useful debug information.
        controlPanelJson =
            Encode.object
                [ ( "state"
                  , Encode.string
                        (ControlPanel.stateToString controlPanel.state)
                  )
                ]

        secretConfigJson =
            Encode.object
                [ ( "gifDisplaySeconds"
                  , Encode.string secretConfig.gifDisplaySeconds
                  )
                , ( "overrideInactivityPause"
                  , Encode.bool secretConfig.overrideInactivityPause
                  )
                , ( "soundCloudPlaylistUrl"
                  , Encode.string secretConfig.soundCloudPlaylistUrl
                  )
                , ( "tags"
                  , Encode.string secretConfig.tags
                  )
                , ( "visible"
                  , Encode.bool secretConfig.visible
                  )
                ]

        -- Don't bother with printing the animation style state as it's too
        -- hard to encode and doens't provide any real useful debug information.
        videoPlayer1Json =
            Encode.object
                [ ( "fallbackGifUrl"
                  , Encode.string videoPlayer1.fallbackGifUrl
                  )
                , ( "gifUrl"
                  , Encode.string
                        (VideoPlayer.gifUrlToString videoPlayer1.gifUrl)
                  )
                , ( "id"
                  , Encode.string videoPlayer1.id
                  )
                , ( "status"
                  , Encode.string
                        (VideoPlayer.statusToString videoPlayer1.status)
                  )
                , ( "visible"
                  , Encode.bool videoPlayer1.visible
                  )
                , ( "zIndex"
                  , Encode.int videoPlayer1.zIndex
                  )
                ]

        -- Don't bother with printing the animation style state as it's too
        -- hard to encode and doens't provide any real useful debug information.
        videoPlayer2Json =
            Encode.object
                [ ( "fallbackGifUrl"
                  , Encode.string videoPlayer2.fallbackGifUrl
                  )
                , ( "gifUrl"
                  , Encode.string
                        (VideoPlayer.gifUrlToString videoPlayer2.gifUrl)
                  )
                , ( "id"
                  , Encode.string videoPlayer2.id
                  )
                , ( "status"
                  , Encode.string
                        (VideoPlayer.statusToString videoPlayer2.status)
                  )
                , ( "visible"
                  , Encode.bool videoPlayer2.visible
                  )
                , ( "zIndex"
                  , Encode.int videoPlayer2.zIndex
                  )
                ]

        applicationState =
            Encode.object
                [ ( "Audio Player", audioPlayerJson )
                , ( "Config", configJson )
                , ( "Control Panel", controlPanelJson )
                , ( "Secret Config", secretConfigJson )
                , ( "Video Player 1", videoPlayer1Json )
                , ( "Video Player 2", videoPlayer2Json )
                ]
    in
    Ports.consoleLog applicationState
