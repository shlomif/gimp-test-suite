noinst_PROGRAMS = grand-test-good grand-test-experiment seedserve-run
grand_test_good_SOURCES = grand-test-good.c
grand_test_experiment_SOURCES = grand-test-experiment.c
seedserve_run_SOURCES = main-run.c
seedserve_run_LDADD = libseedserve.la

lib_LTLIBRARIES = libseedserve.la libgrand_seedserve.la
libseedserve_la_SOURCES = seedserve.c
libseedserve_la_LDFLAGS = -version-info 0:0:0
libseedserve_includedir=$(includedir)
libseedserve_include_HEADERS = seedserve.h

libgrand_seedserve_la_SOURCES = grand.c
libgrand_seedserve_la_LDFLAGS = -version-info 0:0:0
libgrand_seedserve_la_LIBADD = libseedserve.la

grand-test-output.good.txt: grand-test-good
	./grand-test-good > grand-test-output.good.txt

INCLUDES = $(GLIB_CFLAGS)
LDADD = $(GLIB_LIBS)

EXTRA_DIST = test-grand.t test-seedserve.t temp/meaningless.txt

test: seedserve-run libgrand_seedserve.la libseedserve.la grand-test-output.good.txt grand-test-experiment
	PERL_DL_NONLAZY=1 perl "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE))" test-seedserve.t test-grand.t

