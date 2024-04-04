#CXX = g++
#CXXFLAG = -Wall -g -o
ROOTOPTS = `root-config --cflags`
ROOTLIBS = `root-config --libs`
CPPOPTS  = -g
#LIBS     = $(ROOTLIBS)

#configure: configure.cc stib.cc stib.hh
#	g++ $(ROOTOPTS) -o configure configure.cc stib.cc $(LIBS)
#make10b8b : make10b8b.cc
#	g++ -g -o make10b8b make10b8b.cc
#test10b8b : test10b8b.cc
#	g++ -g -o test10b8b test10b8b.cc

all: poke peek amc502_mux amc502_pll 

poke : poke.cc stib.hh stib.cc
	g++ -g -o poke poke.cc stib.cc
peek : peek.cc stib.hh stib.cc
	g++ -g -o peek peek.cc stib.cc

amc502_mux : amc502_mux.cc amc502.hh amc502.cc stib.hh stib.cc
	g++ -g -o amc502_mux amc502_mux.cc amc502.cc stib.cc
amc502_pll : amc502_pll.cc amc502.hh amc502.cc stib.hh stib.cc
	g++ -g -o amc502_pll amc502_pll.cc amc502.cc stib.cc


clean : 
	rm poke peek amc502_mux amc502_pll 
