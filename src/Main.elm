module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Model =
    { name : String
    }


init : String -> ( Model, Cmd Msg )
init name =
    ( { name = name }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Name String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Name string ->
            ( { model | name = string }, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { body = [ div [] [ text model.name ] ]
    , title = "Test"
    }
