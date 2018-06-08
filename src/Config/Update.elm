module Config.Update exposing (update)

import Config.Model exposing (Config)
import Config.Msg exposing (Msg(FetchTags, RandomTag, SaveConfig))
import Gif
import MsgConfig exposing (MsgConfig)
import SecretConfig.Msg exposing (Msg(InitSecretConfigTags))
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
                        (msgConfig.secretConfigMsg << InitSecretConfigTags)
                ]
            )

        FetchTags (Err error) ->
            let
                _ =
                    Debug.log "FetchTags Failed" error
            in
                ( config, Cmd.none )

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
