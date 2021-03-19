module Config.Update exposing (ParentMsgs, update)

import AudioPlayer
import Config.Model as Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Gif
import Ports
import SecretConfig
import Tag
import VideoPlayer


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , configMsg : Msg -> msg
        , secretConfigMsg : SecretConfig.Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    case msg of
        Msg.RandomTagGenerated videoPlayerId tag ->
            let
                randomGifUrlFetchedMsg =
                    VideoPlayer.randomGifUrlFetchedMsg
                        msgs.videoPlayerMsg
                        videoPlayerId

                fetchRandomGifUrl =
                    Gif.fetchRandomGifUrl
                        randomGifUrlFetchedMsg
                        config.giphyApiKey
                        tag
            in
            ( config, fetchRandomGifUrl )

        Msg.Save soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds ->
            let
                updatedConfig =
                    Model.update
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplayIntervalSeconds
                        config

                cmd =
                    if
                        soundCloudPlaylistUrl
                            == config.soundCloudPlaylistUrl
                    then
                        Cmd.none

                    else
                        AudioPlayer.performAudioPlayerReset
                            msgs.audioPlayerMsg
                            soundCloudPlaylistUrl
            in
            ( updatedConfig, cmd )

        Msg.TagsFetched (Ok rawTags) ->
            let
                tags =
                    List.map Tag.tag rawTags

                generateRandomTagForVideoPlayer videoPlayerId =
                    Tag.generateRandomTag
                        (Msg.randomTagGenerated msgs.configMsg videoPlayerId)
                        tags

                performInitSecretConfigTags =
                    SecretConfig.performInitTags msgs.secretConfigMsg rawTags
            in
            ( { config | tags = tags }
            , Cmd.batch
                [ generateRandomTagForVideoPlayer (VideoPlayer.id "1")
                , generateRandomTagForVideoPlayer (VideoPlayer.id "2")
                , performInitSecretConfigTags
                ]
            )

        Msg.TagsFetched (Err error) ->
            ( config, Ports.logError "Fetching Tags Failed" error )
