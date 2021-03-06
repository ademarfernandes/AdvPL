#INCLUDE "APWEBSRV.CH"
#INCLUDE "PROTHEUS.CH"

WSSTRUCT HCMList
	WSDATA Family				As String	OPTIONAL //Familia de gestao
	WSDATA Version				As String	OPTIONAL //Versao da certificacao
	WSDATA Certification		As String	OPTIONAL //Certificacao / S=sim, N=nao ou 1,2 etc
	WSDATA DateFrom				As Date		OPTIONAL //Data da certificacao
	WSDATA DateTo				As Date		OPTIONAL //Data de validade da certificacao
ENDWSSTRUCT

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿏efinicao do Web Service de Curriculo de Funcionarios                   ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
WSSERVICE RHUsuario DESCRIPTION "Curriculum dos Funcionarios ( <b>Restri豫o de participante</b> )"
    
	WSDATA UserCode				AS String
	WSDATA ParticipantId        As String			//Codigo do Participante
    
	WSDATA ListOfHCM			As Array of HCMList	//Lista com dados das certificacoes HCM por participante
	
	WSMETHOD BrwHCM	 DESCRIPTION "Retorna dados da certificacao HCM por participante"
	
ENDWSSERVICE		


/*/
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컫컴컴컫컴컴컴컴컴커굇
굇쿑un뇙o    쿍rwHCM	    ? Autor 쿕uliana B. Mariano  쿏ata ?24.08.2005 낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컨컴컴컨컴컴컴컴컴캑굇
굇쿏escri뇙o 쿘etodo de visualizacao dos dados HCM			  			   낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿛arametros?												               낢?
굇?          ?                                                             낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿝etorno   쿐xpL1: Indica que o metodo foi avaliado com sucesso          낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿢so       ? APD/RH/Portais                                              낢?
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/                      	
WSMETHOD BrwHCM WSRECEIVE UserCode, ParticipantId WSSEND ListOfHCM WSSERVICE RHUsuario

Local nI		:= 0     
Local nQuestoes	:= 0
Local nAcertos	:= 0
Local lRetorno	:= .T.      
Local aArea		:= GetArea()                         
Local cPercentual	:= ""


	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
	//? VERIFICA SE PARTICIPANTE POSSUI CERTIFICACAO HCM	  |
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
	dbSelectArea("XB0")
	dbSetOrder(2) //XB0_FILIAL+XB0_CODRD0	

	::ListOfHCM := {}	
	If XB0->( MsSeek(xFilial("XB0")+::ParticipantId) )
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//? DADOS DA CERTIFICACAO HCM DO PARTICIPANTE  |
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		XB4->( dbSetOrder(2) ) //XB4_FILIAL+XB4_CODUSR+DTOS(XB4_DATAAG)+XB4_HORAAG		
		If XB4->( MsSeek(xFilial("XB4")+XB0->XB0_CODIGO) )
			While !XB4->( Eof() ) .And. XB4->(XB4_FILIAL+XB4_CODUSR) == (xFilial("XB4")+XB0->XB0_CODIGO)

				//VERIFICA SE AINDA NAO VENCEU E SE STATUS = APROVADO  
				/************************************************************
				XB4_RESULT == ""	/ "Agendado"
				XB4_RESULT == "1"	/ "Aprovado"
				XB4_RESULT == "2"	/ "N?o Aprovado"
				XB4_RESULT == "3"	/ "Cancelado"
				XB4_RESULT == "4"	/ "Desistente"
				XB4_RESULT == "5"	/ "Expirou"
				XB4_RESULT == "6"	/ "Faltou"
				XB4_RESULT == Otherwise	/ "Indefinido"
				*************************************************************/
				If XB4->XB4_VALIDA >= date() .And. XB4->XB4_RESULT == "1"
					aAdd(::ListOfHCM, WsClassNew("HCMList"))
					nI ++

					XB2->( dbSetOrder(1) )		//XB2_FILIAL+XB2_CODIGO		
					If XB2->( MsSeek(xFilial("XB2")+XB4->XB4_GESTAO) )
						::ListOfHCM[nI]:Family			:= XB2->XB2_NOME
	
						XBA->( dbSetOrder(1) )		//XBA_FILIAL+XBA_CODIGO		
						If XBA->( MsSeek(xFilial("XBA")+XB2->XB2_VERSAO) )						
							::ListOfHCM[nI]:Version			:= XBA->XBA_DESCRI
						EndIf
					EndIf      
					
					::ListOfHCM[nI]:DateFrom		:= XB4->XB4_DATAEX
					::ListOfHCM[nI]:DateTo			:= XB4->XB4_VALIDA
					
					//VERIFICAR PERCENTUAL DE ACERTO                         
					nQuestoes	:= 0        
					nAcertos	:= 0
					XB5->( dbSetOrder(2) )		//XB5_FILIAL+XB5_CODAGE+XB5_NIVEL+XB5_NQUEST		
					If XB5->( MsSeek(xFilial("XB5")+XB4->XB4_CODIGO) )						
						While !XB5->( Eof() ) .And. XB5->(XB5_FILIAL+XB5_CODAGE) == (xFilial("XB5")+XB4->XB4_CODIGO)
	                        nQuestoes++
	                        If XB5->XB5_ALTUSR == XB5->XB5_CODCOR
								nAcertos++	                        
	                        EndIf
							
							XB5->( DbSkip() )
						EndDo
					EndIf    
					//CALCULO DO PERCENTUAL DE ACERTOS
					cPercentual := AllTrim(str( noRound((nAcertos*100)/nQuestoes, 2)))
					::ListOfHCM[nI]:Certification	:= "Sim(" + cPercentual	+ "%)"//XB4->XB4_RESULT
				
				EndIf
				
				XB4->( dbSkip() )				
			EndDo
		EndIf
	Else
		lRetorno := .F.
		SetSoapFault("BRWHCM","Usuario nao possui certificacao")
	EndIf


RestArea(aArea)		
Return lRetorno


User Function WsUsu_XXX() //Efeito de compilacao

Return Nil
