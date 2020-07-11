# Driver    Julia Sales
# Navigator Anthony Overton
# Group 44-3, 10/17/2019
# Final Project - Type B
# pyRun_project.py
"""
Resources used: HW6, Example code from AM129 Newton Root files, Class Notes

Directory structure:
   Homework/

   Project/code/fortran/
                        |-- makefile
                        |   main.F90
                        |   euler.F90
               /pyRun/
                        | pyRun_project.py  
"""

#import some necessary Python modules
import numpy as np
import math as mt
import matplotlib.pyplot as plt
import sys
import os

def make_make():
    exist = os.path.exists('../fortran/main.exe')
    # 1. Compile the Fortran code if has not been compiled
    #    (i.e., if 'main.exe' does not exist yet)
    if exist is False:
        os.chdir('../fortran')
        os.system('make')
    # 2. Otherwise do "make clean" first and then "make"
    elif exist is True:
        os.chdir('../fortran')
        os.system('make clean')
        os.system('make')

def run_main():
    # This routine executes the Fortran excutable, "main.exe"
    # using "runtime_pars.init" you just created.
    os.chdir('../fortran')
    os.system('./main.exe')

def error(t_N, num_N, N):
    real_sol = [None] * N
    solution = 0
    result = 0
    
    for i in range(0, N, 1):
        real_sol[i] = -1 * mt.sqrt(2 * np.log(((t_N[i])*(t_N[i])) + 1) +4)  

    for j in range(0, N, 1):
        solution = abs(real_sol[j] - num_N[j]) + solution

    result = (1/float(N)) * solution
    return result

def plot_data(title_name, real_sol, num_N, t_N, N):
    fmt_real = 'o--r'
    fmt_num = '-b'

    plt.title('Calculated Error: ' + str(title_name))
    plt.xlabel('t axis')
    plt.ylabel('y axis')
    plt.grid(color='#808080', linestyle='-', linewidth=0.5)
    plt.plot(t_N, num_N, fmt_real, linewidth=1)
    plt.plot(t_N, real_sol, fmt_num, linewidth=1)
    plt.show()
    plt.savefig('result_'+str(N)+'.png')


if __name__ == '__main__':

    N = [8, 16, 32, 64]
   
    make_make()
    run_main()

    length = len(N)
    for i in range(0, length, 1):
        array_N = np.loadtxt('output_'+str(N[i])+'.dat')
        t_N = np.loadtxt('output_'+str(N[i])+'.dat', usecols=(1,))
        num_N = np.loadtxt('output_'+str(N[i])+'.dat', usecols=(2,))
        title_name = error(t_N, num_N, N[i])

        #real_sol = [None] * N[i]
        real_sol = np.empty(N[i]+1)
        for j in range(0, N[i]+1, 1):
            real_sol[j] = -1 * mt.sqrt(2 * np.log(((t_N[j])*(t_N[j])) + 1) +4)
   
        plot_data(title_name, real_sol, num_N, t_N, N[i])

        




