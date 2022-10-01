content <- '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
%s
</urlset>
'

posts <- dir("posts", full.names = TRUE) |>
  (\(x) {grep("[^_].*[^y][^m][^l]$", x, value = TRUE)})()

get_date <- function(x) {
  con <- 
  loop <- function(con_) {
    l <- readLines(con_, n = 1)
    if (length(l) == 0) {
      close(con_)
      stop("Nope.")
    } else if (substr(l, 1, 5) == "date:") {
      res <- strsplit(l, ":")[[1]][2]
      res <- gsub("\\s+", "", res)
      res <- gsub('"', "", res)
      res <- gsub("'", "", res)
      close(con_)
      sprintf("%sT00:00:00+00:00", res)
    } else {
      loop(con_)
    }
  }
  loop(file(sprintf("%s/index.qmd", x), "r"))
}

url <- function(x) {
  sprintf(
    "  <url>\n    <loc>https://cmhh.github.io/%s/</loc>\n    <lastmod>%s</lastmod>\n  </url>",
    x,
    get_date(x)
  )
}

sprintf(
  content,
  paste(sapply(posts, url), collapse = "\n")
) |> writeLines("public/sitemap.xml")

file.copy("google6745018c2acf4b3e.html", "public/google6745018c2acf4b3e.html")
