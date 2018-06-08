module Config.Update exposing (update)

import Config.Model exposing (Config)
import Config.Msg exposing (Msg(SaveConfig))


update : Msg -> Config -> ( Config, Cmd msg )
update msg config =
    case msg of
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
