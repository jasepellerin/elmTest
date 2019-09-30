module Note exposing (Model, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



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
