FC     = gfortran
FFLAGS = -O2 -Wall -fcheck=all

OBJS = mod_parametres.o mod_cas_test.o mod_VF.o mod_solution_exacte.o mod_sortie.o main.o

run: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

%.o: %.f90
	$(FC) $(FFLAGS) -c $<

%.o: %.F90
	$(FC) $(FFLAGS) -c $<

# dépendances entre modules
mod_cas_test.o:        mod_parametres.o
mod_VF.o:              mod_parametres.o
mod_solution_exacte.o: mod_parametres.o
mod_sortie.o:          mod_parametres.o
main.o:                mod_parametres.o mod_cas_test.o mod_VF.o mod_solution_exacte.o mod_sortie.o

clean:
	rm -f *.o *.mod run final.dat init.dat exacte.dat *.png
