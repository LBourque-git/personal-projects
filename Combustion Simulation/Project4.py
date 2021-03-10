# -*- coding: utf-8 -*-
"""
Created on Fri Dec 18 22:00:59 2020

@author: Louis
Adapted from SDT toolbox demo ZNDshk
"""
from sdtoolbox.postshock import PostShock_fr
from sdtoolbox.znd import zndsolve
from sdtoolbox.utilities import znd_plot
import cantera as ct
import numpy as np


P1 = 101325 
T1 = 298
U1 = 1798.244 #From CEA and SDT toolbox
q = 'CO:2 O2:1'
mech = '3step_mod.cti'

# Set up gas object
gas1 = ct.Solution(mech)
gas1.TPX = T1,P1,q

# Find post shock state for given speed
gas = PostShock_fr(U1, P1, T1, q, mech)

# Solve ZND ODEs, make ZND plots
znd_out = zndsolve(gas,gas1,U1,t_end=1e-3,advanced_output=True)
znd_plot(znd_out,major_species = 'All')


print('Reaction zone pulse width (exothermic length) = %.4g m' % znd_out['exo_len_ZND'])
print('Reaction zone induction length = %.4g m' % znd_out['ind_len_ZND'])
print('Reaction zone pulse time (exothermic time) = %.4g s' % znd_out['exo_time_ZND'])
print('Reaction zone induction time = %.4g s' % znd_out['ind_time_ZND'])