NAME = seedserve
LIBNAME = lib$(NAME).so
EXENAME = $(NAME)-run
EXE_DEPS = $(NAME).o main-run.o
OBJECTS = $(EXE_DEPS)

CFLAGS = -Wall -Werror-implicit-function-declaration -Wstrict-prototypes -Wpointer-arith -g

TARGETS = $(EXENAME)

all: $(TARGETS)

$(NAME).c : $(NAME).h

$(OBJECTS) :: %.o : %.c 
	gcc -c $(CFLAGS) -o $@ $<

$(EXENAME): $(EXE_DEPS)
	gcc -o $@ $(EXE_DEPS)
	
# $(LIBNAME): $(NAME).o
	
TEST_VERBOSE = 0

test: $(TARGETS)
	PERL_DL_NONLAZY=1 perl "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE))" test-seedserve.t


