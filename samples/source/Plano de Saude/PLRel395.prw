#INCLUDE "PROTHEUS.CH"
#INCLUDE "Report.ch" 
#INCLUDE "FWPRINTSETUP.CH"

#DEFINE	 IMP_PDF 6 
#DEFINE	 TAM_A4 9	//A4     	210mm x 297mm  620 x 876		

//-------------------------------------------------------------------
/*/{Protheus.doc} PLRel395

Monta estrutura do relatorio de atendimento Protocolos RN 395

@author  Equipe PLS
@version P11
@since   11/08/16
/*/
//------------------------------------------------------------------- 
User Function PLRel395()
Local aDados     := paramixb[1] 
Local aAutorizad := paramixb[2] 
Local aNegativas := paramixb[3]  
Local lAtendTMK  := paramixb[4]
Local lImpEmail  := paramixb[5]

Local oFontCab  := TFont():New("Arial", 20, 20, , .T., , , , .T., .F.)  
Local oFontNorm	:= TFont():New("Arial", 14, 14, , .F., , , , .T., .F.)   
Local oFontUnder:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.,.T.)   

LOCAL cFileName := ""
LOCAL cFolder   := PLSMUDSIS(GetTempPath()+"totvsprinter\")
LOCAL cTexto    := ""
LOCAL cPathSrv  := PLSMUDSIS("\ptu\")
Local nLimIni   := 1
Local nHeiPag   := 2200                              	
Local nLin      := nHeiPag
Local nFor      := 0
Local nI        := 0
Local nObs      := 0
LOCAL lEstudo   := .F.
LOCAL lDisSetup := .T.
LOCAL lNegado   := .F.               
LOCAL lOk       := .T.
Private oPrn       
/*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Dados do Array aDados                                                                         ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
aDados[01] -> Municipio Operadora
aDados[02] -> UF Municipio Operadora      
aDados[03] -> Data Impressao
aDados[04] -> Nome Beneficiario  
aDados[05] -> Data Atendimento/Protocolo
aDados[06] -> CPF
aDados[07] -> Matricula Beneficiario
aDados[08] -> Telefone Central
aDados[09] -> Nome Operadora
aDados[10] -> Numero Protocolo
aDados[11] -> Observacao (somente Guias de Atendimento)
aDados[12] -> Ocorrencia Call Center
aDados[13] -> Solucao Call Center
*/       
If lImpEmail .And. Empty(B00->B00_EMAILD)                        
	lDisSetup := .F.
EndIf

cFileName := "protocolo_"+iif(lAtendTMK,"callcenter_","atendimento_")+aDados[10]+".pdf" 
                              
nH   := PLSAbreSem("PL773RSMF.SMF")
oPrn := FWMSPrinter():New(cFileName,IMP_PDF,.T.,cPathSrv,lDisSetup,.F.,@oPrn,,.T.,.F.,.F.,.T.)
PLSFechaSem(nH,"PL773RSMF.SMF")

nCol1 	   :=  040 // Margem da coluna
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Resolucao do relatorio                                                                        ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
oPrn:setResolution(72)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Modo retrato                                                                                  ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
oPrn:setPortrait()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Papel A4                                                                                      ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
oPrn:setPaperSize(TAM_A4)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Margem                                                                                        ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
oPrn:setMargin(100,100,100,100) 
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Imprime cabecalho                                                                             ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
nLin := FS_CabecImp(@oPrn, aDados)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Mensagem principal do corpo                                                                   ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?     
nLin += 130
oPrn:Say(nLin, nCol1, "Ao Benefici?rio,", oFontNorm)
nLin += 070
oPrn:Say(nLin, nCol1, aDados[04], oFontNorm)
nLin += 250                                                   
oPrn:Say(nLin, nCol1+470, "Protocolo de Atendimento ao Benefici?rio", oFontCab)       
nLin += 200  
oPrn:Say(nLin, nCol1, "Prezado,", oFontNorm)  
nLin += 070
oPrn:Say(nLin, nCol1, "No dia "+aDados[05]+" o benefici?rio ", oFontNorm)  
oPrn:Say(nLin, nCol1+0690 , aDados[04], oFontUnder)
oPrn:Say(nLin, nCol1+1500 , "inscrito(a) no CPF "+aDados[06]+",", oFontNorm)  

nLin += 070   
If lAtendTMK
	cTexto := ", entrou em contato com a nossa Operadora com a(s) seguinte(s) ocorr?ncia(s):"
Else	
	cTexto := ", solicitou os seguintes procedimentos:"
EndIf 

oPrn:Say(nLin, nCol1, "portador(a) da matr?cula "+aDados[07]+cTexto, oFontNorm)  
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Atendimento Call-Center                  	                            ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
If lAtendTMK   
	nLin += 035
	nLin := impMemo(oPrn,nLin,Alltrim(aDados[12]),aDados)
 	
	nLin += 140
	oPrn:Say(nLin, nCol1, "Segue o nosso parecer para ocorr?ncia(s) apresentada(s):", oFontNorm)    
	nLin += 035
	nLin := impMemo(oPrn,nLin,Alltrim(aDados[13]),aDados)
	
Else
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
	//? Procedimentos autorizados                	                            ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
	If len(aAutorizad) > 1   
		nLin += 140   
		oPrn:Say(nLin, nCol1 , "EVENTOS AUTORIZADOS:" , oFontUnder)
		For nFor := 1+nLimIni To LEN(aAutorizad)     
			nLin := FS_EndPage(nLin,oPrn,aDados)
			nLin += 070    
	    	oPrn:Say(nLin, nCol1 + 30 , "Qtd: " + STRZERO(aAutorizad[nFor,03],02) +" - "+ AllTrim(aAutorizad[nFor,02]) +"  -  ("+ AllTrim(aAutorizad[nFor,01]) + ")" , oFontNorm)
		Next
	EndIf  
	
	If len(aNegativas) > 1
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
		//? Procedimentos negados	                	                            ?
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
		nLin += 140 
		For nFor := 1+nLimIni To Len(aNegativas)

			nLin := FS_EndPage(nLin,oPrn,aDados)	
			If aNegativas[nFor,05] == "1" .And. !lEstudo
				oPrn:Say(nLin, nCol1 , "EVENTOS EM ESTUDO/AUDITORIA: " , oFontUnder)
				lEstudo := .T.
			ElseIf aNegativas[nFor,05] == "0" .And. !lNegado
				If lEstudo
					nLin += 140
				EndIf
				oPrn:Say(nLin, nCol1 , "EVENTOS NEGADOS: " , oFontUnder)
				lNegado := .T.
			EndIf
			
			nLin += 070
			oPrn:Say(nLin, nCol1 + 30 , "Qtd: " + STRZERO(aNegativas[nFor,03],02) +" - "+ AllTrim(aNegativas[nFor,02]) +"  -  ("+ AllTrim(aNegativas[nFor,01]) + ")" , oFontNorm)
			For nI := 1 To Len(aNegativas[nFor,04])
  				
  				nLin := FS_EndPage(nLin,oPrn,aDados)
  				nLin += 070
				oPrn:Say(nLin, nCol1 + 30 , Space(10) + STRZERO(nI,02) + " - " + AllTrim(aNegativas[nFor,04,nI]), oFontNorm)
				
				For nObs := 1 To LEN(aNegativas[nFor,04])
					If ExistBlock( "PL773OBS" ) .And. Len(aNegativas[nFor]) > 5
				   		nLin += 070
						oPrn:Say(nLin, nCol1 + 30 , Space(10) + aNegativas[nFor,06,nObs], oFontNorm)
					EndIf
				Next
			Next
        Next
		
	EndIf	 
	IF !Empty(aDados[11])      
		nLin += 140
		oPrn:Say(nLin, nCol1 , "OBSERVA합ES:" , oFontUnder)
		nLin += 070
		nLin := impMemo(oPrn,nLin,Alltrim(aDados[11]),aDados)  
	EndIf
 
EndIf	
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Finaliza relatorio                       	                            ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
nLin += 200  
nLin := FS_EndPage(nLin,oPrn,aDados)
oPrn:Say(nLin, nCol1 , "Solicitamos, por gentileza, caso restem d?vidas, permanecemos ? disposi豫o atrav?s da nossa Central de Relacionamento com Cliente, ", oFontNorm)       
nLin += 070
oPrn:Say(nLin, nCol1 , "no n?mero "+aDados[08]+".",oFontNorm)       
nLin += 140
oPrn:Say(nLin, nCol1 , "Atenciosamente,",oFontNorm) 
nLin += 070
oPrn:Say(nLin, nCol1 , aDados[09] , oFontUnder)    

nLin := 2850
oPrn:Say(nLin+070, 2000, "P?gina "+cValtoChar(oPrn:nPageCount) , oFontUnder) 
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Se envio de email, o PDF nao e exibido em tela					            ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?  
If lImpEmail
	oPrn:SetViewPDF(.F.)
EndIf	
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Deleta arquivo se ja existente  									        ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
FERASE(GetTempPath()+"totvsprinter\"+cFileName) 
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//? Gera o relatorio   													        ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴? 
oPrn:Preview()    

If lImpEmail .And. B00->B00_TPENVI <> "2" .And. oPrn:nModalResult <> 1
	lOk := .F.	
EndIf

Return {lOk,cFolder,cFileName}
                              


//-------------------------------------------------------------------
/*/{Protheus.doc} FS_CabecImp

Imprime cabecalho do relat?rio da RN 395

@author  Equipe PLS
@version P11
@since   28/06/16
/*/
//-------------------------------------------------------------------   
Static Function FS_CabecImp(oPrn, aDados)
Local nMarSup	   :=  317   	             // Margem superior        
Local nCol1 	   :=  015		             // Margem da coluna1
Local oFontNeg	:= TFont():New("Arial", 16, 16, , .T., , , , .T., .F.)

nLin   := nMarSup     
oPrn:StartPage()     

oPrn:Say(nLin, nCol1, "Protocolo N? "+ aDados[10], oFontNeg) 
nLin += 070
oPrn:Say(nLin, nCol1+1200, aDados[01]+"-"+aDados[02]+", "+aDados[3], oFontNeg)       
nLin += 140

Return(nLin)  
                       


//-------------------------------------------------------------------
/*/{Protheus.doc} FS_EndPage

Verifica quebra de pagina

@author  Equipe PLS
@version P11
@since   28/06/16
/*/
//-------------------------------------------------------------------   
Static Function FS_EndPage(nLin,oPrn,aDados)             
Local oFontUnder:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.,.T.)   

If nLin >= 2850
	oPrn:Say(nLin+070, 2000, "P?gina "+cValtoChar(oPrn:nPageCount) , oFontUnder)
	oPrn:EndPage()  
	nLin := FS_CabecImp(oPrn, aDados)
EndIf

Return nLin  



//-------------------------------------------------------------------
/*/{Protheus.doc} impMemo

Imprime um campo memo

@author  Equipe PLS
@version P11
@since   28/06/16
/*/
//-------------------------------------------------------------------   
Static Function impMemo(oPrn,nLin,cMemo,aDados)
Local oFontObs	 := TFont():New("Arial", 14, 14, , .T., , , , .T., .F.)   
Local aDadObs    := {}     
Local lLoop      := .T.
Local nTamLin    := 110//120     
Local nFor       := 0
Local nContBlank := 0	

While lLoop
	If len(cMemo) < nTamLin  
		If (nPosChr13 := At(Chr(13),Substr(cMemo,1,nTamLin))) < nTamLin .And. nPosChr13 <> 0  
			Aadd(aDadObs,Substr(cMemo,1,nPosChr13))  
			cMemo := Substr(cMemo,nPosChr13+1,len(cMemo)) 	
		Else	
			Aadd(aDadObs,cMemo)
			lLoop := .F.
		EndIf	
	Else
		If (nPosChr13 := At(Chr(13),Substr(cMemo,1,nTamLin))) < nTamLin .And. nPosChr13 <> 0 
			Aadd(aDadObs,Substr(cMemo,1,nPosChr13))  
			cMemo := Substr(cMemo,nPosChr13+1,len(cMemo)) 		
		Else            
			lBlank     := .F.  
			nContBlank := 0
			While !lBlank 
				If Substr(cMemo,nTamLin-nContBlank,1) == " "
		        	lBlank := .T.
		        Else
		        	nContBlank ++
		        EndIf
		    EndDo   
		    Aadd(aDadObs,Substr(cMemo,1,nTamLin-nContBlank))
			cMemo := Substr(cMemo,(nTamLin-nContBlank)+1,len(cMemo))   
		EndIf	
	EndIf
EndDo   
	
For nFor := 1 to len(aDadObs)     
   	nLin += 050        
   	nLin := FS_EndPage(nLin,oPrn,aDados)
   	aDadObs[nFor] := StrTran(aDadObs[nFor],Chr(10),"")
   	aDadObs[nFor] := StrTran(aDadObs[nFor],Chr(13),"")
   	oPrn:Say(nLin, nCol1+90, aDadObs[nFor] , oFontObs) 
Next

Return nLin    