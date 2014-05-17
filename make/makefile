include $(MESA_DIR)/utils/makefile_header

LIB = libpgtest.a
LIB_OBJS = pg_plots.o

COMPILE = $(COMPILE_TO_TEST) $(FCfree)
VPATH = $(MOD_PUBLIC_DIR):$(MOD_PRIVATE_DIR)

$(LIB): $(LIB_OBJS)
	$(LIB_TOOL) $(LIB) $(LIB_OBJS)

%.o: %.f
	$(COMPILE) $<

clean:
	-@rm -f *.o *.mod *.a
