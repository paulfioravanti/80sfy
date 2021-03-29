module ApplicationState exposing (show)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (SecretConfig)
import ControlPanel exposing (ControlPanel)
import Gif
import Json.Encode as Encode exposing (Value)
import Model exposing (Model)
import Ports
import SoundCloud
import Tag
import VideoPlayer exposing (VideoPlayer)


show : Model -> Cmd msg
show { audioPlayer, controlPanel, secretConfig, videoPlayer1, videoPlayer2 } =
    let
        applicationState : Value
        applicationState =
            Encode.object
                [ ( "Audio Player", audioPlayerJson audioPlayer )
                , ( "Control Panel", controlPanelJson controlPanel )
                , ( "Secret Config", secretConfigJson secretConfig )
                , ( "Video Player 1", videoPlayerJson videoPlayer1 )
                , ( "Video Player 2", videoPlayerJson videoPlayer2 )
                ]
    in
    Ports.log applicationState



-- PRIVATE


audioPlayerJson : AudioPlayer -> Value
audioPlayerJson audioPlayer =
    let
        rawAudioPlayerId : String
        rawAudioPlayerId =
            AudioPlayer.rawId audioPlayer.id

        audioPlayerStatus : String
        audioPlayerStatus =
            AudioPlayer.statusToString audioPlayer.status

        rawSoundCloudIframeUrl : String
        rawSoundCloudIframeUrl =
            SoundCloud.rawIframeUrl audioPlayer.soundCloudIframeUrl

        rawPlaylist : List Int
        rawPlaylist =
            List.map AudioPlayer.rawTrackIndex audioPlayer.playlist
    in
    Encode.object
        [ ( "id"
          , Encode.string rawAudioPlayerId
          )
        , ( "playlist"
          , Encode.list Encode.int rawPlaylist
          )
        , ( "playlistLength"
          , Encode.int audioPlayer.playlistLength
          )
        , ( "soundCloudIframeUrl"
          , Encode.string rawSoundCloudIframeUrl
          )
        , ( "status"
          , Encode.string audioPlayerStatus
          )
        ]


controlPanelJson : ControlPanel -> Value
controlPanelJson controlPanel =
    -- Don't bother with printing the animation style state as it's too
    -- hard to encode and doesn't provide any real useful debug information.
    let
        controlPanelState : String
        controlPanelState =
            ControlPanel.stateToString controlPanel.state
    in
    Encode.object
        [ ( "state", Encode.string controlPanelState ) ]


secretConfigJson : SecretConfig -> Value
secretConfigJson secretConfig =
    let
        rawSoundCloudPlaylistUrl : String
        rawSoundCloudPlaylistUrl =
            SoundCloud.rawPlaylistUrl secretConfig.soundCloudPlaylistUrl

        rawGifDisplayIntervalSeconds : Float
        rawGifDisplayIntervalSeconds =
            Gif.rawDisplayIntervalSeconds secretConfig.gifDisplayIntervalSeconds

        rawTags : List String
        rawTags =
            List.map Tag.rawTag secretConfig.tags

        volumeAdjustmentRate : Int
        volumeAdjustmentRate =
            Config.rawVolumeAdjustmentRate secretConfig.volumeAdjustmentRate
    in
    -- Do not output Giphy API key
    Encode.object
        [ ( "gifDisplayIntervalSeconds"
          , Encode.float rawGifDisplayIntervalSeconds
          )
        , ( "overrideInactivityPause"
          , Encode.bool secretConfig.overrideInactivityPause
          )
        , ( "soundCloudPlaylistUrl"
          , Encode.string rawSoundCloudPlaylistUrl
          )
        , ( "tags"
          , Encode.list Encode.string rawTags
          )
        , ( "visible"
          , Encode.bool secretConfig.visible
          )
        , ( "volumeAdjustmentRate"
          , Encode.int volumeAdjustmentRate
          )
        ]


videoPlayerJson : VideoPlayer -> Value
videoPlayerJson videoPlayer =
    -- Don't bother with printing the animation style state as it's too
    -- hard to encode and doesn't provide any real useful debug information.
    let
        videoPlayerGifUrl : String
        videoPlayerGifUrl =
            Gif.rawUrlFromWebData videoPlayer.gifUrl

        videoPlayerStatus : String
        videoPlayerStatus =
            VideoPlayer.statusToString videoPlayer.status

        videoPlayerRawId : String
        videoPlayerRawId =
            VideoPlayer.rawId videoPlayer.id

        rawVideoPlayerZIndex : Int
        rawVideoPlayerZIndex =
            VideoPlayer.rawZIndex videoPlayer.zIndex

        rawFallbackGifUrl : String
        rawFallbackGifUrl =
            Gif.rawUrl videoPlayer.fallbackGifUrl
    in
    Encode.object
        [ ( "fallbackGifUrl"
          , Encode.string rawFallbackGifUrl
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
          , Encode.int rawVideoPlayerZIndex
          )
        ]
