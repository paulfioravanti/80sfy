module ApplicationState exposing (show)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import Json.Encode as Encode exposing (Value)
import Model exposing (Model)
import Ports
import SecretConfig exposing (SecretConfig)
import Tag
import VideoPlayer exposing (VideoPlayer)


show : Model -> Cmd msg
show { audioPlayer, config, controlPanel, secretConfig, videoPlayer1, videoPlayer2 } =
    let
        applicationState =
            Encode.object
                [ ( "Audio Player", audioPlayerJson audioPlayer )
                , ( "Config", configJson config )
                , ( "Control Panel", controlPanelJson controlPanel )
                , ( "Secret Config", secretConfigJson secretConfig )
                , ( "Video Player 1", videoPlayerJson videoPlayer1 )
                , ( "Video Player 2", videoPlayerJson videoPlayer2 )
                ]
    in
    Ports.consoleLog applicationState



-- PRIVATE


audioPlayerJson : AudioPlayer -> Value
audioPlayerJson audioPlayer =
    let
        audioPlayerRawId =
            AudioPlayer.rawId audioPlayer.id

        audioPlayerStatus =
            AudioPlayer.statusToString audioPlayer.status
    in
    Encode.object
        [ ( "id"
          , Encode.string audioPlayerRawId
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
          , Encode.string audioPlayerStatus
          )
        ]


configJson : Config -> Value
configJson config =
    let
        tags =
            List.map Tag.rawTag config.tags
    in
    -- Do not output Giphy API key
    Encode.object
        [ ( "gifDisplaySeconds"
          , Encode.float config.gifDisplaySeconds
          )
        , ( "soundCloudPlaylistUrl"
          , Encode.string config.soundCloudPlaylistUrl
          )
        , ( "tags"
          , Encode.list Encode.string tags
          )
        , ( "volumeAdjustmentRate"
          , Encode.int config.volumeAdjustmentRate
          )
        ]


controlPanelJson : ControlPanel -> Value
controlPanelJson controlPanel =
    -- Don't bother with printing the animation style state as it's too
    -- hard to encode and doens't provide any real useful debug information.
    let
        controlPanelState =
            ControlPanel.stateToString controlPanel.state
    in
    Encode.object
        [ ( "state", Encode.string controlPanelState ) ]


secretConfigJson : SecretConfig -> Value
secretConfigJson secretConfig =
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


videoPlayerJson : VideoPlayer -> Value
videoPlayerJson videoPlayer =
    -- Don't bother with printing the animation style state as it's too
    -- hard to encode and doens't provide any real useful debug information.
    let
        videoPlayerGifUrl =
            VideoPlayer.gifUrlToString videoPlayer.gifUrl

        videoPlayerStatus =
            VideoPlayer.statusToString videoPlayer.status

        videoPlayerRawId =
            VideoPlayer.rawId videoPlayer.id
    in
    Encode.object
        [ ( "fallbackGifUrl"
          , Encode.string videoPlayer.fallbackGifUrl
          )
        , ( "gifUrl"
          , Encode.string videoPlayerGifUrl
          )
        , ( "id"
          , Encode.string videoPlayerRawId
          )
        , ( "status"
          , Encode.string videoPlayerStatus
          )
        , ( "visible"
          , Encode.bool videoPlayer.visible
          )
        , ( "zIndex"
          , Encode.int videoPlayer.zIndex
          )
        ]
