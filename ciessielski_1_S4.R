# HELP:
#  https://www.bioconductor.org/help/course-materials/2013/CSAMA2013/friday/afternoon/S4-tutorial.pdf
#  https://cran.r-project.org/doc/contrib/Genolini-S4tutorialV0-5en.pdf

# TODO:
#   [x] checking if n of t and n of v are equal
#   [x] plot method
#   [x] [ method
#   [] select method
#   [x] lines method
#   [x] points method
#   [x] window method
#   [] simplify method
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

n <- 25
s <- sts(time = sort(rnorm(n)), value = cumsum(rnorm(n)))
s

setMethod("plot",
          "Sts",
          function(object,x, y, ...) {
            x <- object@time
            y <- object@value
            plot(x, y, xlab = "time", ylab = "value", ...)
          }
)

setMethod("lines",
          "Sts",
          definition = function(object, x, y, ...) {
            x <- object@time
            y <- object@value
            plot(x, y, xlab = "time", ylab = "value")
            lines(x, y, xlab = "time", ylab = "value", type = "l", ...)
          }
)

setMethod("points",
          "Sts",
          function(object, x, y, ...) {
            x <- object@time
            y <- object@value
            plot(x, y, xlab = "time", ylab = "value")
            points(x, y, ...)
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
          function(x, start, end) {
            w1 <- x@time > start
            x@time <- x@time[w1]
            x@value <- x@value[w1]
            w2 <- x@time < end
            x@time <- x@time[w2]
            x@value <- x@value[w2]
            x
          }
)

setMethod("select",
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

# Tworzenie prostego szeregu czasoweg
pdf (file = "fig1.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5)) 
grid()
dev.off()

# Bardziej skomplikowany wykres z wykorzystaniem proponowanych metod
pdf(file = "fig2.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5))
s1 <- s[1:5] # selekcja po numerze obserwacji
s1
lines(s1, col = "red", lwd = 2)
points(s1, col = "red", pch = 20, cex = 1.3)
s2 <- window(s , start = .5) # selekcja po czasie 
lines(s2 , col="magenta" , lwd=2)
points(s2, col="magenta", pch = 20, cex = 1.3)
s3 <- select (s , value > -12 & value < -5) # selekcja po warunku logicznym 
points(s3, col = "green", pch = 20, cex = 1.3)
s4 <- simplify(s)
lines(s4, col = "black", lty = "dashed") 
dev.off()





