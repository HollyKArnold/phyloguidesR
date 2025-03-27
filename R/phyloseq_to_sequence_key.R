#' Create a sequence key from a phyloseq object
#'
#' @param phyloseq A phyloseq object
#' @param KEY.identifier.append Append an identifier to the start of the sequence key. This is appropraite when, for example, you are combining multiple studies together so that 'seq1' from study 1 will not be identical to seq1 in study 2.
#' @param KEY.identifier.sep The character to separate the KEY.identifier.append and the sequence KEY id. For example "."
#' @param is.human.readable Should the phyloseq be toggled to a human readable key. DEFAULT is ture.
#'
#' @return A table with each ASV sequence with a unique human readable identifier (seq1, seq2, ..., seqN). Column 1 (KEY) contains the sequence id and column 2 contains the ASV sequence.
#' @export
#'
phyloseq_to_sequence_key = function(phyloseq,
                                    KEY.identifier.append = NULL,
                                    KEY.identifier.sep = NULL,
                                    is.human.readable = TRUE){

  # Test that is an S4 object.
  if(!isS4(phyloseq)){
    stop("phyloseq_to_sequence_key can only be used on S4 objects")
  }

  if(phyloseq::taxa_are_rows(phyloseq)){
    N = nrow(phyloseq::otu_table(phyloseq))
    asvs = rownames(phyloseq::otu_table(phyloseq))
  }else{
    N = ncol(phyloseq::otu_table(phyloseq))
    asvs = colnames(phyloseq::otu_table(phyloseq))
  }

  # Make Sequence Key
  sequenceKey = as.data.frame(matrix(nrow = N, ncol = 2))
  colnames(sequenceKey) = c("KEY", "ASV")
  if(is.null(KEY.identifier.append)){
    sequenceKey$KEY = paste0("seq", seq(from = 1, to = N, by = 1))
  }else{
    if(is.null(KEY.identifier.sep)){
      sequenceKey$KEY = paste0("seq", seq(from = 1, to = N, by = 1),
                               ".",
                               KEY.identifier.append)
    }else{

      sequenceKey$KEY = paste0("seq", seq(from = 1, to = N, by = 1),
                               KEY.identifier.sep,
                               KEY.identifier.append)
    }

  }


  sequenceKey$ASV = asvs
  if(is.human.readable){

    rownames(sequenceKey) = sequenceKey$KEY

  }else{

    rownames(sequenceKey) = sequenceKey$ASV

  }

  return(sequenceKey)

}
