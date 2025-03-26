#' Write a fasta file from a sequence key
#'
#' @param file Path to file to write out.
#' @param seqkey A sequence key
#'
#' @return Returns the file path to the sequence key
#' @export
#'

sequence_key_to_fasta <- function(file, seqkey) {
  if (!all(c("KEY", "ASV") %in% colnames(seqkey))) {
    stop("`seqkey` must contain columns 'KEY' and 'ASV'")
  }

  lines <- character(nrow(seqkey) * 2)
  for (i in 1:nrow(seqkey)) {
    lines[(2*i)-1] <- paste0(">", seqkey[i, "KEY"])
    lines[2*i]     <- as.character(seqkey[i, "ASV"])
  }

  writeLines(lines, con = file)
  return(file)
}
