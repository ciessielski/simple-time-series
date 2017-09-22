# HELP:
#  https://www.bioconductor.org/help/course-materials/2013/CSAMA2013/friday/afternoon/S4-tutorial.pdf
#  https://cran.r-project.org/doc/contrib/Genolini-S4tutorialV0-5en.pdf

# TODO:
#   [x] checking if n of t and n of v are equal
#   [] plot method
#   [] lines method
#   [] points method
#   [] window method
#   [] select method
#   [] [ method
#   [] simplify method
#   [] sts creates rows and columns in data.frame

rm(list = ls())
require(pryr)


class(data.frame)


# xx <- data.frame(a=rnorm(10),
#                  b=as.factor(sample(c("T", "F"), 10, TRUE)),
#                  row.names = paste("R",1:10,sep=":"))
# 
# setClass("myData", representation(extra = "character"),
#          contains = "data.frame")
# 
# mx <- new("myData", xx, extra = "testing")
# mx$ds <- 2

setOldClass("data.frame")
sts <- setClass("Sts",
                slots = c(time = "numeric",
                          value = "numeric"),
                contains = "data.frame")

eval(sts)
getClass("Sts")

setMethod("initialize",
          signature = "Sts",
          definition = function(.Object, time, value){
            if(length(time) == length(value)){
              .Object@time <- time
              .Object@value <- value
              # .Object <- as.data.frame()
              # .Object <- sts(c(0, 1, 2, 3))
              # .Object$t <- as.vector(time)
              # .Object$v <- as.vector(value)
              return(.Object)
            } else {
              stop("'time' and 'value' should have the same number of elements")
            }
          }
)

n <- 100
s <- sts(time = sort(rnorm(n)), value = cumsum(rnorm(n)))
sdf <- data.frame()
# s <- as.data.frame(s)
# s$dsa <- NA 
  
# setGeneric(
#   name = "hello",
#   def = function(object){standardGeneric("hello")}
# )
# 
# setMethod(f="hello",
#           signature = "Sts",
#           definition = function(object){
#             cat("hello world!")
#           }
# )

# setGeneric(
#   name = "inputData",
#   def = function(object){standardGeneric("inputData")}
# )
# 
# setMethod("inputData",
#           "Sts",
#           function(object){
#             cat("inputdata", class(object))
#             nrow(object) <- 100
#             # object$new.t <- object@time
#           }
# )

# inputData(s)

setMethod("plot",
          "Sts",
          function(object) {
            
          }
)

setMethod("lines",
          "Sts",
          function(object) {
            
          }
)

setMethod("points",
          "Sts",
          function(object) {
            
          }
)

setMethod("window",
          "Sts",
          function(object) {
            
          }
)

setMethod("select",
          "Sts",
          function(object) {
            
          }
)

setMethod("[",
          "Sts",
          function(object) {
            
          }
)

setMethod("simplify",
          "Sts",
          function(object) {
            
          }
)









# SPRAWDZENIE METOD

pdf (file = "fig1.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5)) 
grid()
dev.off()
### Bardziej skomplikowany wykres z wykorzystaniem proponowanych metod
pdf(file = "fig2.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5))
s1 <- s[1:20] # selekcja po numerze obserwacji
lines(s1, col = "red", lwd = 2)
points(s1, col = "red", pch = 20, cex = 1.3)
s2 <- window(s , start = .5) # selekcja po czasie lines(s2 , col="magenta" , lwd=2)
points(s2, col="magenta", pch = 20, cex = 1.3)
s3 <- select (s , value > -12 & value < -5) # selekcja po warunku logicznym 
points(s3, col = "green", pch = 20, cex = 1.3)
s4 <- simplify(s)
lines(s4, col = "black", lty = "dashed") 
dev.off()





