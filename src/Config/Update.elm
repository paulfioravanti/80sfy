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
import VideoPlayer


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , generateRandomGifMsg : String -> msg
        , secretConfigMsg : SecretConfig.Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : Msgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update msgs msg config =
    case msg of
        Msg.InitTags (Ok tags) ->
            let
                randomGifForVideoPlayerId videoPlayerId =
                    Task.generateRandomGif
                        msgs.generateRandomGifMsg
                        videoPlayerId

                initSecretConfigTags =
                    SecretConfig.initTags msgs.secretConfigMsg tags
            in
            ( { config | tags = tags }
            , Cmd.batch
                [ randomGifForVideoPlayerId "1"
                , randomGifForVideoPlayerId "2"
                , initSecretConfigTags
                ]
            )

        Msg.InitTags (Err error) ->
            let
                message =
                    Encode.object
                        [ ( "InitTags Failed"
                          , Encode.string (Error.toString error)
                          )
                        ]
            in
            ( config, Ports.consoleLog message )

        Msg.RandomTagGenerated videoPlayerId tag ->
            let
                fetchRandomGifMsg =
                    VideoPlayer.fetchRandomGifMsg
                        msgs.videoPlayerMsg
                        videoPlayerId

                fetchRandomGif =
                    Gif.fetchRandomGif fetchRandomGifMsg config.giphyApiKey tag
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
