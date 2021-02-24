module Config.Update exposing (Msgs, update)

import AudioPlayer
import Config.Model as Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Config.Task as Task
import Error
import Gif
import Json.Encode as Encode
import Ports
import SecretConfig
import Tag
import VideoPlayer exposing (VideoPlayerId)


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , generateRandomGifMsg : VideoPlayerId -> msg
        , secretConfigMsg : SecretConfig.Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : Msgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    case msg of
        Msg.RandomTagGenerated videoPlayerId tag ->
            let
                randomGifUrlFetchedMsg =
                    VideoPlayer.randomGifUrlFetchedMsg
                        msgs.videoPlayerMsg
                        videoPlayerId

                rawGiphyApiKey =
                    Model.rawGiphyApiKey config.giphyApiKey

                rawTag =
                    Tag.rawTag tag

                fetchRandomGif =
                    Gif.fetchRandomGifUrl
                        randomGifUrlFetchedMsg
                        rawGiphyApiKey
                        rawTag
            in
            ( config, fetchRandomGif )

        Msg.Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                updatedConfig =
                    Model.update
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplaySecondsString
                        config

                cmd =
                    if
                        soundCloudPlaylistUrl
                            == config.soundCloudPlaylistUrl
                    then
                        Cmd.none

                    else
                        AudioPlayer.reInitAudioPlayer
                            msgs.audioPlayerMsg
                            soundCloudPlaylistUrl
            in
            ( updatedConfig, cmd )

        Msg.TagsFetched (Ok rawTags) ->
            let
                tags =
                    List.map Tag.tag rawTags

                randomGifForVideoPlayerId videoPlayerId =
                    Task.generateRandomGif
                        msgs.generateRandomGifMsg
                        videoPlayerId

                initSecretConfigTags =
                    SecretConfig.initTags msgs.secretConfigMsg rawTags
            in
            ( { config | tags = tags }
            , Cmd.batch
                [ randomGifForVideoPlayerId (VideoPlayer.id "1")
                , randomGifForVideoPlayerId (VideoPlayer.id "2")
                , initSecretConfigTags
                ]
            )

        Msg.TagsFetched (Err error) ->
            let
                message =
                    Encode.object
                        [ ( "Fetching Tags Failed"
                          , Encode.string (Error.toString error)
                          )
                        ]
            in
            ( config, Ports.consoleLog message )
