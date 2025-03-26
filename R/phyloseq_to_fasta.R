#' Write a fasta file from a sequence key
#'
#' @param phyloseq A phyloseq object. Note that the otu/asv names *must* be the sequences.
#' @param dir_out The output directory to where to write the fasta
#' @param filename_out The output filename
#' @return The path to the written fasta file
#' @export
#'
phyloseq_to_fasta = function(phyloseq, dir_out = ".", filename_out = "asvs.fasta"){

  # the suggested package is required

  if (!requireNamespace("phyloseq", quietly = TRUE)) {
    stop(
      "Package \"phyloseq\" must be installed to use this function.",
      call. = FALSE
    )
  }
  # code that includes calls such as aaapkg::aaa_fun()


  # Do some checks to see if the output directory exists
  if(!dir.exists(dir_out)){
    stop("ERROR: That directory does not exist.")
  }
  # And that we won't overwrite the output file
  if(file.exists(file.path(dir_out, filename_out))){
    stop("ERROR: That file exists already.")
  }

  # Now proceed with writing the fasta
  seq_key = phyloseq_to_sequence_key(phyloseq = phyloseq)
  seqs_fasta = sequence_key_to_fasta(file = file.path(dir_out, filename_out), seqkey = seq_key)

  #Return the path to the fasta file.
  return(seqs_fasta)
}
