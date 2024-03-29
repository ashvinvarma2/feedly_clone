// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CategoryFormController from "./category_form_controller"
application.register("category-form", CategoryFormController)

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)

import ErrorHandlerController from "./error_handler_controller"
application.register("error-handler", ErrorHandlerController)

import FeedActionsController from "./feed_actions_controller"
application.register("feed-actions", FeedActionsController)

import FeedModalController from "./feed_modal_controller"
application.register("feed-modal", FeedModalController)

import GeneralController from "./general_controller"
application.register("general", GeneralController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ThemeSwitcherController from "./theme_switcher_controller"
application.register("theme-switcher", ThemeSwitcherController)

import TopicController from "./topic_controller"
application.register("topic", TopicController)

import ViewSwitcherController from "./view_switcher_controller"
application.register("view-switcher", ViewSwitcherController)
