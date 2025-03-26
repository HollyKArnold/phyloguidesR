#' Check if mothur is available on the system
#'
#' @return Returns the number of characters of path for mothur
#' @export

is_mothur_available <- function() {
  nzchar(Sys.which("mothur"))
}
