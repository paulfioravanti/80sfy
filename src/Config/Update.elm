module Config.Update exposing (update)

import Config.Model exposing (Config)
import Config.Msg
    exposing
        ( Msg
            ( FetchTags
            , GenerateRandomGif
            , RandomTag
            , SaveConfig
            )
        )
import Debug
import Gif
import MsgConfig exposing (MsgConfig)
import SecretConfig
import Tag
import Task


update : MsgConfig msg -> Config.Msg.Msg -> Config -> ( Config, Cmd msg )
update msgConfig msg config =
    case msg of
        FetchTags (Ok tags) ->
            ( { config | tags = tags }
            , Cmd.batch
                [ Gif.random msgConfig tags "1"
                , Gif.random msgConfig tags "2"
                , Task.succeed tags
                    |> Task.perform
                        (msgConfig.secretConfigMsg
                            << SecretConfig.initSecretConfigTagsMsg
                        )
                ]
            )

        FetchTags (Err error) ->
            let
                _ =
                    Debug.log "FetchTags Failed" error
            in
                ( config, Cmd.none )

        GenerateRandomGif videoPlayerId ->
            ( config, Tag.random msgConfig config.tags videoPlayerId )

        RandomTag videoPlayerId tag ->
            ( config
            , tag
                |> Gif.fetchRandomGif msgConfig config.giphyApiKey videoPlayerId
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
