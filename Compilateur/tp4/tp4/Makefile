#		TP3. Analyse lexicale et syntaxique
#		    ascendante, ocamllex et ocamlyacc
#
#	Makefile donne a titre d'exemple
#
#
# Historique:
#	17 Nov. 08		Par : Laurent Hubert
#	03 Oct. 08		Par : Benoit Boyer
#


GEN_MLI= $(subst .mly,.mli, $(wildcard *.mly))
GEN_ML= $(subst .mll,.ml, $(subst .mly,.ml, $(wildcard *.mll *.mly)))
SRC= $(wildcard *.ml *.mli) $(GEN_MLI) $(GEN_ML)


# Liste des fichiers à compiler dans l'ordre des dépendances
CMO=	ast.cmo \
	parser.cmo lexer.cmo \
	main.cmo

# Nom de l'executable produit (vous pouvez le changer a votre guise)
OUT=tp4


CFLAGS=-dtypes
CC=ocamlc $(CFLAGS)
RM=rm -rf

.PHONY: clean all

# Pour compiler
all: $(OUT)

$(OUT): $(CMO)
	$(CC) $^ -o $@
	@echo "===> $@ est compile avec succes!!!"

ifneq ($(MAKECMDGOALS),clean)
-include .depend
endif

%.cmi:	%.mli
	$(CC) -c $<

%.cmo :	%.ml
	$(CC) -c $<

%.ml :	%.mll
	ocamllex $<

%.ml %.mli : %.mly
	ocamlyacc -v $< # l'option -v genere parser.output qui contient la table SLR


clean:
	$(RM) $(OUT) *~ *.cm[io] .depend \
	*.annot	$(GEN_MLI) $(GEN_ML) *.output

.depend: $(SRC)
	ocamldep $^ > .depend

