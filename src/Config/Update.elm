module Config.Update exposing (update)

import AudioPlayer
import Config.Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Gif
import Http.Error as Error
import Json.Encode as Encode
import MsgRouter exposing (MsgRouter)
import Ports
import SecretConfig
import Task
import VideoPlayer


update : MsgRouter msg -> Msg -> Config -> ( Config, Cmd msg )
update msgRouter msg config =
    case msg of
        Msg.GenerateRandomGif videoPlayerId ->
            ( config
            , Gif.random
                (msgRouter.configMsg << Msg.RandomTag videoPlayerId)
                config.tags
            )

        Msg.InitTags (Ok tags) ->
            let
                randomGifForVideoPlayerId videoPlayerId =
                    msgRouter.configMsg (Msg.GenerateRandomGif videoPlayerId)
                        |> Task.succeed
                        |> Task.perform identity

                initSecretConfigTags =
                    msgRouter.secretConfigMsg (SecretConfig.initTagsMsg tags)
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

        Msg.RandomTag videoPlayerId tag ->
            let
                fetchRandomGifMsg =
                    msgRouter.videoPlayerMsg
                        << VideoPlayer.fetchRandomGifMsg videoPlayerId
            in
            ( config
            , tag
                |> Gif.fetchRandomGif fetchRandomGifMsg config.giphyApiKey
            )

        Msg.SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
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
                        msgRouter.audioPlayerMsg
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
