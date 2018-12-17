module UserInput exposing (Model, Msg(..), main, model)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, update = update, view = view }


type alias Model =
    { text : String }


model : Model
model =
    Model ""


type Msg
    = Text String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text txt ->
            { model | text = txt }


adjustSize : Model -> Attribute Msg
adjustSize { text } =
    let
        ( size, color ) =
            if String.length text < 8 then
                ( "10em", "goldenrod" )

            else
                ( "5em", "red" )
    in
    style
        [ ( "font-size", size )
        , ( "color", color )
        , ( "font-family", "verdana" )
        ]


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Type text hele", onInput Text ] []
        , div []
            [ p [ adjustSize model ] [ text model.text ]
            ]
        ]
