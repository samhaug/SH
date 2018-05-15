# include $(HOME)/etc/Makerules_sun
# LIB =libdist_sun

MYLIB =  $(LIBDIR)
LIB =libdist

.c.a:
	gcc -c $<
	ar rv $@ $*.o
	rm -f $*.o


$(LIBDIR)/$(LIB).a: \
	$(LIBDIR)/$(LIB).a(distaz.o) \
	$(LIBDIR)/$(LIB).a(distaz2latlon.o)

#include $(HOME)/etc/Makeranlib
