include $(MESA_DIR)/utils/makefile_header

LIB = libpggrid.a
LIB_OBJS = pggrid_def.o pg_support.o pg_io.o pg_plots.o pggrid_lib.o

COMPILE = $(COMPILE_TO_DEPLOY) $(FCfree) -I../defaults
VPATH = $(MOD_PUBLIC_DIR):$(MOD_PRIVATE_DIR)

$(LIB): $(LIB_OBJS)
	$(LIB_TOOL) $(LIB) $(LIB_OBJS)

%.o: %.f
	$(COMPILE) $<

clean:
	-@rm -f *.o *.mod *.a
