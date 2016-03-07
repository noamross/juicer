context("juice")

text_html = "<style>a {font-size:30;}</style><a href=\"http://www.ropensci.org\">ROpenSci</a>"
text_css = "a {font-size:30;}"

test_that("juice works", {
  expect_equal(juice(text_html), "<a href=\"http://www.ropensci.org\" style=\"font-size: 30;\">ROpenSci</a>")
  expect_equal(juice(text_html, css=text_css),
               "<style>a {font-size:30;}</style><a href=\"http://www.ropensci.org\" style=\"font-size: 30;\">ROpenSci</a>")
  expect_equal(juice(text_html, options=list(applyStyleTags=FALSE)), "<a href=\"http://www.ropensci.org\">ROpenSci</a>")
  expect_equal(juice(text_html, options=list(applyStyleTags=FALSE, removeStyleTags=FALSE)), text_html)
})

test_that("Multiple inputs", {
  expect_equal(juice(c(text_html, text_html)),
               rep("<a href=\"http://www.ropensci.org\" style=\"font-size: 30;\">ROpenSci</a>", 2))
  expect_equal(juice(c(text_html, text_html), css=text_css),
               rep("<style>a {font-size:30;}</style><a href=\"http://www.ropensci.org\" style=\"font-size: 30;\">ROpenSci</a>", 2))
})

test_that("Expected failures", {
  expect_error(juice(1), "'html' must be a character vector of html text, a filenames, or urls")
})