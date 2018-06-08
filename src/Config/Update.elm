module Config.Update exposing (update)

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
import MsgConfig exposing (MsgConfig)
import SecretConfig
import Task
import VideoPlayer


update : MsgConfig msg -> Config.Msg.Msg -> Config -> ( Config, Cmd msg )
update msgConfig msg config =
    case msg of
        GenerateRandomGif videoPlayerId ->
            ( config
            , Gif.random
                (msgConfig.configMsg << RandomTag videoPlayerId)
                config.tags
            )

        InitTags (Ok tags) ->
            let
                randomGifForVideoPlayerId videoPlayerId =
                    Task.succeed videoPlayerId
                        |> Task.perform
                            (msgConfig.configMsg << GenerateRandomGif)

                initSecretConfigTags =
                    Task.succeed tags
                        |> Task.perform
                            (msgConfig.secretConfigMsg
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
                    msgConfig.videoPlayerMsg
                        << VideoPlayer.fetchRandomGifMsg videoPlayerId
            in
                ( config
                , tag
                    |> Gif.fetchRandomGif fetchRandomGifMsg config.giphyApiKey
                )

        SaveConfig soundCloudPlaylistUrl tagsString ->
            let
                tags =
                    tagsString
                        |> String.split ", "
                        |> List.map String.trim
            in
                ( { config
                    | soundCloudPlaylistUrl = soundCloudPlaylistUrl
                    , tags = tags
                  }
                , Cmd.none
                )
