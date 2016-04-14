
hamming.distance <- function(string1, string2){
  if (is.na(string2)==T) { 
    return (NULL)
  }
  if(is.character(string1) !=1 || is.character(string2) !=1) {
  string1 = as.character(string1)
  string2 = as.character(string2)
  }
  
  length.string1 = nchar(string1)
  length.string2 = nchar(string2)
  
  if (length.string1 != length.string2) warning("Inputs must be of equal length")
  
  string.temp1 = c()
  for (i in 1:length.string1){
    string.temp1[i] = substr(string1, start=i, stop=i)
  }
  string.temp2 = c()
  for (i in 1:length.string2){
    string.temp2[i] = substr(string2, start=i, stop=i)
  }
  return(sum(string.temp1 != string.temp2))
}
