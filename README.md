Description
=====================================

This is the code corresponding to the paper Finding Actors and Actions in Movies. Given tracks of people in a movie and a set of weak annotations, it tries to recover person and action identities. The provided tracks correspond to the movie Casablanca.

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
