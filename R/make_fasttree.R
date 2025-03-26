#' Make a fasttree from an alignment file
#'
#' @param path_alignment Path to the alignment file
#' @param fasttree_flags Flags to pass to fasttree
#' @param output_file_name The output file name
#' @param output_dir The output directory.
#' @return Returns a path to fasttree output if fasttree is successful,
#' otherwise returns NULL
#' @export
make_fasttree = function(path_alignment,
                         fasttree_flags = "-nt -gtr -gamma",
                         output_file_name,
                         output_dir){

  output.file = file.path(output_dir, output_file_name)
  if(file.exists(output.file)){
    stop("That file already exists.")
  }

  # Check the input fasta exists
  if(!file.exists(path_alignment)){
    message = paste0(c("The path for the alignment file does not exist at: ",
                       path_alignment,
                       sep = "", collapse = ""))
    stop(message)
  }

  cmd = paste0(c("FastTree ",
                 fasttree_flags,
                 " ",
                 path_alignment,
                 " > ",
                 output.file), sep = "", collapse = "")


  if (is_fasttree_available()) {
    withr::with_dir(new = dirname(output_dir), system(cmd))
  } else {
    stop("FastTree is not installed or not in PATH.")
  }


  if(file.exists(output.file)){
    return(output.file)
  }else{
    return(NULL)
  }
}
