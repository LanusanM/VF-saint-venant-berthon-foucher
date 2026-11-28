"""Trace la courbe de convergence (erreur L1 en fonction du maillage).

Usage : python3 convergence.py                 (lit erreur1D.txt)
        python3 convergence.py mon_fichier.txt

Format attendu : deux colonnes, une ligne par calcul (lignes '#' ignorées)
    Nx   erreur          (nombre de mailles)
ou  dx   erreur          (pas d'espace, détecté si la 1re colonne est < 1)
"""
import sys
import numpy as np
import matplotlib.pyplot as plt

nom = sys.argv[1] if len(sys.argv) > 1 else "erreur1D.txt"
data = np.loadtxt(nom, ndmin=2)
col, err = data[:, 0], data[:, 1]

# On travaille avec dx : si la 1re colonne contient Nx, dx est proportionnel à 1/Nx
en_dx = np.all(col < 1.0)
dx = col if en_dx else 1.0 / col
ordre = np.argsort(dx)[::-1]            # du plus grossier au plus fin
dx, err, col = dx[ordre], err[ordre], col[ordre]

# Ordre observé entre deux maillages successifs : p = ln(e1/e2) / ln(dx1/dx2)
print(f"{'dx' if en_dx else 'Nx':>10} {'erreur L1':>14} {'ordre':>8}")
for k in range(len(err)):
    p = "" if k == 0 else f"{np.log(err[k-1]/err[k]) / np.log(dx[k-1]/dx[k]):8.3f}"
    print(f"{col[k]:>10g} {err[k]:>14.6e} {p:>8}")

# Ordre global par régression linéaire en échelle log-log
pente = np.polyfit(np.log(dx), np.log(err), 1)[0]
print(f"\nOrdre moyen (régression log-log) : {pente:.3f}")

# Tracé
fig, ax = plt.subplots(figsize=(6, 4.5))
x_trace = dx if en_dx else col
ax.loglog(x_trace, err, "o-", label=f"erreur L1 (ordre ≈ {pente:.2f})")

# Droites de référence d'ordre 1 et 1/2, passant par le premier point
ref = err[0] * (dx / dx[0])
ax.loglog(x_trace, ref, "k" , linewidth=1, label=f"pente d'ordre {1}")

ax.set_xlabel("dx" if en_dx else "Nx (nombre de mailles)")
ax.set_ylabel("erreur L1 sur h")
ax.set_title("Convergence : rupture de barrage 1D")
ax.grid(True, which="both", alpha=0.3)
ax.legend()
fig.tight_layout()
fig.savefig("convergence.png", dpi=150)
plt.show()
