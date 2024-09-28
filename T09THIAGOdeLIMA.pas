Program T09THIAGOdeLIMA	 ;
//FEITO POR THIAGO CORDEIRO 
USES TARDENOITE;
VAR ARQ:FILE OF REGIS;
REG:REGIS;
VET:VETOR;
A,B,IND,PFI,TOTAL,datai,clg,c,posiv,err:INTEGER;
vagas:text;
vaga:string[31];
dt:string[8];
nt:array[1..6] of string[3];
codigoVAGA:array[1..12] of string[2];
numeroVAGAS:array[1..12] of string[2];
codigoVAGAint:array[1..12] of integer;
numeroVAGASint:array[1..12] of integer;
criterios:string[29];
t:integer;
soma:string[3];
Begin

  ASSIGN(vagas,'VAGAS.TXT');
  ASSIGN(ARQ,'CAND.IND');
  reset(vagas);
  RESET(ARQ); 
	
	for t:=1 to 12 do          //adiciona os codigos e quantidade de cada cargo
	begin
	readln(vagas,vaga);
	codigoVAGA[t]:=copy(vaga,1,2);
	numeroVAGAS[t]:=copy(vaga,30,31);
	val(codigoVAGA[t],codigoVAGAint[t],err);
	val(numeroVAGAS[t],numeroVAGASint[t],err)
 end;
	t:=0;
	
	for t:=1 to 12 do         //mostra o que ta no vetor só para grantir
	begin
	writeln('CODIGO DA VAGA: '+codigoVAGA[t]:2,' NUMERO DE VAGAS: '+numeroVAGAS[t]:6);
 end;
	
	
	 
  WHILE (NOT EOF(ARQ)) DO
	Repeat
    READ(ARQ,REG);
    IND:=IND+1;
    VET[IND].PF:=PFI;
    str(reg.som:3,soma) ;           //critérios para desempate, usei um array pras notas porque achei a ideia boa
    str(reg.notas[4]:3,nt[1]) ;
    str(reg.notas[5]:3,nt[2]) ;
    str(reg.notas[3]:3,nt[3]) ;
    str(reg.notas[2]:3,nt[4]) ;
    str(reg.notas[6]:3,nt[5]) ;
    str(reg.notas[1]:3,nt[6]) ;
    dt:=REG.DATA.ANO+REG.DATA.MES+REG.DATA.DIA;
    val(dt,datai,err);
    datai:=20240990-datai ;      //lembrar de colocar um numero(data atual) grande, e também é uma string de 8 se colocar uma string de 6 da um erro 
    str(datai:6,dt);
    criterios:=concat(soma,nt[1],nt[2],nt[3],nt[4],nt[5],nt[6],dt) ;
		VET[IND].CC:= criterios;//COLOCA O CAMPO POR QUAL QUERO ACESSAR O ARQ, NO VETOR //campo chave seria os critérios
    PFI:=PFI+1;
    datai:=0  ;
  Until(eof(arq));
  //MONTADO O VETOR ORDENAMOS...
  TOTAL:=IND;
  WRITELN('Ordenando o vetor e gravando o resultado das classificações');  //msgm amigável
  ORDEM(VET,TOTAL);
  clrscr;
  WRITELN('Obrigado por utilizar o meu código, gravação realizado com sucesso'); //msgm amigável x2(não precisa)
	FOR b:=total downto 1 DO
  BEGIN
  	clg:=1+clg;
    SEEK(ARQ,VET[B].PF);
		READ(ARQ,REG);//POSICIONA NO ARQ NA POSICAO INDICADA PELO CAMPO pf DO VETOR ORDENADO
    reg.clg:=clg;   
    codigoVAGAint[reg.car]:=codigoVAGAint[reg.car]+1 ;
    reg.clc:=codigoVAGAint[reg.car];
   for c:=1 to reg.car do
    begin
		if (codigoVAGAint[reg.car] <= numeroVAGASint[reg.car]) then   
			reg.ccl:=reg.car			    
		end;
		SEEK(ARQ,VET[B].PF);
  	WRITE(ARQ,REG);
  end;

  TERMINE;
  CLOSE(VAGAS);
  CLOSE(ARQ);
End.