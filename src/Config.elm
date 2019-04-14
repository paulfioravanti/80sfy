module Config exposing
    ( Config
    , Msg
    , init
    , initTagsMsg
    , randomTagGeneratedMsg
    , saveMsg
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


randomTagGeneratedMsg : String -> String -> Msg
randomTagGeneratedMsg =
    Msg.RandomTagGenerated


saveMsg : String -> String -> String -> Msg
saveMsg =
    Msg.Save


update :
    (AudioPlayer.Msg -> msg)
    -> (String -> msg)
    -> (SecretConfig.Msg -> msg)
    -> (VideoPlayer.Msg -> msg)
    -> Msg
    -> Config
    -> ( Config, Cmd msg )
update audioPlayerMsg generateRandomGifMsg secretConfigMsg videoPlayerMsg msg config =
    Update.update
        audioPlayerMsg
        generateRandomGifMsg
        secretConfigMsg
        videoPlayerMsg
        msg
        config
