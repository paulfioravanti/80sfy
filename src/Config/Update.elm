module Config.Update exposing (Msgs, update)

import AudioPlayer
import Config.Model as Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Error
import Gif
import Json.Encode as Encode
import Ports
import SecretConfig
import Tag
import VideoPlayer


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , configMsg : Msg -> msg
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

                fetchRandomGif =
                    Gif.fetchRandomGifUrl
                        randomGifUrlFetchedMsg
                        config.giphyApiKey
                        tag
            in
            ( config, fetchRandomGif )

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
            let
                message =
                    Encode.object
                        [ ( "Fetching Tags Failed"
                          , Encode.string (Error.toString error)
                          )
                        ]
            in
            ( config, Ports.log message )
