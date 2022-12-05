# leave these lines alone
.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<

.yrl.erl:
	erlc -W $<

ERL = erl -boot start_clean -noshell

# Here's a list of the erlang modules you want compiling
# If the modules don't fit onto one line add a \ character
# to the end of the line and continue on the next line

# Edit the lines below
MODS = my_make

# The first target in any makefile is the default target.
# If you just type "make" then "make all" is assumed (because
#   "all" is the first target in this makefile)

all: application1

compile: ${MODS:%=%.beam}

## run an application from the makefile

PWD=pwd

application1: compile
	${ERL} -pz ${PWD}  -s my_make tests -s init stop

# remove all the code
clean:
	rm -rf *.beam erl_crash.dump
