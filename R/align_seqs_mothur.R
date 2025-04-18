#' Wrapper for mothur's align.seqs() function.
#' Convience R script to use the mothur align.seqs command. More information can be
#' found at the mothur website: https://mothur.org/wiki/align.seqs/.
#' Defaults are set to those defaults provided by the documentation at
#' mothur.org
#'
#' @param candidate Path to the fasta file that you are wanting to align (guides + ASV concatenated file)
#' @param output.directory Output directory for which to write output files.
#' @param template The path to the template alignment file for which NAST alignment algorithm will align to.
#' @param search Set search to "kmer" (Default) or "suffix" for kmer or suffix tree searching. The kmer searching is recommended on mothur.org with cited reasons of being faster and best.
#' @param ksize The size of the kmer. mothur.org recommends the kmer size that is empirically determined by the user to be the fastest for alignment.
#' @param align The alignment method used. Options include "needleman" (Default) and "gotoh" algorithm. The needleman prioritizes the same amount for opening and extending a gap. The gotoh algorithm charges differently for opening (larger penalty) and extending a gap. mothur.org suggests the needleman algorithm as default.
#' @param match Reward for a match (Default +1). mothur.org has set these defaults to be best at producing 16S rRNA gene sequence alignments.
#' @param mismatch The penalty for a mismatch (Default -1).
#' @param gapopen The penalty for opening a gap (Default is -2).
#' @param gapextend The  penalty for extending a gap (Default -1).
#' @param flip Should the sequence be flipped to align to see if the reverse complement aligns better? (Default is TRUE).
#' @param threshold The threshold (Default 0.5) that is used to determine if a sequence should be flipped for a better alignment.
#' @param processors The number of cores to use to do the alignment. Default 1.
#' @return A path to the alignment file produced by mothurs align.seqs function.
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
                             processors = 1){



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
