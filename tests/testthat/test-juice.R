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
