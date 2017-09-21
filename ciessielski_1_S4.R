# HELP:
#  https://www.bioconductor.org/help/course-materials/2013/CSAMA2013/friday/afternoon/S4-tutorial.pdf
#  https://cran.r-project.org/doc/contrib/Genolini-S4tutorialV0-5en.pdf

# TODO:
#   [] checking if n of t and n of v are equal
#   [] plot method
#   [] lines method
#   [] points method
#   [] window method
#   [] select method
#   [] [ method
#   [] simplify method

rm(list = ls())
require(pryr)

sts <- setClass("Sts",
                slots = c(time = "numeric",
                          value = "numeric"),
                contains = "data.frame")
sts()
class(sts)

n <- 10
s <- sts(time = sort(rnorm(n)), value = cumsum(rnorm(n)))
s

setMethod("show",
          signature ="Sts",
          function(object) {
            cat("time: ", object@time, "\n")
            cat("value: ", object@value)
          }
)

setMethod("initialize",
          signature = "Sts",
          definition = function(.Object,time,value){
            cat("inicjacja")
            return(.Object)
          })

s
s2 <- sts(time="das", value=3)
s3 <- sts(time=3)
s3
s4 <- sts(time=10, value=20)
s4

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




setGeneric(
  name = "hello",
  def = function(object){standardGeneric("hello")}
)

setMethod(f="hello",
          signature = "Sts",
          definition = function(object){
            cat("hello world!")
          }
)

