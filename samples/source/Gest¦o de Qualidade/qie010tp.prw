#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 03/12/99
User Function qie010tp()     // incluido pelo assistente de conversao do AP5 IDE em 03/12/99

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Declaracao de variaveis utilizadas no programa atraves da funcao    ?
//? SetPrvt, que criara somente as variaveis definidas pelo usuario,    ?
//? identificando as variaveis publicas do sistema utilizadas no codigo ?
//? Incluido pelo assistente de conversao do AP5 IDE                    ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?

SetPrvt("ASAVHEADER,ASAVACOLS,NSAVN,LRETURN,NPOSTIPLAM,NPOSPLAMO")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複?
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽?
굇쿑un뇚o    ? QIE010TP ? Autor ? Antonio Aurelio F C   ? Data ? 11/05/99 낢?
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙?
굇쿏escri뇚o ? Verifica se o NQA foi especificado na Descricao do Prod.   낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇? Uso      ?  X3_WHEN - SIGAQIE QIE010TP()                              낢?
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇?			ATUALIZACOES SOFRIDAS DESDE A CONSTRU?AO INICIAL.			  낢?
굇쳐컴컴컴컴컴컫컴컴컴컴쩡컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇쿛rogramador ? Data	? BOPS ?  Motivo da Alteracao 					  낢?
굇쳐컴컴컴컴컴컵컴컴컴컴탠컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇쿛aulo Emidio?15/09/00쿘ETA  쿔mplementacao do Plano de Amostragem por  낢?
굇?            ?        ?      쿐nsaios                                   낢?
굇읕컴컴컴컴컴컨컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂?
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽?
/*/

IIF(aSavHeader == NIL, aSavHeader := {},)
IIF(aSavaCols == NIL, aSavaCols := {},)
IIF(nSavn == NIL, nSavn := 0,)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//?	Obs. As Vari?veis aSavHeader, aSavaCols e nSavn estao declradas ?
//?  como Private na fun?ao de de chamamento AIEA010                ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?

lReturn := .F.

nPosTiPlaM := AScan(aSavHeader, { |x| Alltrim(x[2]) == 'QE7_TIPLAM' })

If AllTrim(aSavaCols[nSavn][nPosTiPlaM]) == "2"	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
	//?	Se o QE9_PLAMO nao for o corrente, testa   						?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
	If ReadVar() <> "M->QE9_PLAMO"
		nPosPlaMo  := AScan(aHeader, { |x| Alltrim(x[2]) == 'QE9_PLAMO'})
		If nPosPlaMo > 0
			If !Empty(aCols[n][nPosPlaMo])
				lReturn := .T.
			EndIf
		EndIf		
	Else
		lReturn := .T.
	EndIf	
EndIf

// Substituido pelo assistente de conversao do AP5 IDE em 03/12/99 ==> __Return(lReturn)
Return(lReturn)        // incluido pelo assistente de conversao do AP5 IDE em 03/12/99
