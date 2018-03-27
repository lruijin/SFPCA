\name{sfpca-Functions}
\alias{sfpca_fixed}

\title{Set of functions in sfpca package}
\description{
  This function is created to compute the rank-one SFPCA solution L1 sparse penalties for fixed regularization params
}
\usage{
sfpca_fixed (X, lamu, lamv, alphau, alphav, Omegu, Omegv, startu, startv, posu, posv, maxit)
}
\arguments{
  \item{X}{a n x p data matrix}
  \item{lamu}{sparsity parameter for u}
  \item{lamv}{sparsity parameter for v}
  \item{alphau}{smoothness parameter for u}
  \item{alphav}{smoothness parameter for v}
  \item{Omegu}{n x n positive semi-definite matrix for roughness penalty on u}
  \item{Omegv}{p x p positive semi-definite matrix for roughness penalty on v}
  \item{startu}{n vector of starting values for U; if startu = rep(0,n), then algorithm initialized to the rank-one SVD solution}
  \item{startv}{p vector of starting values for V; if startv = rep(0,p), then algorithm initialized to the rank-one SVD solution}
  \item{posu}{non-negative indication; posu = T imposes non-negative constraints on u}
  \item{posv}{non-negative indication; posv = T imposes non-negative constraints on v}
  \item{maxit}{maximum number of alternating regressions steps}
}
\value{
  \code{sfpca_fixed()} returns a list with the left SFPC \code{U}, the right SFPC \code{V}, the associated singular value \code{d} and the deflated residual matrix \code{Xhat}
  
}
\details{
  These functions are basically created to implement SFPCA algorithms under different kinds of penalty and different models. More functions available later
}
\references{
G.I. Allen. "Sparse and Functional Principal Components Analysis." ArXiv Pre-Print 1309.2895 (2013). \link[https://arxiv.org/abs/1309.2895]{https://arxiv.org/abs/1309.2895}}

\examples{
library(sfpca)
n <- 60; p=200
d <- c(15, 12, 10)
X <- matrix(rnorm(n),nrow=n)
u <- svd(X,3)$u
t <- seq(0, 200, len = p)
v1 <- sin((2*pi*t)/60); v1 <- c(rep(0,120),v1[121:181],rep(0,19))
v1 <- v1/sqrt(sum(v1^2)) 

v2 <- exp(-(1/(2*7*pi))*(t-100)^2) * cos(2*pi*(t-100)/7)
v2 <- c(rep(0,77),v2[78:127],rep(0,73))
v2 <- v2/sqrt(sum(v2^2)) 

v3 <- sin((2*pi*t)/30); v3 <- c(v3[1:62],rep(0,138))
v3 <- v3/sqrt(sum(v3^2))

# plot the true signal
plot(t, v1, type = "l", lty = 1, col = 1, main = "True Signal",ylim=c(-0.45,0.45))
lines(t, v2, lty = 2, col = 2)
lines(t, v3, lty = 3, col = 3)

X <- d[1] * u[,1] \%*\% t(v1) + d[2] * u[,2] \%*\% t(v2) + d[3] * u[,3] \%*\% t(v3)
X <- X + matrix(rnorm(ncol(X)*nrow(X)),dim(X))

lamu = 1; lamv = 1
alphau = 10; alphav = 10
Omegu = diag(n)
Omegv = diag(p)
startu = rep(0,n)
startv = rep(0,p)
posu = TRUE; posv = TRUE
maxit = 1000
sfpca_res <- sfpca_fixed(X, lamu, lamv, alphau, alphav, Omegu, Omegv, startu, startv, posu, posv, maxit)
sfpca_res
}
\author{Ruijin Lu}

