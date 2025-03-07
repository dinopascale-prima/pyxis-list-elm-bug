module Main exposing (main)

import Browser
import Html exposing (Html, div, hr, li, p, text, ul)
import Html.Attributes exposing (class)
import Msg exposing (Msg(..))
import Pyxis.Components.List as PyxisList
import Pyxis.Components.Title as Title
import Pyxis.Tokens.TitleSize as TitleSize


main : Program () Int Msg
main =
    Browser.sandbox { init = 0, update = update, view = view }


update : Msg -> number -> number
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view : Int -> Html Msg
view model =
    div [] [ content model ]


content : Int -> Html Msg
content _ =
    div []
        [ buggedComponent
        , hr [ class "margin-v-l" ] []
        , Title.config (text "Description of the bug") |> Title.withSize TitleSize.tokenL |> Title.render
        , p [ class "margin-b-l" ] [ text "When using a specific configuration of config values for the List.dl component we get an unexpected behaviour with title and text font size and line height being one bigger than the other" ]
        , Title.config (text "Steps to reproduce") |> Title.withSize TitleSize.tokenL |> Title.render
        , ul []
            [ li [] [ text "Use PyxisList.dl" ]
            , li [] [ text "Set orientation inline" ]
            , li [] [ text "Set item orientation inline" ]
            , li [] [ text "Set emphasis text" ]
            ]
        , Title.config (text "Expected Behaviour") |> Title.withSize TitleSize.tokenL |> Title.render
        , ul []
            [ li [] [ text "Title and text should have same font size and line height" ]
            ]
        , Title.config (text "Actual Behaviour") |> Title.withSize TitleSize.tokenL |> Title.render
        , ul []
            [ li [] [ text "Text has bigger font size and line height than title" ]
            ]
        ]


buggedComponent : Html msg
buggedComponent =
    let
        item title text =
            PyxisList.item
                |> PyxisList.withItemTitle title
                |> PyxisList.withItemText (Html.text text)
                |> PyxisList.withItemAddonNone

        items =
            [ item "First item" "This is the first item"
            , item "Second item" "This is the second item"
            , item "Third item" "This is the third item"
            , item "Fourth item" "This is the fourth item"
            ]
    in
    PyxisList.dl
        |> PyxisList.withSize PyxisList.sizeS
        |> PyxisList.withOrientation PyxisList.inline
        |> PyxisList.withEmphasis PyxisList.emphasisText
        |> PyxisList.withItems items
        |> PyxisList.withItemOrientation PyxisList.itemOrientationInline
        |> PyxisList.render
