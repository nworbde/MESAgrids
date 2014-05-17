include $(MESA_DIR)/utils/makefile_header

LOAD_LOCAL = -L$(LOCAL_LIB_DIR) -lpgtest
LOAD_OTHER = $(LOAD_PGPLOT)

TESTER = run_test
TEST_OBJS = run_test.o

COMPILE = $(TEST_COMPILE) $(FCfree)

VPATH = $(TEST_SRC_DIR)


%.o: %.f
	$(COMPILE) $<

default: install

$(TESTER): $(TEST_OBJS) $(LOCAL_LIB_DIR)/libpgtest.a
	$(LOADER) -o $@ $(TEST_OBJS) $(LOAD_LOCAL) $(LOAD_OTHER)
	
install: $(TESTER)
	cp $? $(TEST_DIR)

clean:
	-@rm -f *.o *.mod $(TESTER)
