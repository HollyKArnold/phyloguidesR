#' Concatenate guides and fasta
#'
#' @param dir_out The output directory where to write the seqs + guides file.
#' @param filename_out the name of the output file of the seqs + guides file
#' @param guides_file_path The file path to the guide file
#' @param asvs_file_path The file path to asv fasta file
#'
#' @return The path to the written fasta + guides file
#' @export
#'
add_guides = function(dir_out = ".", filename_out = "seqs_and_guides.fasta", guides_file_path, asvs_file_path){

  filename_out = file.path(dir_out, filename_out)
  if(!file.exists(guides_file_path)){
    stop("ERROR: Could note find your guides file at the path provided")
  }
  # Write out the concatenated file
  if(!file.exists(filename_out)){
    cmd = my_cat(c("cat ", asvs_file_path, " ", guides_file_path, " > ", filename_out))
    print(cmd)
    system(cmd)
  }

  #Reuturns the path to the fasta file.
  return(filename_out)
}
