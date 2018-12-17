module ArchitectedHello exposing (Model, Msg(..), main, model, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- This what the model should look like


type alias Model =
    { text : String
    , size : Int
    }


model : Model
model =
    Model "Hello world" 1


type Msg
    = Text
    | SizeUp
    | SizeDown
    | RemoveExclamationremoveExclamation



-- Update function only has to worry about one pissible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text ->
            { model | text = model.text ++ "!" }

        RemoveExclamationremoveExclamation ->
            { model | text = removeExclamation model.text }

        SizeUp ->
            { model | size = model.size + 1 }

        SizeDown ->
            { model | size = decreaseSize model.size }


removeExclamation : String -> String
removeExclamation text =
    if String.length text > 11 then
        String.dropRight 1 text

    else
        text


decreaseSize : Int -> Int
decreaseSize size =
    if size > 1 then
        size - 1

    else
        size


myStyle : Int -> Attribute msg
myStyle size =
    style
        [ ( "font-size", toString size ++ "em" )
        , ( "color", "teal" )
        ]



-- View


view : Model -> Html Msg
view model =
    div []
        [ p [ myStyle model.size ] [ text model.text ]
        , button [ onClick Text ] [ text "Add exclamation mark" ]
        , button [ onClick RemoveExclamationremoveExclamation ] [ text "Remove exclamation mark" ]
        , button [ onClick SizeUp ] [ text "+" ]
        , button [ onClick SizeDown ] [ text "-" ]
        ]
