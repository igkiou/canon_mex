MATLABDIR = "/cygdrive/c/Program Files (x86)/MATLAB/R2013b"
ESDSKDIR = "/home/igkiou/canon_edsdk2.13/EDSDK"

MATLABARCH = win32
MEXEXT = $(shell $(MATLABDIR)/bin/mexext.bat)

#MATLABLIBS = -L$(MATLABDIR)/bin/$(MATLABARCH) -lmx -lmex -lmat
MATLABLIBS = -L$(MATLABDIR)/bin/$(MATLABARCH) -lmex -lmx -lmwlapack -lmwblas 
#ESDSKLIBS = 
ESDSKLIBS = -L$(ESDSKDIR)/Dll/ -lDPPDLL -lDPPLibCom -lDPPRSC -lEDSDK -lEdsImage -lMlib -lUcs32P
MAPFILE = $(MATLABDIR)/extern/lib/$(MATLABARCH)/mex.def
#MAPFILE = mex.def

MATLABINCLUDE = -I$(MATLABDIR)/extern/include
ESDSKINCLUDE = -I$(ESDSKDIR)/Header
INCLUDES = $(MATLABINCLUDE) $(ESDSKINCLUDE)

#CC = x86_64-w64-mingw32-g++
CC = i686-w64-mingw32-g++
MEXFLAGS = -DMX_COMPAT_32 -fexceptions
GENERALFLAGS = -W -Wall -Wextra -pedantic
OPTIMFLAGS = -O3
REPORTSFLAGS = -Winline -Wimplicit
DEBUGFLAG = -g
ifdef DEBUG_MODE
	CFLAGS = $(DEBUGFLAG) $(MEXFLAGS) $(GENERALFLAGS) $(OPTIMFLAGS) 
else
	CFLAGS = $(MEXFLAGS) $(GENERALFLAGS) $(OPTIMFLAGS)
	ifdef PRODUCE_REPORTS
		CFLAGS += $(REPORTSFLAGS) 
	endif
endif 

LDFLAGS = -O3 -static-libgcc -static-libstdc++ -shared $(MAPFILE) $(MATLABLIBS) $(ESDSKLIBS)  