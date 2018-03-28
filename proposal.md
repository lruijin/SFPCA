## Project info

**Project title**: R project in Google Summer of Code - MoMA: Modern Multivariate Analysis in R

**Project short title** (30 characters): MoMA in R

**URL of project idea page**: https://github.com/rstats-gsoc/gsoc2018/wiki/MoMA:-Modern-Multivariate-Analysis-in-R

## Bio of Me

I'm a current Ph.D student in Statistics from Virginia Tech. My research interest lies in functional data analysis, functional data testing and the applications in engineering and neuroscience. My past works concern more with the theoretical side. So I'm trying to practice more in coding skills.

## Contact Information 

**Student name**: Ruijin Lu

**Student postal address**: 612 Green Street, Blacksburg, VA, 24060

**Telephone**: (540)-998-5999

**Email**: lruijin@vt.edu


## Student affiliation

**Institution**: Virginia Polytechnic Institute and State University(Virginia Tech)

**Program**: PhD. in Statistics

**Stage of completion**:  4th year

**Contact to verify**: Hongxiao Zhu(hongxiao@vt.edu)(Advisor)

## Schedule Conflicts:

None

## Mentors

- Genevera Allen (gallen@rice.edu): Theory and Algorithms

  Departments of Statistics, CS, and ECE, Rice University

  Jan and Dan Duncan Neurological Research Institute, Baylor College of Medicine and Texas Children's Hospital

- Michael Weylandt (michael.weylandt@rice.edu): Implementation

  Department of Statistics, Rice University

Have you been in touch with the mentors? When and how? Yes. Mar 27 through e-mail.



## Coding Plan and Methods

The main idea for modern multivariate analysis is to reduce the dimension of data. Based on the repeated proximal gradient algorithm scheme proposed by Beck and Teboulle, we could generalize it with options applied on the left singular vectors, right singular vectors or both to achieve the goal of dimension reduction.

According to the coding plan details provided by the mentors, this project will be divided into three phases:

### Phase I: core MoMA algorithm

Create the functions to incorporate the following options for the right singular vectors, or the left singular vectors or both:
- Sparsity-induced penalization: L1, Smoothly Clipped Absolute Deviation(SCAD), and MCP(Minimax Concave Penalty)
- Generalized version of Lasso: Group Lasso(which incorporates selection of groups of factors or basis functions), fused lasso(regularize the vector itself and also its successive differences)and Convex clustering penalty(The objective function is the same as the fused lasso but the penalty term is different, apply ADMM to solve the optimal u)
- Add Smoothing and Orthogonalization options to the functions
- Add Non-negativity constraint choice to the functions

### Phase II: PCA, PLS, CCA and LDA wrapper:

- Write the method wrappers incorporating different core algorithms. 
- Write individual functions to do Cross-validation and calculate BIC or extended BIC
- Add parameter-tuning options to the wrappers to determine the parameter and plot out related selection plots, such as BIC as a function to lam or n-fold Cross-validation error as a function to lam

### Phase III: add Vignette to the package:

- add necessary plotting options to better visualize the result.
- For the neuroscience data, apply the package as a motivation example
- With an example simulated data to illustrate the usage of the functions in the package
- Write the documentations 

Note: the package will be developed on Ubuntu 16.04 platform with Eigen-3.3.4 and R-3.3.4

## Timeline

Apr. 14 - May 14: get familiar with the algorithms and write down the step-by-step diagram for each core algorithm. Learn more about the organization's community.

### May 14 ~ Jun 17: Finish coding and documenting of the core algorithms

- May 14 ~ May 20: Create functions on vectors with L1, SCAD and MCP penalties, write documentation, generate testing matrix as an example and test
- May 21 ~ May 27: Code functions with group sparsity and fused lasso, write documentation, and test with the example
- May 28 ~ Jun 3: Add smoothing options and nonnegativity options, write documentation, and test with the example
- Jun 4 ~ Jun 10: Code functions with Convex Clustering penalty, write documentation and test with example
- Jun 11 ~ Jun 17: fix and documentation 

### Jun 18 ~ Jul 22: Wrapper and parameter selection

- Jun 18 ~ 24: PCA wrapper and EBIC & BIC helper: test the helper function calculate the correct value and the PCA wrapper works for an easy example.
- Jun 25 ~ Jul 1: Incorporate EBIC selection option into PCA wrapper, make the related plots and test the result.
- Jul 2 ~ 8: Cross-validation helper function and CCA, PLS, LDA wrappers, test the helper function and check wrapper result.
- Jul 9 ~ 15: Incorporate Cross-validation option into CCA, PLS, LDA wrapper and test
- Jul 16 ~ 22: fix, make related plot and documentation 

### Jul 23 ~ Aug 12: Documentation, Vignette and Polishing

- Jul 23 ~ 29 Functional level Documentation. Organize the generated example for testing before, unify and create timing vignette.
- Jul 30 ~ Aug 5 Apply the functions develop to neuroscience example and create the vignette.
- Aug 6 ~ 12 GitHub page + `pkgdown` documentation and correct typos.

### Questions and Answers:

- Q: What is your contingency plan for things not going to schedule? We understand things change, but how are you planning to address changes and setbacks?

    A: I can guarantee an at least 30 hours per week working on the project to make sure it is in smooth progress. If there's any emergency issue, I will contact the mentor and make sure that each month goal is achieved.

- Q: If you have other time commitments that will interfere with GSoC, we highly recommend explaining how you will front-load the work before coding start or work extra early on to build a cushion!

    A: The duty of my own for the summer is to write my Ph.D thesis. There's very little time conflict with this project.


## Management of Coding Project

- How do you propose to ensure code is submitted / tested?
There is always a main function in another file, acting as a checker. Whenever a new function is developed, it will be checked in the main function to make sure that it returns the correct result. 

- How often do you plan to commit?  What changes in commit behavior would indicate a problem?
I will commit at least once a day. If there're two days or more without any commit behavior, then I am stuck on a problem.

