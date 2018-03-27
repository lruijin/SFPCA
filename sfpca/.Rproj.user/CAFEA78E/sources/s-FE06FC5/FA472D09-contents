// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-

// we include RcppEigen.h which pulls Rcpp.h in for us and math.
#include <RcppEigen.h>
#include <math.h>


// via the depends attribute we tell Rcpp to create hooks for
// RcppEigen so that the build process will know what to do
//
// [[Rcpp::depends(RcppEigen)]]
using namespace Rcpp;
using namespace RcppEigen;

using Rcpp::as;
using Eigen::MatrixXd;
using Eigen::VectorXd;
using Eigen::Map;

VectorXd soft_thr(
    VectorXd x,
    double lam,
    bool pos)
{
  if(!pos){
    return (x.array() - lam).cwiseMax(0) - (-1 * x.array() - lam).cwiseMax(0);
  }
  else{
    return (x.array() - lam).cwiseMax(0);
  }
}

// via the exports attribute we tell Rcpp to make this function
// available from R
//
// [[Rcpp::export]]
Rcpp::List sfpca_fixed(
    MatrixXd X,
    double lamu, double lamv,
    double alphau, double alphav,
    MatrixXd Omegu, MatrixXd Omegv,
    VectorXd startu, VectorXd startv,
    bool posu, bool posv,
    int maxit)
{
  int n, p;
  n = X.rows();
  p = X.cols();
  
  Eigen::SparseMatrix<double> Su(n,n), Sv(p,p);
  Su.setIdentity();
  Sv.setIdentity();
  Su = Su + n * alphau * Omegu;
  Sv = Sv + p * alphav * Omegv;
  
  double Lu, Lv;
  Lu = MatrixXd(Su).eigenvalues().real().maxCoeff() + 0.01;
  Lv = MatrixXd(Sv).eigenvalues().real().maxCoeff() + 0.01;
  
  float thr = 1e-6, indo = 1.0, indu = 1.0, indv=1.0;
  
  MatrixXd Xhat = X;
  MatrixXd utemp, vtemp;
  VectorXd u, v, oldu, oldv, oldui, oldvi, utild, vtild;
  if(startu.sum() == 0){
    Eigen::BDCSVD<MatrixXd> bdc(X, Eigen::ComputeThinU | Eigen::ComputeThinV);
    utemp = bdc.matrixU();
    vtemp = bdc.matrixV();
    u = utemp.col(0);
    v = vtemp.col(0);
  }
  else{
    u = startu;
    v = startv;
  }
  
  int iter = 0;
  
  while(indo < thr && iter < maxit){
    oldui = u;
    oldvi = v;
    while(indu > thr){
      oldui = u;
      utild = u + (Xhat * v - Su * u) / Lu;
      u = soft_thr(utild, lamu/Lu, posu);
      if(u.norm() > 0){
        u = u / std::sqrt(u.transpose() * Su * u);
      }
      else{
        u.setZero(n,1);
      }
      indu = (u - oldui).norm() / oldui.norm();
    }
    
    while(indv > thr){
      oldvi = v;
      vtild = v + (Xhat.transpose() * u - Sv * v) / Lv;
      v = soft_thr(vtild, lamv/Lv, posv);
      if(v.norm() > 0){
        v = v / std::sqrt(v.transpose() * Sv * v);
      }
      else{
        v.setZero(p,1);
      }
      indv = (v - oldvi).norm() / oldvi.norm();
    }
    
    indo = (oldu - u).norm() / oldu.norm() + (oldv - v).norm() / oldv.norm();
    iter = iter + 1;
  }
  
  double d = u.transpose() * Xhat * v;
  return Rcpp::List::create(Rcpp::Named("U") = u / u.norm(),
                            Rcpp::Named("V") = v / v.norm(),
                            Rcpp::Named("d") = d,
                            Rcpp::Named("Xhat") = Xhat - d * u * v.transpose());
}
