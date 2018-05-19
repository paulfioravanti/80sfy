module Main exposing (main)

import Html exposing (Html, text, div, h1, img, p, video)
import Html.Attributes exposing (property, src, style)
import Http exposing (Error)
import Json.Decode as Decode
import Json.Encode as Encode
import Random
import RemoteData exposing (RemoteData(..), WebData)
import Time exposing (Time)


tags : List String
tags =
    [ "80s"
    , "1980"
    , "80s art"
    , "80s animation"
    , "80s tv"
    , "80s food"
    , "80s movie"
    , "80s music"
    , "80s miami"
    , "80s fashion"
    , "80s scifi"
    , "80s anime"
    , "80s video games"
    , "80s video"
    , "vhs"
    , "synthwave"
    , "tron"
    , "grid"
    , "nes"
    , "8bit"
    , "pixel"
    , "neon"
    , "geometry"
    , "kidmograph"
    ]



---- MODEL ----


type alias Model =
    { gifUrl : WebData String
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { gifUrl = NotRequested }
    in
        ( { model | gifUrl = Requesting }
        , (List.length tags - 1)
            |> Random.int 1
            |> Random.generate RandomTagIndex
        )



---- COMMANDS ----


fetchRandomGif : String -> Cmd Msg
fetchRandomGif tag =
    let
        host =
            "https://api.giphy.com"

        path =
            "/v1/gifs/random"

        apiKey =
            "api_key=JASRREAAILxOCCf0awYF89DVBaH2BPl3"

        url =
            host
                ++ path
                ++ "?"
                ++ apiKey
                ++ "&tag="
                ++ tag
    in
        decodeGifUrl
            |> Http.get url
            |> Http.send GetRandomGif



---- DECODERS ----


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_mp4_url" ] Decode.string



---- UPDATE ----


type Msg
    = GetRandomGif (Result Error String)
    | GetNextGif Time
    | RandomTagIndex Int
    | UpdatePage Model
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetNextGif time ->
            ( model
            , (List.length tags - 1)
                |> Random.int 1
                |> Random.generate RandomTagIndex
            )

        GetRandomGif (Ok imageUrl) ->
            ( { model | gifUrl = Success imageUrl }, Cmd.none )

        GetRandomGif (Err error) ->
            ( model, Cmd.none )

        RandomTagIndex index ->
            ( model
            , tags
                |> List.drop index
                |> List.head
                |> Maybe.withDefault "80s"
                |> fetchRandomGif
            )

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    gif model.gifUrl


gif : WebData String -> Html Msg
gif gifUrl =
    case gifUrl of
        NotRequested ->
            p [] [ text "" ]

        Requesting ->
            p [] [ text "Getting gif..." ]

        Success gifUrl ->
            video
                [ src gifUrl
                , style
                    [ ( "height", "100%" )
                    , ( "maxWidth", "100%" )
                    , ( "width", "100%" )
                    , ( "margin", "0 auto" )
                    ]
                , property "autoplay" (Encode.string "true")
                , property "loop" (Encode.string "true")
                ]
                []

        _ ->
            p [] [ text "Something went wrong" ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (7 * Time.second) GetNextGif



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
