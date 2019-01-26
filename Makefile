
GUI=SDL

CFLAGS=-Wall -Wextra -g
LDFLAGS=-lm


SRCDIR=src
OBJDIR=src/obj
DEPDIR=src/dep



SRC=$(wildcard $(SRCDIR)/*.c)
OBJ=$(subst $(SRCDIR),$(OBJDIR),$(SRC:.c=.o)) $(OBJDIR)/$(GUI).o
DEP=$(subst $(SRCDIR),$(DEPDIR),$(SRC:.c=.d))


ifeq ($(GUI),SDL)	# SDL
  LDFLAGS += -lSDL2
else
  ifeq ($(GUI),fb)	# Framebuffer
    ;
  else			# ???
    $(error "unknown GUI type")
  endif
endif



DOOM : $(OBJ)
	$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@


include $(DEP)



$(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) -c $< $(CFLAGS) $(LDFLAGS) -o $@

$(OBJDIR)/$(GUI).o : $(SRCDIR)/gui/$(GUI).c
	$(CC) $< -c $(CFLAGS) $(LDFLAGS) -o $@


$(DEPDIR)/%.d : $(SRCDIR)/%.c
	$(CC) $^ -MM -MT $(subst $(DEPDIR),$(OBJDIR),$(@:.d=.o)) -MF $@


.PHONY: clean
clean:
	@rm -f DOOM $(OBJ) $(DEP)

