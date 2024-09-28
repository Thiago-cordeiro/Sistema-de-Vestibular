Program T10THIAGOdeLIMAdeASSIScordeiro;
//FEITO POR THIAGO CORDEIRO 
USES TARDENOITE;
VAR
ARQ: FILE OF REGIS;
vagas:text;
vaga:string[31];
REG: REGIS;
VET: VETOR;
NOTAS:ARRAY[1..6] OF STRING[3];
NOCA:ARRAY[1..12] OF STRING[27];
CCL,car: string[2];
CLG,clc: string[4];
IND,PFI,TOTAL,ESCOLHA,A,B,C,PG,CA: INTEGER;

Begin
  ASSIGN(vagas,'VAGAS.TXT');
  ASSIGN(ARQ,'CAND.IND');
  reset(vagas);
  RESET(ARQ);
  
  for C:=1 to 12 do          
  begin
    readln(vagas,vaga);
    NOCA[C]:=copy(vaga,3,27);
  end;
	 
  repeat
    writeln('Selecione a opção de visualização dos classificados:');
    leia('1-ordem alfabética, 2-Por Cargo, 3-Class. Geral', escolha);
    if (escolha < 1) or (escolha > 3) then
    writeln('Escolha inválida');
  until (escolha >= 1) and (escolha <= 3);
  WHILE (NOT EOF(ARQ)) DO
  BEGIN
    READ(ARQ,REG);
    IND:=IND+1;
    VET[IND].PF:=PFI;//COLOCA A POSICAO FISICA NO VETOR
//========================================================================   
    if escolha = 1 then    
    begin
      IF (REG.CCL <> 0) THEN
      BEGIN
        STR(REG.CCL:2, CCL);
        VET[IND].CC:= CCL+REG.NOME;
      END
      ELSE
      ind:=ind-1;                  
    end;
//======================================================================== FIM ESCOLHA 1         
    if escolha = 2 then     
    begin
      STR(
			REG.clc:4, Clc);                    
      STR(REG.CAR:2, car); 
      VET[IND].CC:=car+clc;
    end;
//======================================================================== FIM ESCOLHA 2     
    if escolha = 3 then
    begin     
      STR(REG.CLG:4, CLG);
      VET[IND].CC:=CLG; 		
		end ;
//======================================================================== FIM ESCOLHA 3  
    PFI:=PFI+1;
  END;  
  // Montado o vetor, ordenamos... 
  TOTAL := ind;
  ORDEM(VET, TOTAL); 
  WRITELN('ENTER PARA CONTINUAR');
  READLN;
  clrscr; 
  PG := 0;
  CA := 0;
  IF escolha = 1 THEN
  BEGIN
  writeln('');
	WRITELN('   CURSO: ',NOCA[REG.car],REG.car:5);
  writeln('');
  writeln('  ORD  NUM NOME                                NASCIMENTO  CCL');
    // Mostra o conteúdo do arquivo usando como referência o campo PF do vetor ordenado
    FOR B := 1 TO TOTAL DO
    BEGIN
      SEEK(ARQ, VET[B].PF); // Posiciona no arquivo na posição indicada pelo campo PF do vetor ordenado
      READ(ARQ, REG);
      // Linha detalhe
      IF (PG = 25) or  ((CA<>REG.CAR) and (PG > 0)) then
      BEGIN
        WRITE('ENTER PARA CONTINUAR');
        READLN;
        CLRSCR;
        WRITELN;
				WRITELN('   CURSO: ',NOCA[REG.car],REG.car:5);
        WRITELN;
        writeln('  ORD  NUM NOME                                NASCIMENTO  CCL');     
        PG := 0;
      END;
      
      WRITELN(B:5, REG.NUM:5, ' ', REG.NOME, ' ', REG.DATA.DIA, '/', REG.DATA.MES, '/', REG.DATA.ANO, ' ', REG.CCL:3);
      PG := PG + 1;
      ca:=reg.car;
    END;
  END;
  
 
  IF ((ESCOLHA = 2) OR (ESCOLHA = 3)) THEN
  BEGIN
	IF ESCOLHA = 2 THEN
          WRITELN('CURSO: ',NOCA[REG.car],REG.car:5)
          else                                                                        
          WRITELN('   ORDEM DE CLASSIFICAÇÃO GERAL DOS APROVADOS');
          writeln('');
					WRITELN('  ORD  NUM N O M E                               SOM  N4  N5  N3  N2  N6  N1   NASCIMENTO CAR OBSERVARÇÃO'); 
      //MOSTRA O CONTEUDO DO ARQUIVO USANDO COMO REFERENCIA O CAMPO PF, DO VETOR ORDENADO
      FOR B:=1 TO total DO
      BEGIN
        SEEK(ARQ,VET[B].PF);//POSICIONA NO ARQ NA POSICAO INDICADA PELO CAMPO pf DO VETOR ORDENADO
        READ(ARQ,REG);
        //LINHA DETALHE
        IF (PG = 25) or ((ESCOLHA = 2) and (CA<>REG.CAR) and (PG > 0)) then
        BEGIN
          WRITE('ENTER PARA CONTINUAR');
          READLN;
          CLRSCR;
          IF ESCOLHA = 2 THEN
          WRITELN('CURSO: ',NOCA[REG.car],REG.car:5) 
          else                                                                        
          WRITELN('   ORDEM DE CLASSIFICAÇÃO GERAL DOS APROVADOS');
          WRITELN ;
          WRITELN('  ORD  NUM N O M E                               SOM  N4  N5  N3  N2  N6  N1   NASCIMENTO CAR OBSERVARÇÃO');
          PG:=0;
        END;
        WRITE(B:5,REG.NUM:5,' ',REG.NOME,' ',REG.SOM:5);
        FOR A:=1 TO 6 DO
        WRITE(REG.NOTAS[A]:4);
        WRITE('   ',REG.DATA.DIA,'/',REG.DATA.MES,'/',REG.DATA.ANO,REG.CAR:3);
        if reg.ccl <> 0 then
        WRITELN('  CLASS CAR-',REG.CCL)
        else
        WRITELN('');
        CA:=REG.car;
        PG:=PG+1;
    END;
  END;
  TERMINE;
End.

