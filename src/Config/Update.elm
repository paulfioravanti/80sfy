module Config.Update exposing (ParentMsgs, update)

import AudioPlayer
import Config.Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Ports
import SecretConfig
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , configMsg : Msg -> msg
        , secretConfigMsg : SecretConfig.Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update parentMsgs msg config =
    case msg of
        Msg.TagsFetched (Ok rawTags) ->
            let
                tags : List Tag
                tags =
                    List.map Tag.tag rawTags

                generateRandomTagForVideoPlayer : VideoPlayerId -> Cmd msg
                generateRandomTagForVideoPlayer videoPlayerId =
                    let
                        randomTagGeneratedMsg : Tag -> msg
                        randomTagGeneratedMsg =
                            SecretConfig.randomTagGeneratedMsg
                                parentMsgs.secretConfigMsg
                                videoPlayerId
                    in
                    Tag.generateRandomTag randomTagGeneratedMsg tags

                performInitSecretConfigTags : Cmd msg
                performInitSecretConfigTags =
                    SecretConfig.performInitTags
                        parentMsgs.secretConfigMsg
                        rawTags
            in
            ( { config | tags = tags }
            , Cmd.batch
                [ generateRandomTagForVideoPlayer (VideoPlayer.id "1")
                , generateRandomTagForVideoPlayer (VideoPlayer.id "2")
                , performInitSecretConfigTags
                ]
            )

        Msg.TagsFetched (Err error) ->
            ( config, Ports.logError "Fetching Tags Failed" error )
