% Maxime Chupin, Alexander Grahn
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

u:=4cm;

vardef proj(expr P,M,N)=
  save H;
  pair H;
  H=whatever [M,N];
  H-P=whatever * (M - N) rotated 90;
  H
enddef;

path dr,cercle,drb,scara;
pair A,B,C,D,Q,T,O',P,O,M;
O:=(0,0);
O':=(-u/3,0);
A:=(u/sqrt(2),u/sqrt(2)) shifted O';
B:=(u/sqrt(2),-u/sqrt(2)) shifted O';
C:=(-u/sqrt(2),-u/sqrt(2))shifted O';
D:=(-u/sqrt(2),u/sqrt(2)) shifted O';
dr:=A--C;
drb:=B--D;

%scarabaeus construction
for i:=0 upto 100:
  if i=0:
    P:=A;
    Q:=O';
    M:=proj(O,P,Q);
    scara:=M;
  else:
    scara:=M;
    for j:=1 upto 4:
      k:=4*(i-1)+j;
      if (k<200) or (k=200):
        P:=point (k*0.005) of dr;
        cercle:=halfcircle
          scaled 2u rotated 45 shifted P;
        if k=0:
          Q:=O';
        fi;
        if (k<>0) and (k<>200):
          Q:=cercle intersectionpoint drb;
        fi;
        if k=200:
          Q:=O';
        fi;
      else:
        P:= point (2-k*0.005) of dr;
        cercle:=halfcircle
          scaled 2u rotated (-135) shifted P;
        if k<400:
          Q:=cercle intersectionpoint drb;
        fi;
        if k=400:
          Q:=O';
        fi;
      fi;
      M:=proj(O,P,Q);
      scara:=scara--M;
    endfor;
  fi;
  beginfig(i) %red scarabaeus segments
    setbounds currentpicture to
    (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
    pickup pencircle scaled 1pt;
    draw scara withcolor red;
    clip currentpicture to
    (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
  endfig;
  beginfig(i+101) %moving construction lines and labels
    setbounds currentpicture to
    (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
    draw 12[P,Q]--12[Q,P] dashed evenly;
    draw O--M dashed evenly;
    pickup pencircle scaled 1.4pt;
    draw P--Q withcolor blue;
    label.rt(btex $2l$ etex, 0.5[P,Q]);
    dotlabel.urt(btex $P$ etex, P);
    dotlabel.llft(btex $Q$ etex,Q);
    dotlabel.top(btex $M$ etex,M);
    clip currentpicture to
    (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
  endfig;
  if (i/2.-floor(i/2.))=0: %gray lines every second image
    beginfig(i/2+202)
      setbounds currentpicture to
      (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
      draw P--Q withcolor 0.8 white;
      clip currentpicture to
      (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
    endfig;
  fi;
endfor;

%coordinate axes and stationary stuff
beginfig(253);
  setbounds currentpicture to
  (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
  path ida,mida;
  drawarrow(-1.5u,0)--(1u,0);
  drawarrow(0,-1.2u)--(0,1.2u);
  ida:=12[A,C]--12[C,A];
  mida:=(12[D,B]--12[B,D]);
  draw ida dashed evenly;
  draw mida dashed evenly;
  label.top(btex $a$ etex, 0.5[O,O']);
  label.top(btex $x$ etex, (0.8u,0));
  label.rt(btex $y$ etex, (0,u));
  label.bot(btex\itshape{\underline{scarabaeus}} etex,(-1.1u,1.1u));
  label.bot(btex $r=l\cos 2t-a\cos t$ etex, (-u/2,1.1u));
  dotlabel.urt(btex $O'$ etex, O');
  dotlabel.urt(btex $O$ etex, O);
  dotlabel.rt(btex $A$ etex,A);
  dotlabel.rt(btex $B$ etex,B);
  dotlabel.lft(btex $C$ etex,C);
  dotlabel.lft(btex $D$ etex,D);
  clip currentpicture to
  (u,1.2u)--(u,-1.2u)--(-1.5u,-1.2u)--(-1.5u,1.2u)--cycle;
endfig;

end.
