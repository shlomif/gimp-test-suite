NAME = seedserve
LIBNAME = lib$(NAME).so
EXENAME = $(NAME)-run
EXE_DEPS = $(LIBNAME) main-run.o
OBJECTS = main-run.o $(NAME).o grand.o

GRAND_LIBNAME = libgrand_$(NAME).so

CFLAGS = -Wall -Werror-implicit-function-declaration -Wstrict-prototypes -Wpointer-arith -g `pkg-config glib-2.0 --cflags`

TARGETS = $(EXENAME) $(LIBNAME) $(GRAND_LIBNAME) 

all: $(TARGETS)

$(OBJECTS) :: %.o : %.c $(NAME).h 
	gcc -c $(CFLAGS) -o $@ $<

$(EXENAME): $(EXE_DEPS)
	gcc -L./.libs -o $@ main-run.o -l$(NAME)
	
$(LIBNAME): $(NAME).o
	libtool --mode=link gcc -shared $(CFLAGS) -o $@ -version-info 0:0:0 $<

$(GRAND_LIBNAME): grand.o $(LIBNAME) 
	libtool --mode=link gcc -shared $(CFLAGS) -o $@ -version-info 0:0:0 $< -l$(NAME)

TEST_VERBOSE = 0

test: $(TARGETS)
	PERL_DL_NONLAZY=1 perl "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE))" test-seedserve.t


