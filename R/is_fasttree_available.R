#' Check if fasttree is available on the system
#'
#' @return Returns the number of characters of path for FastTree
#' @export

is_fasttree_available <- function() {
  nzchar(Sys.which("FastTree"))
}
