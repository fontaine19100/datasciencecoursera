## Put comments here that give an overall description of what your
## functions do

## This first function is intended to create a special matrix which will be cached and furtherly used for
## calculating its inverse

makeCacheMatrix <- function(x = matrix()) {
          myinverse <- NULL
          
          set <- function(y) 
          {
                x <<- y #use of the superassignment operator as x doesn't come from the same environment as y
                myinverse <<- NULL
          }
          get <- function() x #definition of the getter, just returns our matrix passed as argument
          setinverse <- function(solve) myinverse <<- solve #setter which will store later the inverse of the matrix
          getinverse <- function() myinverse
          a = list(set = set, get = get, setinverse = setinverse, getinverse = getinverse) #returns a list of
          #all the getters and setters for further use in cacheSolve.
}


## This function takes the special matrix defined above and is intended to work out its inverse

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
          if(ncol(x$get()) != nrow(x$get()))
          {
                    message("Your matrix is not a square matrix, further inversion impossible")
          }
          else if(determinant.matrix(x$get(),FALSE)[[1]][[1]]!=0) #if the matrix is inversible (non zero determinant)
          {
                    myinverse <- x$getinverse()
                    if(!is.null(myinverse)) #in this case, the inverse of our matrix has been calculated, we retrieve it
                                            #from the cache
                    {
                              message("getting cached data")
                              return(myinverse)
                    }
                    matrixtoinverse <- x$get() #we called the getter to retrieve the matrix passed in argument of makeCacheMatrix
                    myinverse <- solve(matrixtoinverse, ...) #call of solve which calculates the inverse of this matrix
                    x$setinverse(myinverse)
                    myinverse
          }
          else
          {
                    message("error: your matrix is not inversible, it has a 0 determinant")
          }
}