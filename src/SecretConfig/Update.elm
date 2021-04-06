module SecretConfig.Update exposing (ParentMsgs, update)

import AudioPlayer
import Gif
import Http exposing (Error)
import Ports
import SecretConfig.Model as Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , secretConfigMsg : Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> SecretConfig -> ( SecretConfig, Cmd msg )
update parentMsgs msg secretConfig =
    case msg of
        Msg.RandomTagGenerated videoPlayerId tag ->
            let
                randomGifUrlFetchedMsg : Result Error String -> msg
                randomGifUrlFetchedMsg =
                    VideoPlayer.randomGifUrlFetchedMsg
                        parentMsgs.videoPlayerMsg
                        videoPlayerId

                fetchRandomGifUrl : Cmd msg
                fetchRandomGifUrl =
                    Gif.fetchRandomGifUrl
                        randomGifUrlFetchedMsg
                        secretConfig.giphyApiKey
                        tag
            in
            ( secretConfig, fetchRandomGifUrl )

        Msg.Save ->
            let
                ( gifDisplayIntervalSeconds, gifDisplayIntervalSecondsField ) =
                    Model.validateGifDisplayIntervalSeconds
                        secretConfig.gifDisplayIntervalSeconds
                        secretConfig.gifDisplayIntervalSecondsField

                ( soundCloudPlaylistUrl, soundCloudPlaylistUrlField ) =
                    Model.validateSoundCloudPlaylistUrl
                        secretConfig.soundCloudPlaylistUrl
                        secretConfig.soundCloudPlaylistUrlField

                ( tags, tagsField ) =
                    Model.validateTags secretConfig.tags secretConfig.tagsField

                cmd : Cmd msg
                cmd =
                    if
                        soundCloudPlaylistUrl
                            == secretConfig.soundCloudPlaylistUrl
                    then
                        Cmd.none

                    else
                        AudioPlayer.performAudioPlayerReset
                            parentMsgs.audioPlayerMsg
                            soundCloudPlaylistUrl
            in
            ( { secretConfig
                | gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
                , gifDisplayIntervalSecondsField = gifDisplayIntervalSecondsField
                , soundCloudPlaylistUrl = soundCloudPlaylistUrl
                , soundCloudPlaylistUrlField = soundCloudPlaylistUrlField
                , tags = tags
                , tagsField = tagsField
              }
            , cmd
            )

        Msg.TagsFetched (Ok rawTags) ->
            let
                tags : List Tag
                tags =
                    Tag.stringTagsToTagList rawTags

                tagsField : String
                tagsField =
                    Tag.stringTagsToString rawTags

                generateRandomTagForVideoPlayer : VideoPlayerId -> Cmd msg
                generateRandomTagForVideoPlayer videoPlayerId =
                    let
                        randomTagGeneratedMsg : Tag -> msg
                        randomTagGeneratedMsg =
                            Msg.randomTagGenerated
                                parentMsgs.secretConfigMsg
                                videoPlayerId
                    in
                    Tag.generateRandomTag randomTagGeneratedMsg tags
            in
            ( { secretConfig | tags = tags, tagsField = tagsField }
            , Cmd.batch
                [ generateRandomTagForVideoPlayer (VideoPlayer.id "1")
                , generateRandomTagForVideoPlayer (VideoPlayer.id "2")
                ]
            )

        Msg.TagsFetched (Err error) ->
            ( secretConfig, Ports.logError "Fetching Tags Failed" error )

        Msg.ToggleInactivityPauseOverride ->
            let
                toggledOverrideInactivityPause : Bool
                toggledOverrideInactivityPause =
                    not secretConfig.overrideInactivityPause
            in
            ( { secretConfig
                | overrideInactivityPause = toggledOverrideInactivityPause
              }
            , Cmd.none
            )

        Msg.ToggleVisibility ->
            ( { secretConfig | visible = not secretConfig.visible }
            , Cmd.none
            )

        Msg.UpdateGifDisplaySecondsField rawGifDisplayIntervalSeconds ->
            ( { secretConfig
                | gifDisplayIntervalSecondsField = rawGifDisplayIntervalSeconds
              }
            , Cmd.none
            )

        Msg.UpdateSoundCloudPlaylistUrlField rawSoundCloudPlaylistUrl ->
            ( { secretConfig
                | soundCloudPlaylistUrlField = rawSoundCloudPlaylistUrl
              }
            , Cmd.none
            )

        Msg.UpdateTagsField rawTags ->
            ( { secretConfig | tagsField = rawTags }
            , Cmd.none
            )
