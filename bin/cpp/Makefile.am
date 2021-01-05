#bin_PROGRAMS = GenRealTimeData
#GenRealTimeData_SOURCES = src/GetRealTimeData.cpp
#SUBDIRS = src


SUBDIRS = src

# Note: specifying output into a different directory
bin_PROGRAMS = build/SNCT_GenRealTimeData

# Note the form of the following names:
build_SNCT_GenRealTimeData_SOURCES = src/GenRealTimeData.cpp src/Chameleon.cpp  src/ConfigFile.cpp 
build_SNCT_GenRealTimeData_CPPFLAGS = -I$(srcdir)/scr
# Note that library order matters
#build_hello_LDADD = HelloWorld/Dog/libDog.a Pet/libPet.a
