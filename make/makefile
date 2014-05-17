TOPDIR = ..

FC = gfortran
LOAD_PGPLOT = `mesasdk_pgplot_link`

FCbasic = -fno-range-check -fmax-errors=100 $(SPECIAL_FC_FLAGS) -fprotect-parens -fno-sign-zero
# -Warray-temporaries
 
FCimpno = -fimplicit-none  
FCchecks = -fbounds-check -Wuninitialized -Warray-bounds
FCwarn = -Wunused-value -Werror -W -Wno-compare-reals -Wno-unused-parameter
# -Wno-unused-parameter
 
# note: -Werror causes warnings to be treated as errors
FC_fixed_preprocess = -x f77-cpp-input
FC_free_preprocess = -x f95-cpp-input
FCfixed = -ffixed-form -ffixed-line-length-132 $(FC_fixed_preprocess)
FCfixed72 = -ffixed-form $(FC_fixed_preprocess)
FCfree = -ffree-form $(FC_free_preprocess)
FCopt = -O2
FCdebug = -g

COMPILE_BASIC_FLAGS = $(FCbasic) $(INCLUDES)
COMPILE_BASIC = $(FC) $(COMPILE_BASIC_FLAGS)
COMPILE_TO_TEST   = $(COMPILE_BASIC) $(FCwarn) $(FCimpno) $(FCchecks) $(FCopt) $(FCfree) $(FCdebug) -c

COMPILE = $(COMPILE_TO_TEST)
LOADER = $(FC)

VPATH = $(TOPDIR)/source
INCLUDES = -I$(TOPDIR)/source
OBJS = pg_support.o run.o

default: run_test

%.o: %.f
	$(COMPILE) $<
	
run_test: $(OBJS)
	$(LOADER) -o $@ $(OBJS) $(LOAD_PGPLOT)

clean:
	rm -f *.o run_test
