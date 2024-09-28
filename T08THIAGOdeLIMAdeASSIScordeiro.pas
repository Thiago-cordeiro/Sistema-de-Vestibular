Program T08THIAGOdeLIMAdeASSIScordeiro ;
										//trabalho feito por thiago cordeiro
uses tardenoite;
var
arq:file of regis;
reg:regis;
notas:text;
disc: array [1..6] of string[30] ;
media:ARRAY[1..6] OF INTEGER;
vet:vetor;
CM:real;
a,b,c,posiv,np,ii,tot,tc,tt,ni,err:integer;
numa,numero:string[4];
nota:string[28];

Begin
  cortela(15);
  textcolor(red);
  disc[1]:='L.E.M.                      ';
  disc[2]:='MATEMÁTICA                  ';
  disc[3]:='LÓGICA                      ';
  disc[4]:='CONHECIMENTO ESPCI. DO CARGO';
  disc[5]:='INFORMÁTICO                 ';
  disc[6]:='ATUALIDADES                 ';
  assign(arq,'cand.ind');
  assign(notas,'notas.txt');
  reset(arq);
  reset(notas);
  //monta o vetor pelo num de insc
  repeat
    read(arq,reg);
    ii:=a+1;          
    vet[ii].pf:=a;    
    str(reg.num,numero);
    tc:=length(numero);
    for b:=1 to 4-tc do
    insert('0',numero,1);  
    vet[ii].cc:=numero;
    A:=A+1;
  until(eof(arq));
  //fim da montagem
  tot:=ii;
  writeln('Por favor aguarde a leitura das notas :) ...');
  ordem(vet,ii);
  
  repeat
    tt:=tt+1;
    readln(notas,nota);
    numa:=copy(nota,1,4);
    pebin1(vet,numa,tot,posiv);  {pesquisa binaria}
      
    seek(arq,vet[posiv].pf);   												         
    
    read(arq,reg);
  
    numero:=copy(nota,5,8);
    val(numero,ni,err);
    media[1]:=ni+media[1];
    reg.notas[1]:=ni;
    ni:=0;
    numero:=copy(nota,9,12);
    val(numero,ni,err);
    media[2]:=ni+media[2];
    reg.notas[2]:=ni;
    ni:=0;
    numero:=copy(nota,13,16);
    val(numero,ni,err);
    media[3]:=ni+media[3];
    reg.notas[3]:=ni;
    ni:=0;
    numero:=copy(nota,17,20);
    val(numero,ni,err);
    media[4]:=ni+media[4];
    reg.notas[4]:=ni;
    ni:=0;
    numero:=copy(nota,21,24);
    val(numero,ni,err);
    media[5]:=ni+media[5];
    reg.notas[5]:=ni;
    ni:=0;
    numero:=copy(nota,25,28);
    val(numero,ni,err);
    media[6]:=ni+media[6];
    reg.notas[6]:=ni;
    reg.som:=0;
    for c:=1 to 6 do
      reg.som:=reg.notas[c]+reg.som;
       
    SEEK(ARQ,VET[POSIV].PF);
    WRITE(ARQ,REG);
  until eof(notas);
  clrscr;
  writeln('Disciplina                                          Média');
  FOR C:=1 TO 6 DO
  begin
  CM:=media[C]/tt;
  WRITELN(DISC[C],CM:29:2);
  end;
	termine;
  CLOSE(notas);
  CLOSE(ARQ);
End.