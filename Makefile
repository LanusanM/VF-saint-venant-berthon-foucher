FC     = gfortran
FFLAGS = -O2 -Wall -fcheck=all

OBJS = parametres.o cas_test.o VF.o sortie.o main.o

run: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

%.o: %.f90
	$(FC) $(FFLAGS) -c $<

%.o: %.F90
	$(FC) $(FFLAGS) -c $<

cas_test.o: parametres.o
VF.o:       parametres.o
sortie.o:   parametres.o
main.o:     parametres.o cas_test.o VF.o sortie.o

clean:
	rm -f *.o *.mod run