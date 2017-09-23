#  TODO:
#   [x] checking if n of t and n of v are equal
#   [x] plot method
#   [x] [ method
#   [x] select method
#   [x] lines method
#   [x] points method
#   [x] window method
#   [x] simplify method
#   [?] sts creates rows and columns visible like data.frame

rm(list = ls())

sts <- setClass("Sts",
                slots = c(time = "numeric",
                          value = "numeric"),
                contains = "data.frame")

setMethod("initialize",
          signature = "Sts",
          definition = function(.Object, time, value){
            
            if(length(time) == length(value)){
              .Object@time <- time
              .Object@value <- value
              return(.Object)
            } else {
              stop("'time' and 'value' should have the same number of elements")
            }
          }
)

n <- 100
s <- sts(time = sort(rnorm(n)), value = cumsum(rnorm(n)))
s

setMethod("plot",
          "Sts",
          function(object,x, y, ...) {
            
            if(length(object@time) > 0) {
              x <- object@time
              y <- object@value
              plot(x, y, xlab = "time", ylab = "value", ...)
            } else {
              print("ploting problem: object is empty")
            }
          }
)

setMethod("lines",
          "Sts",
          definition = function(object, x, y, ...) {
            
            if(length(object@time) > 0) {
              x <- object@time
              y <- object@value
              lines(x, y, type = "l", ...)
            } else {
              print("lines ploting problem: object is empty")
            }
          }
)

setMethod("points",
          "Sts",
          function(object, x, y, ...) {
            
            if(length(object@time) > 0) {
              x <- object@time
              y <- object@value
              points(x, y, ...)
            } else {
              print("points ploting problem: object is empty")
            }
          }
)

setMethod("[",
          "Sts",
          function(object ,x, i) { #doesn't work without 'i' which is never used?!
            object@value <- object@value[x]
            object@time <- object@time[x]
            object
          }
)

setMethod("window",
          "Sts",
          function(x, start=NULL, end=NULL) {
            
            if(is.null(start)){
              print("missing start")
              start <- x@time[1]
            }

            if(is.null(end)){
              print("missing end")
              end <- x@time[n]*2
            }
            
            cat("x@time:", x@time[n])
            
            w1 <- x@time > start
            x@time <- x@time[w1]
            x@value <- x@value[w1]
            w2 <- x@time < end
            x@time <- x@time[w2]
            x@value <- x@value[w2]
            x
          }
)

setGeneric("select", function(object, ...){standardGeneric("select")})

setMethod("select",
          "Sts",
          function(object, ...) {
            value <- object@value
            list1 <- as.list(match.call(expand.dots=FALSE))
            cond <- as.character(list1[3])
            cond <- substr(cond, 10, nchar(cond)-1)
            condV <- eval(parse(text = cond))
            object@time <- object@time[condV]
            object@value <- object@value[condV]
            object
          }
) 

setGeneric("simplify", function(object){standardGeneric("simplify")})

setMethod("simplify",
          "Sts",
          function(object) {
            
            count <- 1
            values <- object@value
            print(values)
            sV <- c(object@value[1])
            sT <- c(object@time[1])
            isGrowing <- FALSE
            wasGrowing <- FALSE
            
            for (v in values) {
              
              if (v < object@value[count+1]) {
                isGrowing <- TRUE
              }
              
              if (isGrowing & !wasGrowing){ 
                sV <- c(sV, object@value[count+1])
                sT <- c(sT, object@time[count+1])
              }
              
              wasGrowing <- isGrowing
              isGrowing <- FALSE
              count <- count + 1
              if(count == n){
                count <- n-1
              }
            }
            
            object@value <- sV
            object@time <- sT
            object
          }
)

### TESTING METHODS:

# Tworzenie prostego szeregu czasowego
n <- 100
s <- sts ( time = sort( rnorm( n)) , value = cumsum( rnorm( n)))

# Prosty wykres stworzonego obiektupdf (file = "fig1.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5))
grid()
dev.off()

# Bardziej skomplikowany wykres z wykorzystaniem proponowanych metod
pdf(file = "fig2.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5))
s1 <- s[1:20] # selekcja po numerze obserwacji
s1
lines(s1, col = "red", lwd = 2)
points(s1, col = "red", pch = 20, cex = 1.3)
s2 <- window(s , start = .5) # selekcja po czasie
s2
lines(s2 , col="magenta" , lwd=2)
points(s2, col="magenta", pch = 20, cex = 1.3)
s3 <- select (s , value > -12 & value < -5) # selekcja po warunku logicznym
s3
points(s3, col = "green", pch = 20, cex = 1.3)
s4 <- simplify(s)
lines(s4, col = "black", lty = "dashed")
dev.off()


### HELP:
#  https://www.bioconductor.org/help/course-materials/2013/CSAMA2013/friday/afternoon/S4-tutorial.pdf
#  https://cran.r-project.org/doc/contrib/Genolini-S4tutorialV0-5en.pdf
#  https://stat.ethz.ch/pipermail/r-help/2011-August/285614.html