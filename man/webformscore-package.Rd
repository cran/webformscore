\docType{package}
\name{webformscore-package}
\alias{webformscore}
\alias{webformscore-package}
\alias{WebForms}
\alias{Security}
\alias{InputPlace}
\alias{OutputPlace}
\alias{Fetch}
\alias{HtmlEvent}
\alias{HtmlEventListener}
\alias{WasmLanguage}
\alias{GS}
\alias{US}
\alias{RS}
\alias{NUL}
\alias{ext_child}
\alias{ext_parent}
\alias{ext_criteria}
\alias{ext_append_fetch_replace}
\alias{ext_line_break}
\alias{ext_to_js_string}
\alias{ext_to_js_object}
\alias{ext_to_js_return_object}
\title{WebForms Core for R}
\description{
  An R implementation of the server-side part of WebForms Core, a
  stateless server-driven user interface technology for building web
  interfaces through server-side UI manipulation. The server-side class
  acts as a Commander that generates commands, while WebFormsJS serves as
  the client-side Executor that applies them. Commands range from atomic
  operations, such as adding elements and modifying text and attributes,
  to higher-level operations such as iterative processing and render.
}
\usage{
GS
US
RS
NUL

InputPlace
OutputPlace
Fetch
HtmlEvent
HtmlEventListener
WasmLanguage

ext_child(text, value)
ext_parent(text)
ext_criteria(text, value)
ext_append_fetch_replace(text, searchValue, value)
ext_line_break(text, encodeLine = FALSE)
ext_to_js_string(text)
ext_to_js_object(text)
ext_to_js_return_object(text)
}
\arguments{
  \item{text}{A character string.}
  \item{value}{A character string appended or substituted according to
    the function.}
  \item{searchValue}{A character string to search for.}
  \item{encodeLine}{Logical. When \code{TRUE}, line breaks are replaced
    by \code{"$[sln];"}.}
}
\value{
  \describe{
    \item{\code{WebForms}}{An R6 class generator. Calling
      \code{WebForms$new()} returns a new \code{WebForms} object, the
      main Command builder.}
    \item{\code{Security}}{An R6 class generator. Calling
      \code{Security$new()} returns a new \code{Security} object with
      the method \code{safe_value()}.}
    \item{\code{GS}, \code{US}, \code{RS}, \code{NUL}}{Single-character
      strings. \code{GS} is ASCII 29 (group separator), \code{RS} is
      ASCII 30 (record separator), \code{US} is ASCII 31 (unit
      separator), and \code{NUL} is ASCII 0 (null character).}
    \item{\code{InputPlace}, \code{OutputPlace}}{A named list of
      constants and helper functions for building WebForms Place
      Criteria (WPC) strings. \code{OutputPlace} is an alias of
      \code{InputPlace}.}
    \item{\code{Fetch}}{A named list of helpers for reading client-side
      values or embedding dynamic values in commands.}
    \item{\code{HtmlEvent}, \code{HtmlEventListener}}{Named lists of
      HTML event attribute names (with the \code{on} prefix) and event
      listener names (without the \code{on} prefix).}
    \item{\code{WasmLanguage}}{A named list of WebAssembly language
      identifiers.}
    \item{\code{ext_*}}{Each returns a character string.}
  }
}
\details{
  \subsection{Commander and Executor}{
    The package implements the server side of WebForms Core. A
    \code{WebForms} object accumulates commands. The result is sent to
    the browser using \code{response()},
    \code{export_to_html_comment()}, or \code{export_to_line_break()},
    where WebFormsJS applies the commands to the DOM.
  }

  \subsection{The \code{WebForms} class}{
    Create an instance with \code{WebForms$new()} and call its public
    methods to append commands. The main families of methods are:
    \itemize{
      \item \strong{Buffer}: \code{add()}, \code{add_to_up()},
        \code{get_web_forms_data()}, \code{append_form()},
        \code{clean()}, \code{get_line_by_index()},
        \code{update_line_by_index()}.
      \item \strong{Add helpers} (append to existing value):
        \code{add_id()}, \code{add_name()}, \code{add_value()},
        \code{add_class()}, \code{add_style()}, \code{add_attribute()},
        \code{add_text()}, \code{add_tag()}, \code{add_option_tag()},
        \code{add_check_box_tag()}, and others.
      \item \strong{Set helpers} (replace existing value):
        \code{set_id()}, \code{set_name()}, \code{set_value()},
        \code{set_class()}, \code{set_style()}, \code{set_text()},
        \code{set_attribute()}, \code{set_background_color()},
        \code{set_text_color()}, \code{set_font_size()},
        \code{set_visible()}, \code{set_disabled()}, and others.
      \item \strong{Insert helpers} (create only, never replace):
        \code{insert_id()}, \code{insert_name()}, \code{insert_value()},
        \code{insert_class()}, \code{insert_style()},
        \code{insert_text()}, \code{insert_attribute()}, and others.
      \item \strong{Delete}: \code{delete()}, \code{delete_parent()},
        \code{delete_id()}, \code{delete_name()}, \code{delete_value()},
        \code{delete_class()}, \code{delete_style()},
        \code{delete_attribute()}, and others.
      \item \strong{Events}: \code{set_post_event()},
        \code{set_post_event_listener()}, \code{set_get_event()},
        \code{set_put_event()}, \code{set_patch_event()},
        \code{set_delete_event()}, \code{set_send_event()},
        \code{set_comment_event()}, \code{set_sse_event()},
        \code{set_web_socket_event()}, \code{set_wasm_event()},
        \code{set_front_event()}, \code{set_method_event()},
        \code{assign_confirm_event()}, \code{trigger_event()}, and
        matching \code{remove_*_event()} methods.
      \item \strong{Flow control}: \code{start_index()},
        \code{start_state()}, \code{go_to()}, \code{is_equal_to()},
        \code{is_not_equal_to()}, \code{is_greater_than()},
        \code{is_less_than()}, \code{exist()}, \code{not_exist()},
        \code{is_true()}, \code{is_false()}, \code{include()},
        \code{not_include()}, \code{element_exists()},
        \code{for_each()}, \code{then()}, \code{else_()},
        \code{start_bracket()}, \code{end_bracket()}, \code{break_()},
        \code{repeat_()}, \code{isole()}, \code{render()},
        \code{async()}, \code{delay()}.
      \item \strong{Save and cache}: \code{save_id()},
        \code{save_value()}, \code{save_text()}, \code{cache_id()},
        \code{cache_value()}, \code{cache_text()}, and the
        \code{set_*_save_value()} / \code{set_*_cache_value()} family.
      \item \strong{Pre-runner modifiers}: \code{assign_delay()},
        \code{assign_interval()}, \code{assign_repeat()},
        \code{delete_interval()}.
      \item \strong{Browser}: \code{change_url()},
        \code{set_head_title()}, \code{clipboard_write_text()},
        \code{scroll_to()}, \code{history_go()}, \code{reload_page()},
        \code{redirect()}.
      \item \strong{Call and message}: \code{load_url()},
        \code{call_script()}, \code{call_method()},
        \code{call_post_back()}, \code{call_get_back()},
        \code{call_sse_back()}, \code{alert()}, \code{message()},
        \code{console_message()}, \code{create_debugger()},
        \code{comment()}.
      \item \strong{Output}: \code{response()},
        \code{get_forms_action_data()},
        \code{get_forms_action_data_line_break()},
        \code{export_to_html_comment()},
        \code{export_to_line_break()}.
    }
  }

  \subsection{The \code{Security} class}{
    \code{Security$new()} creates an object with a single public method
    \code{safe_value(value)} that prepares a string for embedding in a
    command: it escapes a leading \code{"@"} to prevent command forgery,
    replaces newlines with \code{"$[ln];"}, replaces \code{",@"} with
    \code{"$[co];@"}, and strips ASCII control characters 28--31.
  }

  \subsection{Separator constants}{
    \code{GS} separates fields inside one command. \code{US} joins list
    items inside one field. \code{RS} is used by \code{Fetch} helpers.
    \code{NUL} is the default \code{splitter} argument of
    \code{add_attribute()} and \code{insert_attribute()}.
  }

  \subsection{Place criteria}{
    \code{InputPlace} contains both constants (such as
    \code{document}, \code{window}, \code{html}, \code{head},
    \code{parent}, \code{current}, \code{target}) and helper functions
    (such as \code{id()}, \code{name()}, \code{tag()}, \code{class()},
    \code{attribute()}, \code{query()}). \code{OutputPlace} is a direct
    alias.
  }

  \subsection{Fetch helpers}{
    \code{Fetch} provides access to client-side values (for example
    \code{get_value()}, \code{get_text()}, \code{get_attribute()}), to
    the browser environment (such as \code{href}, \code{scroll_x},
    \code{user_agent}, \code{screen_width}), to the current event (such
    as \code{event}, \code{event_key}, \code{event_client_x}), and to
    the save and cache storage (\code{save()}, \code{cache()}).
  }

  \subsection{Extension helpers}{
    \code{ext_child()}, \code{ext_parent()}, \code{ext_criteria()},
    \code{ext_append_fetch_replace()}, \code{ext_line_break()},
    \code{ext_to_js_string()}, \code{ext_to_js_object()}, and
    \code{ext_to_js_return_object()} mirror the extension methods used
    by the Commander API in other languages.
  }
}
\examples{
# Build a simple command payload without starting an HTTP server.
form <- WebForms$new()

form$set_font_size("<form>", 16)
form$set_background_color("<form>", "lightblue")
form$add_tag("<form>", "h3")
form$set_text("<h3>", "Welcome!")

cat(form$response())

# Separator constants.
GS
US
RS
nchar(NUL)

# Place criteria helpers.
InputPlace$id("my-id")
InputPlace$tag("div")
OutputPlace$class("active")

# Fetch helpers.
Fetch$get_value("<select>")
Fetch$date_hours

# Security helper.
sec <- Security$new()
sec$safe_value("line1")
sec$safe_value("@not-a-fetch-command")

# Extension helpers.
ext_child("a", "b")
ext_parent("a|b")
ext_line_break("a\r\nb", TRUE)
ext_to_js_string("value")
}
\seealso{
  Useful links:
  \itemize{
    \item \url{https://github.com/webforms-core}
  }
}
\keyword{package}