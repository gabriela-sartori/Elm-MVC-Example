module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import List exposing (..)
import String exposing (..)

import Model  exposing (..)
import Update exposing (..)

import Utils exposing (..)

view : Address Action -> Model -> Html
view address model =
    case model.page of
        AtHome     -> view_home_form     address model
        AtRegister -> view_register_form address model
        AtAbout    -> view_about_form    address model
        AtLogin ->
            case model.account of
                Just account -> view_logout     address account
                Nothing      -> view_login_form address model        

view_register_form : Address Action -> Model -> Html
view_register_form address model = let onPressEnter = onKeyPress address (\x -> if x == 13 then ActRegister else ActNop) in
    div [] [ h1 [] [ text "Register" ]
           , text "Nome "
           , input [ onInput address ActUpdateRegisterName, value model.register_form.name, onPressEnter, autofocus True ] []
           , br [] []
           , text "Usuário "
           , input [ onInput address ActUpdateRegisterLogin, value model.register_form.login, onPressEnter ] []
           , br [] []
           , text "Senha "
           , input [ onInput address ActUpdateRegisterPass, value model.register_form.password, onPressEnter ] []
           , br [] []
           , br [] []
           , button [ onClick address (ActChangePage AtHome)  ] [ text "Back" ]
           , span [ style [ ("color", "white") ] ] [text " : "]
           , button [ onClick address (ActChangePage AtRegister)  ] [ text "Register" ]
           , br [] []
           , br [] []
           , span [ style [("color", "red")] ] [ text model.message ]
           ]

view_home_form : Address Action -> Model -> Html
view_home_form address model =
    div [] [ h1 [] [ text "Elm Learning : Welcome!" ]
           , text "Please feel like at home :)"
           , br [] []
           , button [ onClick address (ActChangePage AtLogin)  ] [ text "Login" ]
           , br [] []
           , button [ onClick address (ActChangePage AtRegister)  ] [ text "Register" ]
           , br [] []
           , button [ onClick address (ActChangePage AtAbout)  ] [ text "About" ]
           ]

view_about_form : Address Action -> Model -> Html
view_about_form address model =
    div [] [ h1 [] [ text "About" ]
           , text "I am Learning Elm functional language, so to practise I've created this :D"
           , br [] []
           , text "I know, I know that the design sucks, but who cares ? D:"
           , br [] []
           , a [ href "http://www.elm-lang.org", target "_blank" ] [ text "www.elm-lang.org"]
           , br [] []
           , button [ onClick address (ActChangePage AtHome)  ] [ text "Back" ]
           ]

view_login_form : Address Action -> Model -> Html
view_login_form address model = let onPressEnter = onKeyPress address (\x -> if x == 13 then ActLogin else ActNop) in
    div [] [ h1 [] [ text "Login" ]
           , text "Username "
           , input [ onInput address ActUpdateLogin, value model.login, onPressEnter, autofocus True ] []
           , br [] []
           , text "Password "
           , input [ onInput address ActUpdatePass, value model.password, onPressEnter ] []
           , br [] []
           , button [ onClick address (ActChangePage AtHome)  ] [ text "Back" ]
           , span [] [ text " " ]
           , button [ onClick address ActLogin ] [ text "Login" ]
           , br [] []
           , br [] []
           , span [ style [("color", "red")] ] [ text model.message ]
           ]


view_logout : Address Action -> Account -> Html
view_logout address account =
    div [] [ text ("Name: " ++ account.name)
           , br [] []
           , button [ onClick address ActLogout ] [ text "Logout" ]
           ]

