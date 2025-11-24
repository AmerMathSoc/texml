.PHONY: demo doc all clean

all: demo doc

demo:
	latex -output-format=pdf tex-label-demo.tex
doc:
	latex -output-format=pdf tex-label-doc.tex
clean:
	rm -rf *.aux *~ *.log
