Program T07THIAGOdeLIMAdeASSIScordeiro ;
//feito por Thiago Cordeiro 
USES TARDENOITE;
VAR ARQ:FILE OF REGIS;
REG:REGIS;
VET:VETOR;
INSC: string[4];
cargo:string[2];
nome:string[35];
cargoNome:string[37];
A,B,IND,PFI,TOTAL, escolha, tc, d, PG, CA:INTEGER;
Begin
  cortela(15);
  textcolor(red); 
  ASSIGN(ARQ,'CAND.IND');
  RESET(ARQ);
  repeat
    writeln('Digite a opção desejada de ordenação:');
    leia('1-incrição, 2-ordem alfabetica, 3-cpf, 4-cargo', escolha);
    if ((escolha < 0) or (escolha > 4)) then
    writeln('Escolha invalida');
  until ((escolha > 0) and (escolha < 5));
  WHILE (NOT EOF(ARQ)) DO
  BEGIN
    READ(ARQ,REG);
    IND:=IND+1;
    VET[IND].PF:=PFI;//COLOCA A POSICAO FISICA NO VETOR
    if escolha = 1 then //Por inscrição
    begin
      str(REG.num,INSC);
      TC:=LENGTH(INSC);
      FOR d:=1 TO 4-TC DO
      INSERT('0',INSC,1);
      VET[IND].CC:=INSC;
      PFI:=PFI+1
    end;
    
    if escolha = 2 then // Ordem alfabética
    begin
      VET[IND].CC:=REG.NOME;
      PFI:=PFI+1
    end;
    
    if escolha = 3 then //CPF
    begin
      VET[IND].CC:=REG.CPF;
      PFI:=PFI+1
    end;
    
    if escolha = 4 then //Cargo e ordem alfabetica dentro do cargo
    begin
      str(REG.car,cargo);
      nome:=REG.nome;
      cargoNOME:=concat(cargo,nome);
      TC:=LENGTH(cargoNOME);
      FOR d:=1 TO 37-TC DO
      INSERT('0',cargoNOME,1);
      VET[IND].CC:=cargoNOME;
      PFI:=PFI+1
    end
  END;
  
  //MONTADO O VETOR ORDENAMOS...
  WRITELN('LIDOS=',IND:5,' REGISTROS');
  FOR A:=1 TO 20 DO
  WRITELN(A:5,VET[A].PF:5,' ',VET[A].CC);
  TOTAL:=IND;
  ORDEM(VET,TOTAL);
  FOR A:=1 TO 20 DO
  WRITELN(A:5,VET[A].PF:5,' ',VET[A].CC);
  WRITELN('ENTER PARA CONTINUAR');
  READLN;
   PG:=0;
   CA:=0;
  //MOSTRA O CONTEUDO DO ARQUIVO USANDO COMO REFERENCIA O CAMPO PF, DO VETOR ORDENADO
  FOR B:=1 TO TOTAL DO
  BEGIN
    SEEK(ARQ,VET[B].PF);//POSICIONA NO ARQ NA POSICAO INDICADA PELO CAMPO pf DO VETOR ORDENADO
    READ(ARQ,REG);
    //LINHA DETALHE
    IF (PG = 25) or ((escolha =4) and (CA<>REG.car) and (PG > 0)) then
		BEGIN
		  WRITELN('ENTER PARA CONTINUAR');
      READLN;
      CLRSCR;
      WRITELN;
      write('  ORD  NUM N O M E                             ===C P F=== NASCIMENTO CS  N1');
      WRITELN('  N2  N3  N4  N5  N6   SO   CG  CC CV FA');
      PG:=0;
		END;
    WRITE(B:5,REG.NUM:5,' ',REG.NOME,' ',REG.CPF,' ',REG.DATA.DIA,'/',REG.DATA.MES,'/',REG.DATA.ANO,REG.CAR:3);
    FOR A:=1 TO 6 DO
    WRITE(REG.NOTAS[A]:4);
    WRITELN(REG.SOM:5,REG.CLG:5,REG.CLC:4,REG.CCL:3,REG.FALTA:3);
    CA:=REG.car;
    PG:=PG+1;
	END;
  TERMINE;
End.