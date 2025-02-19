#'
#' Description:  turns dosage based data 0,1,2,3,4 to ACGT with dosage as number of alternative or B_allele
#'               i.e. if SNP1 A_allele is A and B_allele is T then 0 -> AAAA and 2 -> AATT
#'
#' Author: Jeekin Lau
#' Date last edited: 4/1/2021
#'
#' input file is dosage file from fitPoly
#' an assumption of this is that all are same ploidy
#' only works for 4x right now (may softcode later for other ploidy)
#'
#' How to use:
#'     Need a dosage formatted like below:
#'
#' marker	ind1	ind2	ind3	ind4	ind5
#' marker1 	4	  3	    4	    4	    3
#' marker2 	4	  3	    4	    3	    4
#' marker3 	4	  3	    NA	  NA	  4
#' marker4 	4	  4	    NA	  4	    3
#' marker5 	4	  3	    4	    4	    3
#'
#'
#'
#'
#' NEEDS INTERNET connection to fetch annotation file which contains marker names and A_allele and B_allele for WagRhSNP68k it is "WagRhSNP_annotation.r1.csv"
#'
#'
#' @param dosage.file An output file from the result of compare_probes() or a dosage matrix which rows are markers and columns are individuals
#' @param progress if \code{TRUE} progress shown in console; if \code{FALSE}, no output produced default is TRUE
#' @param separator what separator used between the letters
#'
#' @return One csv with dosage turned into lettering format
#'
#' @author Jeekin Lau, \email{jeekinlau@gmail.com}
#'
#' @export dosage_to_ACGT
#'
# ###################################
# START of Code
# import dosage data



dosage_to_ACGT <- function(dosage.file, progress=NULL, separator=NULL){
  if(is.null(progress)){progress<-T}
  if(is.null(separator)){separator<-""}
  dosage_file_name<-gsub(".csv","_",dosage.file)
  dosage<-(read.csv(dosage.file, header = T, sep = ","))
  names(dosage)[1]<-"Affy.SNP.ID"
  annotation<-read.csv('https://raw.githubusercontent.com/jeekinlau/test_package/master/docs/WagRhSNP68k_annotation_condensed.csv')
  data<-merge(annotation,dosage, by="Affy.SNP.ID")
  for (a in 1:nrow(data)){
    for (b in 4:ncol(data)){
      ifelse(data[a,b]==0,data[a,b]<-paste0(data[a,2],separator,data[a,2],separator,data[a,2],separator,data[a,2]),
             ifelse(data[a,b]==1,data[a,b]<-paste0(data[a,2],separator,data[a,2],separator,data[a,2],separator,data[a,3]),
                    ifelse(data[a,b]==2,data[a,b]<-paste0(data[a,2],separator,data[a,2],separator,data[a,3],separator,data[a,3]),
                           ifelse(data[a,b]==3,data[a,b]<-paste0(data[a,2],separator,data[a,3],separator,data[a,3],separator,data[a,3]),
                                  ifelse(data[a,b]==4,data[a,b]<-paste0(data[a,3],separator,data[a,3],separator,data[a,3],separator,data[a,3]),NA)))))
    }
    if(progress==T){print(a)}

  }
  write.csv(data,paste0(dosage_file_name,"converted_dosage_ACGT.csv"),row.names = F)
  print("FINISHED")
}


dosage.file="13plates_newest_scores_compared_calls_v2.csv"
progress=NULL
separator=NULL

dosage_to_ACGT2<- function(dosage.file, progress=NULL, separator=NULL){
  if(is.null(progress)){progress<-T}
  if(is.null(separator)){separator<-""}
  dosage_file_name<-gsub(".csv","_",dosage.file)
  dosage<-(read.csv(dosage.file, header = T, sep = ","))
  names(dosage)[1]<-"Affy.SNP.ID"
  annotation<-read.csv('https://raw.githubusercontent.com/jeekinlau/test_package/master/docs/WagRhSNP68k_annotation_condensed.csv')
  data<-merge(annotation,dosage, by="Affy.SNP.ID")
  for (a in 1:nrow(data)){
    data[a,]=gsub(0, paste0(data[a,2],separator,data[a,2],separator,data[a,2],separator,data[a,2]),data[a,])
    data[a,]=gsub(1, paste0(data[a,2],separator,data[a,2],separator,data[a,2],separator,data[a,3]),data[a,])
    data[a,]=gsub(2, paste0(data[a,2],separator,data[a,2],separator,data[a,3],separator,data[a,3]),data[a,])
    data[a,]=gsub(3, paste0(data[a,2],separator,data[a,3],separator,data[a,3],separator,data[a,3]),data[a,])
    data[a,]=gsub(4, paste0(data[a,3],separator,data[a,3],separator,data[a,3],separator,data[a,3]),data[a,])
    if(progress==T){print(a)}
  }
  write.csv(data,paste0(dosage_file_name,"converted_dosage_ACGT.csv"),row.names = F)
  print("FINISHED")
}

dosage.file="13plates_newest_scores_compared_calls_v2.csv"
progress=NULL
separator=NULL

dosage_to_ACGT2<- function(dosage.file, progress=NULL, separator=NULL){
  if(is.null(progress)){progress<-T}
  if(is.null(separator)){separator<-""}
  dosage_file_name<-gsub(".csv","_",dosage.file)
  dosage<-(read.csv(dosage.file, header = T, sep = ","))
  names(dosage)[1]<-"Affy.SNP.ID"
  annotation<-read.csv('https://raw.githubusercontent.com/jeekinlau/test_package/master/docs/WagRhSNP68k_annotation_condensed.csv')
  data<-merge(annotation,dosage, by="Affy.SNP.ID")
  data = as.matrix(data)

  data<-apply(data,MARGIN=1,function(y) gsub(0, paste0(data[,2],separator,data[,2],separator,data[,2],separator,data[,2]),y))
  data<-apply(data,MARGIN=1,gsub(1, paste0(data[a,2],separator,data[a,2],separator,data[a,2],separator,data[a,3]),data[a,]))
  data<-apply(data,MARGIN=1,gsub(2, paste0(data[a,2],separator,data[a,2],separator,data[a,3],separator,data[a,3]),data[a,]))
  data<-apply(data,MARGIN=1,gsub(3, paste0(data[a,2],separator,data[a,3],separator,data[a,3],separator,data[a,3]),data[a,]))
  data<-apply(data,MARGIN=1,gsub(4, paste0(data[a,3],separator,data[a,3],separator,data[a,3],separator,data[a,3]),data[a,]))


  write.csv(data,paste0(dosage_file_name,"converted_dosage_ACGT.csv"),row.names = F)
  print("FINISHED")
}














