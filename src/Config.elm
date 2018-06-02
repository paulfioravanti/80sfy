module Config exposing (Config, init, updateSettings, setTags)

import Config.Model as Model exposing (Config)
import Flags exposing (Flags)
import SecretConfig exposing (SecretConfig)


type alias Config =
    Model.Config


init : Flags -> Config
init flags =
    Model.init flags


setTags : List String -> Config -> Config
setTags tags config =
    { config | tags = tags }


updateSettings : SecretConfig -> Config -> Config
updateSettings { soundCloudPlaylistUrl, tags } config =
    let
        tagList =
            tags
                |> String.split ", "
                |> List.map String.trim
    in
        { config
            | soundCloudPlaylistUrl = soundCloudPlaylistUrl
            , tags = tagList
        }
