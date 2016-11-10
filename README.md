#STAT 159 - fall-2016 project 2

This repository holds the second project for the fall 2016 Statistics 159 at UC Berkeley.

This assignment is about applying the computational toolkit (plus R) to reproduce regression analysis collaboratively in teams of two members. More specifically, the idea is to reproduce the analysis from sections 6.2, 6.3, 6.6 and 6.7 in Chapter 6:*Linear Model Selection and Regularization*, from the book "An introduction to Statistical Learning" (by James et at) at http://www-bcf.usc.edu/~gareth/ISL/.

In this repository 
```
stat159-project2/
	.gitignore
	README.md
	LICENSE
	Makefile
	session-info.txt
	session.sh                    
	code/
		README.md
	  	...
	  	functions/
	  		...
	  	scripts/
	  		...
	  	tests/
	  		...
	data/
		...
	images/
		...
	report/
		report.Rmd
		report.pdf
		sections/
			...
```

###For a "competent" user: if you want to recreate our analysis and report, you can:
1. git clone the repository or download it.
2. In your terminal,`cd` into directory
3. Run the Makefile in terminal by typing command `make clean` in order to remove old report
4. Type `make` in terminal again and then it will execute all scripts and get all output such as `report.pdf`.

### List of Make commands for phony targets

- `all:` will be associated to phony targets `eda`, `regressions`, and `report`
- `data:` will download the file `Credit.csv` to the folder `data/` 
- `tests:` will run the unit tests of your functions
- `eda:` will perform the exploratory data analysis
- `ols`: OLS regression
- `ridge`: Ridge Regression
- `lasso`: Lasso Regression
- `pcr`: Principal Components Regression
- `plsr`: Partial Least Squares Regression
- `regressions`: all five types of regressions
- `report:` will generate `report.pdf` (or `report.html`)
- `slides`: will generate `slides.html`
- `session`: will generate `session-info.txt`
- `clean:` will delete the generated report (pdf and/or html)


Author: Xinyu Zhang, Zhongling Jiang

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>. 

All source code (i.e. code in R script files) is licensed under GNU General Public License, version 3. See the LICENSE file for more information




