module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { name : String
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init =
    always
        ( { name = "Test" }
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
