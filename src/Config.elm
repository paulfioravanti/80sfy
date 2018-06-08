module Config exposing (Config, init, update, updateSettings, setTags)

import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Update as Update
import Flags exposing (Flags)
import MsgConfig exposing (MsgConfig)


type alias Config =
    Model.Config


type alias Msg =
    Msg.Msg


init : Flags -> Config
init flags =
    Model.init flags


setTags : List String -> Config -> Config
setTags tags config =
    { config | tags = tags }


update : MsgConfig msg -> Msg -> Config -> ( Config, Cmd msg )
update msgConfig msg config =
    Update.update msgConfig msg config


updateSettings : String -> String -> Config -> Config
updateSettings soundCloudPlaylistUrl tagsString config =
    let
        tags =
            tagsString
                |> String.split ", "
                |> List.map String.trim
    in
        { config
            | soundCloudPlaylistUrl = soundCloudPlaylistUrl
            , tags = tags
        }
