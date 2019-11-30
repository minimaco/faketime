#!/bin/sh

export DYLD_FORCE_FLAT_NAMESPACE=1
export DYLD_INSERT_LIBRARIES=../src/libfaketime.1.dylib

if [ -f /etc/faketimerc ] ; then
	echo "Running the test program with your system-wide default in /etc/faketimerc"
	./timetest
	echo
else
	echo "Running the test program with no faked time specified"
	./timetest
	echo
fi

echo "Running the test program with absolute date 2003-01-01 10:00:05 specified"
echo "FAKETIME=\"2003-01-01 10:00:05\" ./timetest"
FAKETIME="2003-01-01 10:00:05" ./timetest
echo

echo "Running the test program with START date @2005-03-29 14:14:14 specified"
echo "FAKETIME=\"@2005-03-29 14:14:14\" ./timetest"
FAKETIME="@2005-03-29 14:14:14" ./timetest
echo

echo "Running the test program with 10 days negative offset specified"
echo "FAKETIME=\"-10d\" ./timetest"
FAKETIME="-10d" ./timetest
echo

# FAKE_STAT is disabled on macOS by default, so testing NO_FAKE_STAT is not useful
#echo "Running the test program with 10 days negative offset specified, and FAKE_STAT disabled"
#echo "FAKETIME=\"-10d\" NO_FAKE_STAT=1 ./timetest"
#FAKETIME="-10d" NO_FAKE_STAT=1 ./timetest
#echo

echo "Running the test program with 10 days positive offset specified, and sped up 2 times"
echo "FAKETIME=\"+10d x2\" ./timetest"
FAKETIME="+10d x2" NO_FAKE_STAT=1 ./timetest
echo

# On more recent macOS versions, the following won't work without copying gdate
# to a different folder beforehand. We don't do that here, and since the output
# of these tests must be reviewed manually anyway, the timetest binary should be
# sufficient to determine whether everything works as planned.

#echo "Running the 'date' command with 15 days negative offset specified"
#echo "FAKETIME=\"-15d\" date"
#FAKETIME="-15d" date
#echo

exit 0
