#' Convience wrapper function for mothur's filter.seqs() command. This function filters the
#' alignment file to remove any columns that are only gap (-) or dot (.)
#' characters. Note that the filter function produces a postfix of .filter.fasta from a
#' .fasta file input.
#'
#' @param fasta_path A multi sequence alignment file on which to perform filtration.
#'
#' @return Returns the path to the filtered alignment file.
#' @export
#'
filter_seqs_mothur = function(fasta_path){

  # Check the file exists
  if(!file.exists(fasta_path)){
    message = paste0(c("The path for the alignment file does not exist at: ",
                       fasta_path,
                     sep = "", collapse = ""))
    stop(message)
  }


  cmd = paste0(c("mothur ",
                 "\"#filter.seqs(fasta=",
                 fasta_path,
                 ", vertical = T)\""),
               sep = "", collapse = "")


  # Make sure withr is available the suggested package is required
  if (!requireNamespace("withr", quietly = TRUE)) {
    stop(
      "Package \"withr\" must be installed to use this function.",
      call. = FALSE
    )
  }

  if (is_mothur_available()) {
    withr::with_dir(new = dirname(fasta_path), system(cmd))
  } else {
    stop("mothur is not installed or not in PATH.")
  }
  filter_path =
    sub(fasta_path,
        pattern = ".align$",
        replacement = ".filter.fasta")

  # Check that the file exists
  if(!file.exists(filter_path)){
    stop("The filtered alignment file was not produced.")
  }else{
    return(filter_path)
  }

}
