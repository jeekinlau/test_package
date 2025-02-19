#' Prepare data for MAPpoly
#' Function takes the output from compare_probes() and prepares it for input to use in MAPpoly
#' Function reads in annotation files and matches the genome position of Rosa chinensis genome (Hibrand-Saint Oyant et al., 2018)
#' NOTE: must be connected to internet to read in annotation files
#'
#' @param input_file is a .csv file that has the dosages and Axiom marker names. Most likely an output file of compare_probes() function
#' @param genome specifies which genome order to use "saintoyant" or "raymond" (default is "saintoyant")
#' @return a .csv file that has the added columns of genome position and LG of markers. Will contain markers with no known location at bottom of file.
#'
#' @export fitPoly_add_phys_pos
#'
#'
#'
fitPoly_add_phys_pos<-function(input_file, genome=NULL){


  input_file_name = gsub(".csv","",input_file)
  file = read.csv(input_file)

  if(is.null(genome)){
    genomic_pos = read.table("https://raw.githubusercontent.com/jeekinlau/RoseArrayTools/master/docs/for_add_genomic_positions_saintoyant.txt", header = T, sep="\t")
  }else if(genome=="saintoyant"){
    genomic_pos = read.table("https://raw.githubusercontent.com/jeekinlau/RoseArrayTools/master/docs/for_add_genomic_positions_saintoyant.txt", header = T, sep="\t")
  }else if(genome=="raymond"){
    genomic_pos = read.table("https://raw.githubusercontent.com/jeekinlau/RoseArrayTools/master/docs/for_add_genomic_positions_raymond.txt", header = T, sep="\t")
  }else print("please select genome")


  temp_names = names(file)
  temp_names[1] = "Marker"

  colnames(file) = temp_names


  merged = merge(file,genomic_pos, by="Marker", all=T)





  final = cbind(merged$Marker, merged$LG, merged$Position, merged[,-which(colnames(merged)%in%c("Marker","LG","Position"))])
  final_colnames <- colnames(final)
  final_colnames[1:3] = c("Marker", "LG", "Position")
  colnames(final) = final_colnames

  final = final[order(final$LG, final$Position),]


  write.csv(final,paste0(input_file_name,"_dosage_with_phys.csv"),row.names = F)
  print("done")
}
