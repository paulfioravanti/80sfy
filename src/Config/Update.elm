module Config.Update exposing (update)

import AudioPlayer
import Config.Model exposing (Config)
import Config.Msg
    exposing
        ( Msg
            ( GenerateRandomGif
            , InitTags
            , RandomTag
            , SaveConfig
            )
        )
import Debug
import Gif
import MsgRouter exposing (MsgRouter)
import SecretConfig
import Task
import VideoPlayer


update : MsgRouter msg -> Config.Msg.Msg -> Config -> ( Config, Cmd msg )
update msgRouter msg config =
    case msg of
        GenerateRandomGif videoPlayerId ->
            ( config
            , Gif.random
                (msgRouter.configMsg << RandomTag videoPlayerId)
                config.tags
            )

        InitTags (Ok tags) ->
            let
                randomGifForVideoPlayerId videoPlayerId =
                    msgRouter.configMsg (GenerateRandomGif videoPlayerId)
                        |> Task.succeed
                        |> Task.perform identity

                initSecretConfigTags =
                    Task.succeed tags
                        |> Task.perform
                            (msgRouter.secretConfigMsg
                                << SecretConfig.initTagsMsg
                            )
            in
                ( { config | tags = tags }
                , Cmd.batch
                    [ randomGifForVideoPlayerId "1"
                    , randomGifForVideoPlayerId "2"
                    , initSecretConfigTags
                    ]
                )

        InitTags (Err error) ->
            let
                _ =
                    Debug.log "InitTags Failed" error
            in
                ( config, Cmd.none )

        RandomTag videoPlayerId tag ->
            let
                fetchRandomGifMsg =
                    msgRouter.videoPlayerMsg
                        << VideoPlayer.fetchRandomGifMsg videoPlayerId
            in
                ( config
                , tag
                    |> Gif.fetchRandomGif fetchRandomGifMsg config.giphyApiKey
                )

        SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                tags =
                    tagsString
                        |> String.split ", "
                        |> List.map String.trim

                gifDisplaySeconds =
                    gifDisplaySecondsString
                        |> String.toFloat
                        |> Result.map
                            (\seconds ->
                                if seconds < 1 then
                                    config.gifDisplaySeconds
                                else
                                    seconds
                            )
                        |> Result.withDefault config.gifDisplaySeconds

                cmd =
                    if
                        soundCloudPlaylistUrl
                            /= config.soundCloudPlaylistUrl
                    then
                        Task.succeed soundCloudPlaylistUrl
                            |> Task.perform
                                (msgRouter.audioPlayerMsg
                                    << AudioPlayer.reInitAudioPlayerMsg
                                )
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
