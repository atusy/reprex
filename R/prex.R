# nocov start

#' Render a "prex"
#'
#' @description
#' `prex()` is like [reprex()], but much less reproducible!
#'   * Code is evaluated in the global environment of the current R session.
#'   * Current working directory is used.
#'   * `advertise = FALSE` is the default.
#' This violates many principles of a true reprex, which is why the `prex()`
#' family of functions is unexported. The main motivation is to make
#' `prex_rtf()` available for preparing code snippets that are scattered around
#' a talk and that can't necessarily be self-contained.
#'
#' @noRd
#' @keywords internal
#'
#' @examples
#' # compare and contrast to get a feel for reprex() vs prex()
#' reprex(ls())     # character(0)
#' prex(ls())       # whatever is lying around your current workspace
#'
#' reprex(search()) # won't reflect anything you attach in .Rprofile
#' prex(search())   # generally does reflect packages attached in .Rprofile
#'
#' reprex(getwd())  # a reprex directory below session temp directory
#' prex(getwd())    # current working directory
prex <- function(x = NULL,
                 input = NULL,
                 outfile = NULL,                # <-- different from reprex
                 venue = c("gh", "r", "rtf", "html", "so", "ds"),

                 render = TRUE,

                 advertise       = FALSE,       # <-- different from reprex
                 session_info    = opt(FALSE),
                 style           = opt(FALSE),
                 html_preview    = opt(TRUE),
                 comment         = opt("#>"),
                 tidyverse_quiet = opt(TRUE),
                 std_out_err     = opt(FALSE),
                 show) {
  if (!missing(show)) {
    html_preview <- show
    warning(
      "`show` is deprecated, please use `html_preview` instead",
      immediate. = TRUE, call. = FALSE
    )
  }

  reprex_impl(
    x_expr = substitute(x),
    input = input, outfile = outfile,
    venue = venue,

    render = render,
    new_session = FALSE,                        # <-- different from reprex()

    advertise       = advertise,
    session_info    = session_info,
    style           = style,
    comment         = comment,
    tidyverse_quiet = tidyverse_quiet,
    std_out_err     = std_out_err,
    html_preview    = html_preview
  )
}

prex_html <- function(...) prex(..., venue = "html")
prex_r    <- function(...) prex(..., venue = "r")
prex_rtf  <- function(...) prex(..., venue = "rtf")

# these should exist for completeness, but I predict they'd never get used and
# they just clutter the auto-complete landscape
# prex_gh   <- function(...) prex(..., venue = "gh")
# prex_so   <- function(...) prex(..., venue = "so")
# prex_ds   <- function(...) prex(..., venue = "ds")

# nocov end
