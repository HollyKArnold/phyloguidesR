#'
#' Removes sequences which are blow the min.seq.length, which likely have poor quality alignments.
#'
#' This function screens sequences that are less than the minimum sequence
#' length using mothur's screen.seqs() command. Note the screen.seqs() produces a ".good.fasta" file.
#'
#' @param align_path A path to the alignemnt file to screen.
#' @param min_seq_length The minimum sequence length to pass to screen.seqs().
#' Default is 100 basepairs.
#'
#' @return Returns the path to the prepared alignment file.
#' @export
screen_seqs_mothur = function(align_path, min_seq_length = 100){

  # Check the file exists
  if(!file.exists(align_path)){
    message = paste0(c("The path for the alignment file does not exist at: ",
                       align_path),
                     sep = "", collapse = "")
    stop(message)
  }


  cmd = paste0(c("mothur ",
                 "\"#screen.seqs(fasta=",
                 align_path,
                 ", minlength=",
                 min_seq_length,
                 ")\""),
               sep = "", collapse = "")


  # Make sure withr is available the suggested package is required
  if (!requireNamespace("withr", quietly = TRUE)) {
    stop(
      "Package \"withr\" must be installed to use this function.",
      call. = FALSE
    )
  }

  if (is_mothur_available()) {
    withr::with_dir(new = dirname(align_path), system(cmd))
  } else {
    stop("mothur is not installed or not in PATH.")
  }
  screened_path =
    sub(align_path,
        pattern = ".align$",
        replacement = ".good.align")

   # Check that the file exists
  if(!file.exists(screened_path)){
    stop("The alignment file was not produced.")
  }else{
    return(screened_path)
  }


}
