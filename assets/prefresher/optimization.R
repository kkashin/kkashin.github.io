### Optimization in R
### Math Prefresher for Political Scientists
### Konstantin Kashin
### Updated: August 2012


######################################################################################
################           Taylor Series Approximation                ################
######################################################################################

### Let's examine the function f(x) = e^x = exp(x)


### plot the function on the interval from -10 to 10:
x <- seq(from=-10,to=10,by=0.1)
plot(x, exp(x), type="l", lty=1, lwd=3)


### plot the function on the interval from -1 to 1:
x <- seq(from=-1,to=1,by=0.01)
plot(x, exp(x), type="l", lty=1, lwd=3)


### now approximate exp(x) using Taylor (Maclaurin) series around a=0

### add in a=0 vertical line 
abline(v=0, lty=3)

### 1st order: f(0) = 1+x
lines(x, 1+x, lty=2, lwd=3, col="red2")

### 2st order: f(0) = 1+x+x^2/2
lines(x, 1+x+x^2/2, lty=2, lwd=3, col="blue")
### note that the 2nd order Taylor series expansion is sufficient to approximate the curvature of f(x) around x=a=0

### 3rd order: f(0) = 1+x+x^2/2+x^3/3
lines(x, 1+x+x^2/2+x^3/3, lty=2, lwd=3, col="green3")

### 4th order: f(0) = 1+x+x^2/2+x^3/3+x^4/4
lines(x, 1+x+x^2/2+x^3/3+x^4/4, lty=2, lwd=3, col="gold")

### we could keep going to infinity and get better and better approximations of f(x) around x=a


### A good resource for series expansion is Wolfram Alpha: http://www.wolframalpha.com/examples/SeriesExpansions.html



######################################################################################
################               3D Visualization in R                  ################
######################################################################################
### install rgl package if you don't have it already
install.packages("rgl")

### load rgl package
library(rgl)

### Let's plot f(x,y) = z = x^2+y^2 (positive definite)

# create domain (x,y)
x <- seq(-10, 10, by= 0.1) 
y <- x

# define function
f <- function(x,y) {out <- x^2+y^2}

# calculate output across domain
z <- outer(x, y, f)

# this calls 3D plotting engine
open3d()
bg3d("white")
material3d(col="black")
persp3d(x, y, z, col = "pink", alpha=.25) # alpha sets transparency
play3d(spin3d(axis=c(0,0,1), rpm=8)) # this makes the plot rotate automatically


### Let's plot f(x,y) = z = x^2-y^2 (indefinite)

g <- function(x,y) {out <- x^2-y^2}
z <- outer(x, y, g)

open3d()
bg3d("white")
material3d(col="black")
persp3d(x, y, z, col = "pink", alpha=.25) # alpha sets transparency



######################################################################################
################           Unconstrainted Optimization                ################
######################################################################################

### optimize() for one-dimensional optimization
### optim() for multi-dimensional optimization


### Find global minimum and/or maximum of (x_1-1)^2 + (x_2)^2=1 

# write function; note that the input x here is actually a vector of the length of the number of variables in the function (the dimensionality of the Euclidean space the function inhabits)
my.fxn <- function(x) {
    x1 <- x[1]
    x2 <- x[2]
    (x1-1)^2 + x2^2 + 1
}

### Global minimum 
optim(par=c(0,0), my.fxn, method="Nelder-Mead", control=list(fnscale=1), hessian=TRUE)
### par gives initial values of parameters to start with (variables that we're optimizing with respect to); here, we're starting with c(0,0) as the initial values of (x_1, x_2)
### 'method' gives the algorithm of minimization/maximization; we're using Nelder-Mead here
### 'control=list(fnscale=1)' means that it's a minimization problem (this is the default)
### 'hessian=TRUE' just means that we want the Hessian matrix (matrix of second partial derivatives) as an output

### Output is x_1=9.998922e-01 and x_2=7.959077e-05 as the global minimum. This is very close to the analytical solution of (1,0) as the global minimum that we would get if we found the gradient and set it equal to zero.

### We see also that the Hessian is positive definite, implying that the point (1,0) is a strict local (and global in this case) minimum

### Global maximimum 
optim(par=c(0,0), my.fxn, method="Nelder-Mead", control=list(fnscale=-1), hessian=TRUE)
### everything is same as above, except 'control=list(fnscale=-1)' indicates that it's a maximimization problem

### Output is x_1=-3.183805e+55 and x_2=2.684172e+55, which implies that global maximum does not exist (those numbers are enormous, and if the algorithm didn't time out, would keep on climbing...)




#### Another example, this time to illustrate that starting position matters!
#### Now let's find min of f(x)=(x_1)^3 - (x_2)^3+9*(x_1)*(x_2)  
my.fxn2 <- function(x) {
    x1 <- x[1]
    x2 <- x[2]
    (x1)^3 - (x2)^3+9*x1*x2  
}

# Let's look for a minimum, but now starting position is going to matter!

optim(par=c(0,0), my.fxn2, method="Nelder-Mead", control=list(fnscale=1), hessian=TRUE)
# if you start at (0,0), you won't find a minimum...

optim(par=c(1,-1), my.fxn2, method="Nelder-Mead", control=list(fnscale=1), hessian=TRUE)
# if you start at (1,-1), you will find a maximum at (3,-3), which matches up with the analytical global minimum

# this illustrates that optimization algorithms do not fully replace analytic solutions or reasoning! We have to be careful about starting positions and the algorithm we use. It's often a good idea to try several algorithms for optimization and several starting points to be certain that the algorithm has really converged upon a min / max point.



####### SEE http://cran.r-project.org/web/views/Optimization.html for a list of R packages that deal with optimization-type problems



