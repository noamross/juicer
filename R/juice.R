#' In-line CSS styles
#'
#' This function an HTML file with \code{<style>} tags an in-lines the styles.
#' It does not currently in-line styles from external files or resources automatically,
#' though styles may be applied with the \code{css=} argument or \code{options=list(extraCss=)}
#'
#' \code{html} or \code{css} may be provided as vectors, which will be recycled.
#'
#' @param html HTML as a string, or a file or URL
#' @param options A list of options to pass to juice.  See \url{https://github.com/Automattic/juice#options} for
#' @param css (Optional) CSS to apply to the file, as a string, file or URL.  If provided, ONLY this CSS will be inlined.  If you wish to pass \emph{additional} CSS in addition to that in \code{<style>} tags in your HTML, provide it as a string named \code{extraCss=} in the \code{options} parameter.
#' @return A string of HTML with styles in-lined
#' @import V8
#' @export
#'
#' @examples
#' some_html = "<style>a {font-size:30;}</style><a href='http://www.ropensci.org'>ROpenSci</a>"
#' juice(some_html)
#' # Don't apply style tags, but remove them
#' juice(some_html, options=list(applyStyleTags=FALSE, removeStyleTags=TRUE))
juice <- function(html, options = NULL, css = NULL) {
  if (!is.character(html))
    stop("'html' must be a character vector of html text, a filenames, or urls")

  if (length(html) > 1 & is.null(css)) {
    out <- unlist(Map(function(html) juice(html, options, css), html))
    names(out) <- names(html)
    return(out)
  } else if(length(html) > 1 & !is.null(css)) {
    out <- unlist(Map(function(html, css) juice(html, options, css), html, css))
    names(out) <- names(html)
    return(out)
  }

  html = read(html)
  ct = new_context()
  ct$source(system.file("juicer.js", package = "juicer"))
  ct$assign("html_text", html)
  ct$assign("options", options)

  if (!is.null(css)) {
    css = read(css)
    ct$assign("css_text", css)
    ct$eval("var juiced = juice.inlineContent(html_text, css_text, options);")
  } else {
    ct$eval("var juiced = juice(html_text, options);")
  }

  ct$get("juiced")
}

#' @import httr
read <- function(x) {
  if (file.exists(x)) {
    readChar(x, file.info(x)$size)
  } else if (!is.null(httr::parse_url(x)$scheme) &&
             identical(httr::status_code(httr::HEAD(x)), 200L)) {
    res <- httr::GET(x)
    httr::stop_for_status(res)
    httr::content(res, "text")
  } else {
    x
  }
}
