module Config exposing (Config, init, updateSettings, setTags)

import Config.Model as Model exposing (Config)
import Flags exposing (Flags)
import SecretConfig exposing (SecretConfig)
import Tag exposing (Tags)


type alias Config =
    Model.Config


init : Flags -> Config
init flags =
    Model.init flags


setTags : Tags -> Config -> Config
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
