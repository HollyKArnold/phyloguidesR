#' Concatenate full length guides and short read data.
#'
#' @param dir_out The output directory where to write the concatenated ASV + guides file.
#' @param filename_out Output filename to write the concatenated ASV + guides file.
#' @param guides_file_path File path to the full length guide file.
#' @param asvs_file_path File path to ASV file (FASTA formatted).
#'
#' @return The path to the ouput concatenated ASV + guides file.
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

  #Returns the path to the fasta file.
  return(filename_out)
}
