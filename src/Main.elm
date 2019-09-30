module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    }


init : Model
init =
    Model ""



-- UPDATE


type Msg
    = Name String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name string ->
            { model | name = string }



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ text "hi" ]
