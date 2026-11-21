FC     = gfortran
FFLAGS = -O2 -Wall -fcheck=all

OBJS = mod_parametres.o mod_cas_test.o mod_VF.o mod_sortie.o main.o

run: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

%.o: %.f90
	$(FC) $(FFLAGS) -c $<

%.o: %.F90
	$(FC) $(FFLAGS) -c $<

cas_test.o: mod_parametres.o
VF.o:       mod_parametres.o
sortie.o:   mod_parametres.o
main.o:     mod_parametres.o mod_cas_test.o mod_VF.o mod_sortie.o

clean:
	rm -f *.o *.mod run final.dat *.png
