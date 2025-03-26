#' Wrapper for mothur Align Seqs function
#'
#' R script to use the mothur align.seqs command. More information can be
#' found at the mothur website: https://mothur.org/wiki/align.seqs/.
#' Defaults are set to those defaults provided by the documentation at
#' mothur.org
#'
#' @param candidate The path to the fasta file that you are wanting to align.
#' @param output.directory Output directory
#' @param template The path to the template file you would like to align to.
#' Defualt is to align to the silva Tree alignment file.
#' @param search Set search to "kmer" (Default) or "suffix" for kmer or suffix
#' tree searching. The kmer searching is recommended on mothur.org with cited
#' reasons of being faster and best.
#' @param ksize The size of the kmer. mothur.org recommends the kmer size that
#' is empirically determined by the user to be the fastest for alignment.
#' @param align The alignment method used. Options include "needleman" (Default)
#' and "gotoh" algorithm. The needleman prioritizes the same amount for
#' opening and extending a gap. The gotoh algorithm charges differently for
#' opening (larger penalty) and extending a gap. mothur.org suggests
#' the needleman algorithm as it decreases the amount of time needed for the
#' alignment without decreasing the time required for alignment.
#' @param match Default reward for a match (+1). mothur.org has set these
#' defaults to be best at producing 16S rRNA gene sequence alignments.
#' @param mismatch Default penalty for a mismatch (-1).
#' @param gapopen The default penalty for opening a gap (-2).
#' @param gapextend The default penalty for extending a gap (-1).
#' @param flip Should the sequence be flipped to align to see if the reverse
#' complement aligns better? Default is TRUE.
#' @param threshold The  threshold (default 0.5) that is used to determine if a
#' sequence should be flipped for a better alignment.
#' @param processors Default 1. The number of cores to use to do the alignment.
#' @return A path to the mothur alignment file
#' @export
align_seqs_mothur = function(candidate,
                             output.directory,
                             template,
                             search = "kmer",
                             ksize = 8,
                             align = "needleman",
                             match = 1,
                             mismatch = -1,
                             gapopen = -2,
                             gapextend = -1,
                             flip = TRUE,
                             threshold = 0.50,
                             processors = 50){



  # Test the candidate file ends in fasta
  if(!grepl('fasta$', candidate)){
    stop("Please provide a fasta file format for mothur_align_seqs. (End the
         file name with .fasta")
  }else{
    candidate.align.name = sub(candidate, pattern = "fasta",
                               replacement = "align")
  }

  # Check parameters are approrpiate inputs
  if(!search %in% c("kmer", "suffix")){
    stop("Please provide a valid input option to the search parameter - either
         'kmer' or 'suffix' ")
  }
  if(!align %in% c("needleman", "gotoh")){
    stop("Please provide a valid input option to the align parameter - either
         'needleman' or 'gotoh' ")
  }
  if(flip){
    flip = "t"
  }else{
    flip = "f"
  }

  cmd = paste0(c("mothur ",
                 "\"#align.seqs(candidate=",
                 candidate,
                 ", template=",
                 template,
                 ", search=",
                 search,
                 ", ksize=",
                 ksize,
                 ", align=",
                 align,
                 ", match=",
                 match,
                 ", mismatch=",
                 mismatch,
                 ", gapopen=",
                 gapopen,
                 ", gapextend=",
                 gapextend,
                 ", flip=",
                 flip,
                 ", threshold=",
                 threshold,
                 ", processors=",
                 processors,
                 ")\""),
               sep = "", collapse = "")


  my_cat(cmd)

  # Make sure withr is available the suggested package is required
  if (!requireNamespace("withr", quietly = TRUE)) {
    stop(
      "Package \"withr\" must be installed to use this function.",
      call. = FALSE
    )
  }
  # code that includes calls such as withr::aaa_fun()

  if (is_mothur_available()) {
    withr::with_dir(new = output.directory, system(cmd))
  } else {
    stop("mothur is not installed or not in PATH.")
  }

  #system(paste0(c("mv ", getwd(), "/mothur*.logfile ", output.directory),
  #              collapse = "", sep = ""))

  # Check that the file exists
  if(!file.exists(candidate.align.name)){
    stop("The alignment file was not produced.")
  }else{
    return(candidate.align.name)
  }

}
