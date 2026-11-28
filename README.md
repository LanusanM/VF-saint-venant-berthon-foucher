# VF-saint-venant-berthon-foucher

Schéma de Berthon-Foucher pour Saint-Venant avec topographie, en 1D puis 2D. Fortran 90.

## Compilation et exécution
```bash
make
./run
python3 trace_solution.py final.dat exacte.dat
```

## Fichiers
- `main.f90` : programme principal
- `mod_*.f90` : modules (paramètres, cas-tests, schéma VF, solution exacte, sorties)
- `donnees.dat` : paramètres du calcul
- `trace_solution.py`, `trace_convergence.py` : tracés (numpy, matplotlib)