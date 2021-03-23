module ApplicationState exposing (show)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import Gif
import Json.Encode as Encode exposing (Value)
import Model exposing (Model)
import Ports
import SecretConfig exposing (SecretConfig)
import SoundCloud
import Tag
import VideoPlayer exposing (VideoPlayer)


show : Model -> Cmd msg
show { audioPlayer, config, controlPanel, secretConfig, videoPlayer1, videoPlayer2 } =
    let
        applicationState : Value
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


configJson : Config -> Value
configJson config =
    let
        rawTags : List String
        rawTags =
            List.map Tag.rawTag config.tags

        rawSoundCloudPlaylistUrl : String
        rawSoundCloudPlaylistUrl =
            SoundCloud.rawPlaylistUrl config.soundCloudPlaylistUrl

        gifDisplayIntervalSeconds : Float
        gifDisplayIntervalSeconds =
            Gif.rawDisplayIntervalSeconds config.gifDisplayIntervalSeconds

        volumeAdjustmentRate : Int
        volumeAdjustmentRate =
            Config.rawVolumeAdjustmentRate config.volumeAdjustmentRate
    in
    -- Do not output Giphy API key
    Encode.object
        [ ( "gifDisplayIntervalSeconds"
          , Encode.float gifDisplayIntervalSeconds
          )
        , ( "soundCloudPlaylistUrl"
          , Encode.string rawSoundCloudPlaylistUrl
          )
        , ( "tags"
          , Encode.list Encode.string rawTags
          )
        , ( "volumeAdjustmentRate"
          , Encode.int volumeAdjustmentRate
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
            Gif.rawDisplayIntervalSeconds secretConfig.gifDisplaySeconds

        rawTags : String
        rawTags =
            Tag.rawTagsString secretConfig.tags
    in
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
          , Encode.string rawTags
          )
        , ( "visible"
          , Encode.bool secretConfig.visible
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
