"""Trace h et u pour la condition initiale et le résultat final.

Usage : python3 trace.py            (lit init.dat et final.dat)
        python3 trace.py a.dat b.dat ...
        python3 trace.py final.dat exacte.dat   (solution exacte en pointillés)
Colonnes des fichiers : x, h, u, h+z, z (ligne d'en-tête commençant par #).
"""
import sys
import numpy as np
import matplotlib.pyplot as plt

fichiers = sys.argv[1:] or ["init.dat", "final.dat"]

fig, (ax_h, ax_u) = plt.subplots(2, 1, sharex=True, figsize=(8, 6))

for nom in fichiers:
    x, h, u, H, z = np.loadtxt(nom, unpack=True)   
    style = dict(color="k", linestyle="--", linewidth=1.2) if "exact" in nom else {}
    ax_h.plot(x, H, label=f"{nom} : surface h+z", **style)
    ax_u.plot(x, u, label=nom, **style)

ax_h.fill_between(x, z.min() - 0.05, z, color="0.7", label="fond z")

ax_h.set_ylabel("h + z (m)")
ax_u.set_ylabel("u (m/s)")
ax_u.set_xlabel("x (m)")
for ax in (ax_h, ax_u):
    ax.grid(True, alpha=0.3)
    ax.legend()

fig.suptitle("Saint-Venant 1D : rupture de barrage")
fig.tight_layout()
fig.savefig("resultats.png", dpi=150)
plt.show()

