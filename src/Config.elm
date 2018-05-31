module Config exposing (Config, init, updateSettings, setTags)

import Config.Model as Model exposing (Config)
import Flags exposing (Flags)
import Tag exposing (Tags)


type alias Config =
    Model.Config


init : Flags -> Config
init flags =
    Model.init flags


setTags : Tags -> Config -> Config
setTags tags config =
    { config | tags = tags }


updateSettings : String -> String -> Config -> Config
updateSettings soundCloudPlaylistUrl tagsString config =
    let
        tags =
            tagsString
                |> String.split ", "
                |> List.map String.trim
    in
        { config | soundCloudPlaylistUrl = soundCloudPlaylistUrl, tags = tags }
