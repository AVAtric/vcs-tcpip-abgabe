##
## @file Makefile
## VCS_TCP/IP Makefile.
##
## @author Robert Hofman <ic18b081@technikum-wien.at>
## @author Adnan Vatric <ic17b503@technikum-wien.at>
## @date 10.12.2018
##
## @version 1.0
##

##
## ------------------------------------------------------------- variables --
##

CC=gcc
CFLAGS=-Wall -Werror -Wextra -Wstrict-prototypes -pedantic -fno-common -O3 -g -std=gnu11
LDFLAGS=
CP=cp
CD=cd
MV=mv
MKDIR=mkdir
GREP=grep
DOXYGEN=doxygen

CLIENTOBJECTS=simple_message_client.o
SERVEROBJECTS=simple_message_server.o

EXCLUDE_PATTERN=footrulewidth

##
## ----------------------------------------------------------------- rules --
##

%.o: %.c
	$(CC) $(CFLAGS) -c $<

##
## --------------------------------------------------------------- targets --
##

all: simple_message_server simple_message_client

simple_message_client: $(CLIENTOBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ /usr/local/lib/libsimple_message_client_commandline_handling.a

simple_message_server: $(SERVEROBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ 

clean:
	$(RM) *.o *~ simple_message_server simple_message_client *.png *.html documentation.pdf \
	$(RM) -r doc 

distclean: clean

doc: html pdf cleandocs

html:
	$(DOXYGEN) doxygen.dcf

pdf: html
	$(CD) doc/pdf && \
	$(MV) refman.tex refman_save.tex && \
	$(GREP) -v $(EXCLUDE_PATTERN) refman_save.tex > refman.tex && \
	$(RM) refman_save.tex && \
	make && \
	$(MV) refman.pdf refman.save && \
	$(RM) *.pdf *.html *.tex *.aux *.sty *.log *.eps *.out *.ind *.idx \
	      *.ilg *.toc *.tps Makefile && \
	$(MV) refman.save refman.pdf \

cleandocs:
	$(MV) doc/pdf/refman.pdf ./documentation.pdf && \
	$(RM) -r doc/pdf
##
## ---------------------------------------------------------- dependencies --
##

##
## =================================================================== eof ==
##

