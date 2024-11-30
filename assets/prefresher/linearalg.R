### Linear Algebra in R
### Math Prefresher for Political Scientists
### Konstantin Kashin
### Updated: August 2012

######################################################################################
################       Basic Matrix Operations (1 Matrix)             ################
######################################################################################
# create 3x3 matrix C
# 'data' argument is a vector of elements that will be the elements of the matrix
# if 'byrow' = TRUE, the elements of the 'data' vector are sequentially placed into the first row, then once that is full, the second row gets filled, and so on... 
C <- matrix(data=c(1,1,1,0,2,3,5,5,1), nrow=3, ncol=3, byrow=TRUE)
C

# dimensionality of matrix C
dim(C)

# sums of rows
rowSums(C)

# sums of columns
colSums(C)

# mean of rows
rowMeans(C)

# mean of columns
colMeans(C)

# subset first column of C:
C[,1]

# subset second row of C:
C[2,]

# subset last two columns of C:
C[,2:3] # equivalent to C[,c(2,3)]

# remove last row of C:
C[-nrow(C),] # equivalent to C[-3,]


######################################################################################
################       Basic Matrix Operations (2 Matrices)           ################
######################################################################################

# create matrix D
D <- matrix(data=c(1,2,3,0,4,5,0,0,0), nrow=3, ncol=3, byrow=TRUE)
D

# sum / difference of two matrices is the sum / difference of the corresponding terms
C + D
C - D

# multiplication of matrix by a constant
2*C

# product of the corresponding terms of the matrices
C*D

# quotient of the corresponding terms of the matrices (note that this results in 'NaN' b/c we are dividing by zero, which is undefined) 
D/C

# product of two matrices (note that order of multiplication matters!)
C %*% D
D %*% C

# create 3x3 identity matrix I
I = diag(3)

# product of a matrix and an identity matrix is just the identity matrix
C %*% I
I %*% C


######################################################################################
################ Representing Systems of Linear Equations as Matrices ################
######################################################################################

# We have the following system of linear equations:
# x-3y=-3
# 2x+y=8

# create matrix A of coefficients
# 'data' argument is a vector of elements that will be the elements of the matrix
# if 'byrow' = TRUE, the elements of the 'data' vector are sequentially placed into the first row, then once that is full, the second row gets filled, and so on... 
A <- matrix(data=c(1,-3,2,1), nrow=2, ncol=2, byrow=TRUE)
A


# to check dimensionality of the matrix, use the dim() function
dim(A)


# create matrix b of the RHS of the linear system of equations
b <- matrix(data=c(-3,8), nrow=2, ncol=1, byrow=TRUE)
b


# now create augmented matrix A.hat = [A|b] using cbind() command which appends matrices with same number of rows together
A.hat <- cbind(A,b)
A.hat
dim(A.hat)


# remember that to subset row i from a matrix X, we just write 'X[i,]'. To subset column j, we write 'X[,j]'
# 1st row of augmented matrix A.hat:
A.hat[1,]

# now let's manually create reduced row echelon form using Gaussian elimination (and practice subsetting of matrices!)

# L2' = L2 - 2L1
A.hat[2,] <- A.hat[2,] - 2*A.hat[1,]
A.hat

# L2' = 1/7*L2
A.hat[2,] <- 1/7*A.hat[2,]
A.hat

# L1' = L1+3*L2
A.hat[1,] <- A.hat[1,] + 3*A.hat[2,]
A.hat

# we now read off the solutions to the system of linear equations by subsetting the b column of the augmented matrix:
A.hat[,3] # x=3, y=2


#### A much faster way to get the same answer...use the solve() function!
## 'a' argument is square matrix that contains coefficients of linear system
## 'b' argument is RHS of system (vector or matrix)
solve(a=A, b=b)



######################################################################################
################               Additional Matrix Operations           ################
######################################################################################

# recall matrix C
C

# transpose of C
t(C)

# determinant of C
det(C) # note that it != 0, therefore matrix A is invertible / nonsingular

# inverse of C
solve(C)

# diagonal of C
diag(C)


######################################################################################
################  Cramer's Rule to Solve Systems of Linear Equations  ################
######################################################################################

### Solve the following system of equations:
### -2x + 3y - z = 1
### 1x + 2y -z = 4
### -2x - y + 1 = -3

### create coefficient matrix M:
M <- matrix(c(-2,3,-1,1,2,-1,-2,-1,1), ncol=3, byrow=TRUE)
M

### create RHS vector r:
r <- c(1,4,-3)

### Cramer's Rule tells us that the x that solves the system of equations can be found as |M_x|/|M|, where |M| is the determinants of the coefficient matrix and |M_x| is the determinant of the coefficient matrix where the column corresponding to x has been replaced by the RHS vector, r

# create M_x:
Mx <- M
Mx[,1] <- r
Mx

# solve for x:
det(Mx)/det(M) # x = 2

# we could have done this in one line of code by utilizing the cbind() command:
det(cbind(r, M[,2:3]))/det(M) # x = 2

# now let's solve for y and z:
det(cbind(M[,1], r, M[,3]))/det(M) # y = 3
det(cbind(M[,1:2], r))/det(M) # z = 4


### check with solve() command:
solve(M,r) # (2,3,4) is indeed the solution



