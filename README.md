Description
=====================================

This is the code corresponding to the paper Finding Actors and Actions in Movies. Given tracks of people in a movie and a set of weak annotations, it tries to recover person and action identities. The provided tracks correspond to the movie Casablanca.

Dependencies
=====================================

This code relies on two optimization toolboxes.

You will need the 7th version of the MOSEK optimization toolbox and a valid license. It can be downloaded from : 
http://mosek.com/resources/download/

You will also need the CVX optimization toolbox v2.0. We used build 937. This toolbox can be downloaded from :
http://cvxr.com/cvx/download/

References
=====================================

Runing the code
=====================================

To run it you will need to install the latest CVX and MOSEK libraries. Once installed please replace in main.m :

- The path to the CVX setup script.
- The path to the MOSEK matlab toolbox.
- The path to the MOSEK licence files.

Of course, MOSEK needs to be correctly set up, with the system library paths correctly set. 

You also have to provide the path to the data file (data.mat). 

To run simply type :

```
>> main
```

in the MATLAB comand prompt. 
