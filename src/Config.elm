module Config exposing
    ( Config
    , Msg
    , generateRandomGifMsg
    , init
    , initTagsMsg
    , saveConfigMsg
    , update
    )

import AudioPlayer
import Config.Model as Model exposing (Config)
import Config.Msg as Msg
import Config.Update as Update
import Flags exposing (Flags)
import Http exposing (Error)
import SecretConfig
import VideoPlayer


type alias Config =
    Model.Config


type alias Msg =
    Msg.Msg


init : Flags -> Config
init flags =
    Model.init flags


initTagsMsg : Result Error (List String) -> Msg.Msg
initTagsMsg =
    Msg.InitTags


generateRandomGifMsg : String -> Msg
generateRandomGifMsg =
    Msg.GenerateRandomGif


saveConfigMsg : String -> String -> String -> Msg
saveConfigMsg =
    Msg.SaveConfig


update :
    (AudioPlayer.Msg -> msg)
    -> (Msg -> msg)
    -> (SecretConfig.Msg -> msg)
    -> (VideoPlayer.Msg -> msg)
    -> Msg
    -> Config
    -> ( Config, Cmd msg )
update audioPlayerMsg configMsg secretConfigMsg videoPlayerMsg msg config =
    Update.update
        audioPlayerMsg
        configMsg
        secretConfigMsg
        videoPlayerMsg
        msg
        config
