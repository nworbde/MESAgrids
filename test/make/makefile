include $(MESA_DIR)/utils/makefile_header

LIB_NAME = pggrid
LIB_FILENAME = lib$(LIB_NAME).a

LOAD_LOCAL = -L$(LOCAL_LIB_DIR) -l$(LIB_NAME)
LOAD_OTHER = $(LOAD_PGPLOT)

TESTER = run_test
TEST_OBJS = run_test.o

COMPILE = $(TEST_COMPILE) $(FCfree)

VPATH = $(TEST_SRC_DIR)


%.o: %.f
	$(COMPILE) $<

default: install

$(TESTER): $(TEST_OBJS) $(LOCAL_LIB_DIR)/$(LIB_FILENAME)
	$(LOADER) -o $@ $(TEST_OBJS) $(LOAD_LOCAL) $(LOAD_OTHER)
	
install: $(TESTER)
	cp $? $(TEST_DIR)

clean:
	-@rm -f *.o *.mod $(TESTER)
