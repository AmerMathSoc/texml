% Jan Holecek, Alexander Grahn
% 2013/10/15

filenametemplate "%j_%c.mps";
verbatimtex
\documentclass{article}
\usepackage[latin1]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\usepackage{amsmath}
\begin{document}
etex

e := 2.718282;
N=8;
size := 5cm;
bars := 0.5mm;
diff := 0.05;
xmin := -2;
xmax :=  2;
xo   := -2;
ymin :=  0;
ymax :=  e**xmax;
xcoe := size / (xmax - xmin);
ycoe := size / (ymax - ymin);


pair xaxis[], yaxis[], npnt;
xaxis[1] = (xmin * xcoe, 0);   xaxis[2] = (xmax * xcoe, 0);
yaxis[1] = (0, ymin * ycoe);   yaxis[2] = (0, ymax * ycoe);
npnt = (xmin * xcoe, ymax * ycoe);

picture xlabel, ylabel, elabel, nlabel[];
xlabel = btex $x$ etex;
ylabel = btex $y$ etex;
elabel = btex $y = e^x$ etex;
nlabel[1] = btex $n = 1$ etex;
nlabel[2] = btex $n = 2$ etex;
nlabel[3] = btex $n = 3$ etex;
nlabel[4] = btex $n = 4$ etex;
nlabel[5] = btex $n = 5$ etex;
nlabel[6] = btex $n = 6$ etex;
nlabel[7] = btex $n = 7$ etex;
nlabel[8] = btex $n = 8$ etex;


def pnt (expr x,y)=
  ( x * xcoe, y * ycoe )
enddef;

def exp (expr x)=
  pnt (x , e**x)
enddef;

def taylor (expr s,x)=
  begingroup
    save i,v,w;
    v = 1;
    w = 1;
    for i := 1 upto s:
      w := (w * (x-xo)) / i;
      v := v + w;
    endfor;
    pnt (x , v * (e**xo))
  endgroup
enddef;

path pexp,ptaylor[];

pexp = exp(xmin) 
for i:=xmin+diff step diff until xmax:
  .. exp(i)
endfor;

for j:=1 upto N:
  ptaylor[j] := taylor (j,xmin)
  for i:=xmin+diff step diff until xmax:
    .. taylor(j,i)
  endfor;
endfor;

def axis=
  drawarrow xaxis[1]--xaxis[2];
  drawarrow yaxis[1]--yaxis[2];
  for k:=-1,1:
    draw (k * xcoe, -bars) -- (k * xcoe, bars);
  endfor;
  for k:=1 upto 6:
    draw (-bars, k * ycoe) -- (bars, k * ycoe);
  endfor;
  draw pexp withcolor red;
  label.lrt  (xlabel, xaxis[2]);
  label.ulft (ylabel, yaxis[2]);
  label.top  (elabel, point (length (pexp)) of pexp);
enddef;

path bounds;
beginfig(0);
  pickup pencircle scaled 0.4mm;
  axis;
  bounds:=bbox currentpicture;
  setbounds currentpicture to bounds;
  clip currentpicture to bounds;
endfig;

for i:=1 upto N:
  beginfig(i);
    pickup pencircle scaled 0.4mm;
    draw ptaylor[i] withcolor blue;
    label.lrt ( nlabel[i], npnt);
    setbounds currentpicture to bounds;
    clip currentpicture to bounds;
  endfig;
endfor;

end.
