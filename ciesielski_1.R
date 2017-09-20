setRefClass(
  "sts", 
  fields = c(time = "numeric",
             value = "numeric"),
  
  contains = "data.frame",

  methods = list(
    initialize = function(time, value){
      time <<- time
      value <<- value
    },
    plot = function(){
      
    },
    lines = function(){
      
    },
    points = function(){
      
    },
    window = function(){
      
    },
    select = function(){
      
    },
    ponumerzeobs = function(){
      
    },
    simplify = function(){
      
    }
  )
)
  
  

### Tworzenie prostego szeregu czasoweg
n <- 100
s <- sts(time = sort(rnorm(n)), value = cumsum(rnorm(n)))

### Prosty wykres stworzonego obiektu
pdf(file="fig1.pdf")
plot(s, type="o", pch = 20, cex = 1.2, col = rgb(0, 0, 1, .5))
grid()
dev.off()

### Bardziej skomplikowany wykres z wykorzystaniem proponowanych metod
pdf(file = "fig2.pdf")
plot(s, type = "o", pch = 20, cex = 1.2, col = rgb(0, 0 ,1,.5))
s1 <- s[1:20] # selekcj a po numer ze obserwacji
lines(s1, col = "red", lwd = 2)
points(s1 , col = "red", pch = 20, cex = 1.3)
s2 <- window(s, start = .5) # selekcj a po czasie
lines(s2, col = "magenta", lwd = 2)
points(s2, col = "magenta", pch =20, cex = 1.3)
s3 <- select(s, value > -12 & value < -5) # selekcja po warunku logicznym
points(s3, col="green" , pch = 20, cex = 1.3)
s4 <- simplify(s)
lines(s4 , col="black" , lty="dashed") dev.off()