module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Note
import Task
import Time


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
    , zone : Time.Zone
    , notes : List Note.Note
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init =
    always
        ( { name = "Test"
          , zone = Time.utc
          , notes =
                [ { title = "My First Note"
                  , content = "This is a test!"
                  , id = "1"
                  , timeCreated = Time.millisToPosix 1570748096610
                  }
                ]
          }
        , Task.perform AdjustTimeZone Time.here
        )



-- UPDATE


type Msg
    = AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustTimeZone newZone ->
            ( { model | zone = newZone }, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { body = [ div [] (List.map (Note.view model.zone) model.notes) ]
    , title = "notorious"
    }
