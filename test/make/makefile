include $(MESA_DIR)/utils/makefile_header

LIB_NAME = pggrid
LIB_FILENAME = lib$(LIB_NAME).a

LOAD_LOCAL = -L$(LOCAL_LIB_DIR) -l$(LIB_NAME)
LOAD_OTHER = -L$(MESA_LIB_DIR) -lutils $(LOAD_PGPLOT)

TESTER = run_test
TEST_OBJS = run_test.o

COMPILE = $(TEST_COMPILE) $(FCfree)

VPATH = $(TEST_SRC_DIR)


%.o: %.f
	$(COMPILE) $<

default: install

$(TESTER): $(TEST_OBJS) $(LOCAL_LIB_DIR)/$(LIB_FILENAME)
	$(LOADER) $(FCbasic) $(FCopenmp) $(FCstatic) -o $@ $(TEST_OBJS) $(LOAD_LOCAL) $(LOAD_OTHER)
	
show_layout: boxes.o $(LOCAL_LIB_DIR)/$(LIB_FILENAME)
	$(LOADER) $(FCbasic) $(FCopenmp) $(FCstatic) -o $@ boxes.o $(LOAD_LOCAL) $(LOAD_OTHER)

show_legend_layout: boxes_legends.o $(LOCAL_LIB_DIR)/$(LIB_FILENAME)
	$(LOADER) $(FCbasic) $(FCopenmp) $(FCstatic) -o $@ boxes_legends.o $(LOAD_LOCAL) $(LOAD_OTHER)

chk_pgplot: ck_pgplot.o
	$(LOADER)  $(FCbasic) $(FCopenmp) $(FCstatic) -o $@ ck_pgplot.o $(LOAD_PGPLOT)

install: $(TESTER) show_layout show_legend_layout
	cp $? $(TEST_DIR)

clean:
	-@rm -f *.o *.mod $(TESTER) show*_layout
