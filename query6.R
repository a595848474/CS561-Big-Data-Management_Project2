library(rmr2)

## query6
query6 = 
  function(input, output = NULL, pattern = " "){
    
    ##Mapper
    q6.map = function(.,lines){ # lines are all the lines, which means map already reads all the lines
      CountryCodes = array()
      for(i in 1:length(lines)){
        records = unlist(strsplit( x = lines[i], split = pattern))
        CountryCodes[i] = toString(records[4])
      }
     # records = unlist(strsplit( x = lines, split = pattern))
      keyval(CountryCodes, '1')
    }
    
    ## reducer
    q6.reduce = function(CountryCode, counts){
      keyval(CountryCode, toString(sum(as.integer(counts))))
    }
    
    ## query5-mapreduce job configuration
    mapreduce(
      input = input,
      output = output,
      map = q6.map,
      reduce = q6.reduce,
      combine = TRUE,
      input.format=make.input.format("text"))
  }

inputPath = '/user/hadoop/input/customers.txt'
outputPath = '/user/hadoop/output_project2/query6'

query6(inputPath, outputPath, pattern = ",")

results = from.dfs(outputPath)

x = results$key
y = as.integer(results$val)

## plot the output
barplot(y, main="Customers Count", xlab="Country Code", ylab="Count", names.arg=x)

## sort the output and plot it
x_sort = order(y, decreasing=T)
y_sort = y[x_sort]
barplot(y_sort, main="Sorted Customers Count", xlab="Country Code", ylab="Count", names.arg=x_sort)
