today=$(shell date)

csources=$(wildcard *.c)                      
csources1=$(wildcard source_c/*)
csources2=$(notdir $(csources1))
csources3=$(sort $(csources2))
c_objects := $(patsubst %.c, %.o, $(csources3))

# sources from source_f
fsources1=$(wildcard source_f/*)
fsources2=$(notdir $(fsources1))
fsources3=$(sort $(fsources2))
f_objects := $(patsubst %.f, %.o, $(fsources3))

help :
	@printf "$(cyn) usage: make \n"
	@printf "$(cyn) make list $(noc)\n"
	@printf "$(cyn) make compile $(noc)\n"
	@printf "$(cyn) make clean $(noc)\n"


list : showfiles endmake
	@printf "$(cyn) All prereq executed\n"
	@printf "$(red) All rules done. Stop!$(noc)\n"


showfiles:
	@printf " ............................\n"
	@printf " ... csources wildcard \n"
	@printf " ... csources = $(csources) \n"
	@printf " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	@printf " ............................\n"
	@printf " ... csources1 wildcard \n"
	@printf " ... csources1 = $(csources1) \n"
	@printf " ... csources2 notdir \n"
	@printf " ... csources2 = $(csources2) \n"
	@printf " ... csources3 sort \n"
	@printf " ... csources3 = $(csources3) \n"
	@printf " ... c_objects patsubst \n"
	@printf " ... c_objects = $(c_objects) \n"
	@printf " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	@printf " ............................\n"
	@printf " ... fsources1 wildcard \n"
	@printf " ... fsources1 = $(fsources1) \n"
	@printf " ... fsources2 notdir \n"
	@printf " ... fsources2 = $(fsources2) \n"
	@printf " ... fsources3 sort \n"
	@printf " ... fsources3 = $(fsources3) \n"
	@printf " ... f_objects patsubst \n"
	@printf " ... f_objects = $(f_objects) \n"
	@printf " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	@printf "\n"


# Search paths for sources and objects
vpath %.c source_c
vpath %.f source_f
vpath %.o obj

# default
compile: compile_c

compile_c: $(c_objects)
compile_f: $(f_objects)


# ---- Pattern rules ----

# From source_c: build .o from .c
%.o : %.c
	@printf " ::: compile (.c) source name %-22s ..... target is %s \n" "$<" "$@"
	touch obj/$@ ; ls -l obj/$@ ; sleep 1s
	@printf " /  / / / / / / / / / / / / / / / / / / /\n\n"

# From source_f: build .o from .f
%.o : %.f
	@printf " ::: compile (.f) source name %-22s ..... target is %s \n" "$<" "$@"
	touch obj/$@ ; ls -l obj/$@ ; sleep 1s
	@printf " /  / / / / / / / / / / / / / / / / / / /\n\n"


clear : clean
clean:
	rm -fv bin/* obj/*


endmake:
	@printf "................................\n"
	@printf "... today is: $(today) \n"
	@printf "... today is: $(shell date) \n"
	@printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"
	@printf "...............................\n"
	@printf "\n" ⁠
