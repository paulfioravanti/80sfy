module Config.Update exposing (update)

import AudioPlayer
import Config.Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Error
import Gif
import Json.Encode as Encode
import Ports
import SecretConfig
import Task
import VideoPlayer


update :
    (AudioPlayer.Msg -> msg)
    -> (Msg -> msg)
    -> (SecretConfig.Msg -> msg)
    -> (VideoPlayer.Msg -> msg)
    -> Msg
    -> Config
    -> ( Config, Cmd msg )
update audioPlayerMsg configMsg secretConfigMsg videoPlayerMsg msg config =
    case msg of
        Msg.GenerateRandomGif videoPlayerId ->
            ( config
            , Gif.random
                (configMsg << Msg.RandomTagGenerated videoPlayerId)
                config.tags
            )

        Msg.InitTags (Ok tags) ->
            let
                randomGifForVideoPlayerId videoPlayerId =
                    configMsg (Msg.GenerateRandomGif videoPlayerId)
                        |> Task.succeed
                        |> Task.perform identity

                initSecretConfigTags =
                    secretConfigMsg (SecretConfig.initTagsMsg tags)
                        |> Task.succeed
                        |> Task.perform identity
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
                    videoPlayerMsg
                        << VideoPlayer.fetchRandomGifMsg videoPlayerId
            in
            ( config
            , tag
                |> Gif.fetchRandomGif fetchRandomGifMsg config.giphyApiKey
            )

        Msg.Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                tags =
                    tagsString
                        |> String.split ", "
                        |> List.map String.trim

                gifDisplaySeconds =
                    gifDisplaySecondsString
                        |> String.toFloat
                        |> Maybe.map
                            (\seconds ->
                                if seconds < 1 then
                                    config.gifDisplaySeconds

                                else
                                    seconds
                            )
                        |> Maybe.withDefault config.gifDisplaySeconds

                cmd =
                    if
                        soundCloudPlaylistUrl
                            /= config.soundCloudPlaylistUrl
                    then
                        audioPlayerMsg
                            (AudioPlayer.reInitAudioPlayerMsg
                                soundCloudPlaylistUrl
                            )
                            |> Task.succeed
                            |> Task.perform identity

                    else
                        Cmd.none
            in
            ( { config
                | gifDisplaySeconds = gifDisplaySeconds
                , soundCloudPlaylistUrl = soundCloudPlaylistUrl
                , tags = tags
              }
            , cmd
            )
