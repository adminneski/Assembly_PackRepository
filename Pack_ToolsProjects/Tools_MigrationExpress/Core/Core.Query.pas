unit Core.Query;

interface

uses
  System.Generics.Collections,
  System.SysUtils, Vcl.Forms, Winapi.Windows;

type
  TCoreQuery = class
  private


  public
    class var FiliaisWhere: string;

    class var QueryList: TDictionary<String, String>;
    class constructor Create;
    class destructor Destroy;
    class procedure CarrecarScriptsDTOs;

  end;



implementation

{ TCoreQuery }

class procedure TCoreQuery.CarrecarScriptsDTOs;
begin
  if Length(FiliaisWhere) = 0 then
  begin
    Application.MessageBox('Variavel de Filiais está vazia, Primeira etapa de mudança de valores '+
                           'FIL_CODIGO para COM_CODIGO não executada, favor executar o programa novamente para executar passo a passo correto !! ',
                           'Atenção',MB_OK+MB_ICONEXCLAMATION);
    //FrmMain.btnSelecionarFiliais.Enabled := False;
    Abort;
  end
  else
  begin
    QueryList.Add('TACT_XX', 'SELECT * FROM ACT_XX');
    //----------------------------------------------------------------------------
    QueryList.Add('TAFC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM AFC_00 '+
    ' WHERE AFC_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TAJU_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM AJU_00 '+
    ' WHERE AJU_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TAQT_00', 'SELECT COM_CODIGO = 0, * FROM AQT_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TATB_00', 'SELECT COM_CODIGO = 0 '+
    ' ,ATB_CODIGO '+
    ' ,ATB_UF = UFS_SIGLA '+
    ' ,PES_CODIGO '+
    ' ,ATB_CREDENCIADO_BEBIDA '+
    ' ,ATB_CREDENCIADO_NORMAL '+
    ' ,ATB_DESATIVADO '+
    ' ,ATB_DATAALTERACAO '+
    ' FROM ATB_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TATB_00_01', 'SELECT COM_CODIGO = 0, * FROM ATB_00_01');
    //----------------------------------------------------------------------------
//    QueryList.Add('TBAI_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM BAI_00 '+
//    ' WHERE BAI_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCO_00', 'SELECT COM_CODIGO = 0, * FROM BCO_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCP_00 '+
    ' WHERE BCP_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCP_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCP_00_01 '+
    ' WHERE BCP_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCP_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCP_00_02 '+
    ' WHERE BCP_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCP_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCP_00_03 '+
    ' WHERE BCP_00_03.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCR_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCR_00 '+
    ' WHERE BCR_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCR_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCR_00_01 '+
    ' WHERE BCR_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCR_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCR_00_02 '+
    ' WHERE BCR_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCT_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCT_00 '+
    ' WHERE BCT_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCT_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCT_00_01 '+
    ' WHERE BCT_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCX_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCX_00 '+
    ' WHERE BCX_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCX_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCX_00_01 '+
    ' WHERE BCX_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBCX_00_01_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BCX_00_01_01 '+
    ' WHERE BCX_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TBLC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM BLC_00 '+
    ' WHERE BLC_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCCC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CCC_00 '+
    ' WHERE CCC_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCCC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CCC_00_01 '+
    ' WHERE CCC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCCP_00', 'SELECT COM_CODIGO = 0, * FROM CCP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCCU_00', 'SELECT COM_CODIGO = 0, * FROM CCU_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCDC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CDC_00 '+
    ' WHERE CDC_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCDV_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CDV_00 '+
    ' WHERE CDV_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCDV_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CDV_00_01 '+
    ' WHERE CDV_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCEF_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CEF_00 '+
    ' WHERE CEF_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCEF_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CEF_00_01 '+
    ' WHERE CEF_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
//    QueryList.Add('TCEP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CEP_00 '+
//    ' WHERE CEP_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
//    QueryList.Add('TCFG_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CFG_00 '+
//    ' WHERE CFG_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCFOP_00', 'SELECT COM_CODIGO = 0, * FROM CFOP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCFR_00', 'SELECT CFR_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,VEI_CODIGO '+
    ' ,CFR_DATALANCAMENTO '+
    ' ,CFR_CARTAFRETE '+
    ' ,CFR_NOTAFISCAL '+
    ' ,CFR_CONHECIMENTO '+
    ' ,CID_ORIG.CID_IBGE CID_IBGEORIGEM '+
    ' ,CID_DEST.CID_IBGE CID_IBGEDESTINO '+
    ' ,CFR_PRECOTONELADA '+
    ' ,CFR_PESOCARGA '+
    ' ,CFR_VALEFRETE '+
    ' ,CFR_DATAALTERACAO '+
    ' ,CID_ORIG.CID_NOME CFR_CIDADEORIGEM '+
    ' ,UFS_ORIG.UFS_SIGLA CFR_UFORIGEM '+
    ' ,CID_DEST.CID_NOME CFR_CIDADEDESTINO '+
    ' ,UFS_DEST.UFS_SIGLA CFR_UFDESTINO '+
    ' FROM CFR_00 '+
    ' LEFT JOIN CID_00 CID_ORIG '+
    '  ON CID_ORIG.CID_CODIGO = CFR_00.CID_CODIGOORIGEM '+
    ' LEFT JOIN UFS_00 UFS_ORIG '+
    '  ON UFS_ORIG.UFS_CODIGO = CID_ORIG.UFS_CODIGO '+
    ' LEFT JOIN CID_00 CID_DEST '+
    '  ON CID_DEST.CID_CODIGO = CFR_00.CID_CODIGODESTINO '+
    ' LEFT JOIN UFS_00 UFS_DEST '+
    '  ON UFS_DEST.UFS_CODIGO = CID_DEST.UFS_CODIGO '+
    ' WHERE CFR_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCGA_00', ' SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CGA_00 '+
    ' WHERE CGA_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCGA_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CGA_00_01 '+
    ' WHERE CGA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
      QueryList.Add('TCGA_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CGA_00_02 '+
    ' WHERE CGA_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
//    QueryList.Add('TCID_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CID_00 '+
//    ' WHERE CID_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCLF_00', 'SELECT COM_CODIGO = 0, * FROM CLF_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCLT_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CLT_00 '+
    ' WHERE CLT_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCLT_XML', 'SELECT * FROM CLT_XML');
    //----------------------------------------------------------------------------
//    QueryList.Add('TCMA_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CMA_00 '+
//    ' WHERE CMA_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TCMA_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CMA_00_01 '+
//    ' WHERE CMA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TCMA_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CMA_00_02 '+
//    ' WHERE CMA_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCMD_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CMD_00 '+
    ' WHERE CMD_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCMD_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CMD_00_01 '+
    ' WHERE CMD_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCMP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CMP_00 '+
    ' WHERE CMP_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCMP_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CMP_00_01 '+
    ' WHERE CMP_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCOD_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM COD_00 '+
    ' WHERE COD_00.FIL_CODIGO IN (' + FiliaisWhere + ', ''CAD'', ''XXX'' )');
    //----------------------------------------------------------------------------
//    QueryList.Add('TCOR_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM COR_00 '+
//    ' WHERE COR_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPA_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPA_00 '+
    ' WHERE CPA_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPA_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPA_00_01 '+
    ' WHERE CPA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPA_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPA_00_02 '+
    ' WHERE CPA_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPA_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPA_00_03 '+
    ' WHERE CPA_00_03.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPA_00_03_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPA_00_03_01 '+
    ' WHERE CPA_00_03_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPF_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPF_00 '+
    ' WHERE CPF_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPF_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPF_00_01 '+
    ' WHERE CPF_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPM_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPM_00 '+
    ' WHERE CPM_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCPM_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CPM_00_01 '+
    ' WHERE CPM_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRB_00', 'SELECT CRB_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,VEI_CODIGO '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,CRB_DATASAIDA '+
    ' ,CRB_NUMEROCONTRATO '+
    ' ,PES_CODIGOCONTRATANTE '+
    ' ,PES_CODIGOCONTRATADO '+
    ' ,CID_ORIG.CID_IBGE CID_IBGEORIGEM '+
    ' ,CID_DEST.CID_IBGE CID_IBGEDESTINO '+
    ' ,CRB_CONDICAOESPECIAL '+
    ' ,CRB_MERCADORIATRANSPORTADA '+
    ' ,CRB_TOTALPESO '+
    ' ,CRB_TOTALIRRF '+
    ' ,CRB_TOTALINSS '+
    ' ,CRB_TOTALFRETE '+
    ' ,CRB_TOTALMULTA '+
    ' ,CRB_TOTALPEDAGIO '+
    ' ,CRB_TOTALOUTROS '+
    ' ,CRB_TOTALREEMBOLSO '+
    ' ,CRB_TOTALSEST_SENAT '+
    ' ,CRB_TOTALADIANTAMENTO '+
    ' ,CRB_TOTALCONTRATO '+
    ' ,CRB_PROCESSADO '+
    ' ,CRB_CANCELADO '+
    ' ,CRB_DATACANCELAMENTO '+
    ' ,CRB_OBSERVACAOCANCELAMENTO '+
    ' ,CRB_INTEGRACAO '+
    ' ,CRB_DATAALTERACAO '+
    ' ,CRB_TIPOMOVTO '+
    ' ,CRB_NOTAFISCAL '+
    ' ,CRB_TOTALAJUSTE '+
    ' ,CRB_ESPECIEVOLUMES '+
    ' ,CRB_TOTALNUMEROVOLUMES '+
    ' ,CRB_DATAEMISSAO '+
    ' ,CID_ORIG.CID_NOME CRB_CIDADEORIGEM '+
    ' ,UFS_ORIG.UFS_SIGLA CRB_UFORIGEM '+
    ' ,CID_DEST.CID_NOME CRB_CIDADEDESTINO '+
    ' ,UFS_DEST.UFS_SIGLA CRB_UFDESTINO '+
   ' FROM CRB_00 '+
   ' LEFT JOIN CID_00 CID_ORIG '+
     ' ON CID_ORIG.CID_CODIGO = CRB_00.CID_CODIGOORIGEM '+
   ' LEFT JOIN UFS_00 UFS_ORIG '+
     ' ON UFS_ORIG.UFS_CODIGO = CID_ORIG.UFS_CODIGO '+
   ' LEFT JOIN CID_00 CID_DEST '+
     ' ON CID_DEST.CID_CODIGO = CRB_00.CID_CODIGODESTINO '+
   ' LEFT JOIN UFS_00 UFS_DEST '+
     ' ON UFS_DEST.UFS_CODIGO = CID_DEST.UFS_CODIGO '+
    ' WHERE CRB_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRB_00_01', ' SELECT CRB_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CRB_ID '+
    ' ,CRB_DIA '+
    ' ,BCO_CODIGO '+
    ' ,FPG_CODIGO '+
    ' ,CRB_DATAVENCTO '+
    ' ,CRB_NUMERODOCTO '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,CRB_NUMEROPARCELA '+
    ' ,CRB_VALORPARCELA '+
    ' ,CRB_DATAALTERACAO '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,CID_IBGE '+
    ' ,CRB_EMITENTE '+
    ' ,CRB_CONTA '+
    ' ,CRB_CIDADE '+
    ' ,CRB_AGENCIA '+
    ' ,CRB_VENCTOCARTAO '+
    ' ,CRB_NUMEROCHEQUE '+
    ' ,CRB_DOCTOEMITENTE '+
    ' ,CRB_AUTORIZACAOCARTAO '+
    ' ,CRB_PERCENTUALFINANCEIRO '+
    ' FROM CRB_00_01 '+
    ' LEFT JOIN CID_00 '+
    '  ON CID_00.CID_CODIGO = CRB_00_01.CID_CODIGO '+
    ' WHERE CRB_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00 '+
    ' WHERE CRE_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,CRE_PES_CODIGO = 0 '+
    ' ,* '+
    ' FROM CRE_00_01 '+
    ' WHERE CRE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00_02 '+
    ' WHERE CRE_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_02_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00_02_01 '+
    ' WHERE CRE_00_02_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_02_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00_02_02 '+
    ' WHERE CRE_00_02_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00_03 '+
    ' WHERE CRE_00_03.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
//    QueryList.Add('TCRE_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM CRE_00_04 '+
//    ' WHERE CRE_00_04.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_05', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00_05 '+
    ' WHERE CRE_00_05.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRE_00_05_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRE_00_05_01 '+
    ' WHERE CRE_00_05_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRF_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRF_00 '+
    ' WHERE CRF_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRF_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CRF_00_01 '+
    ' WHERE CRF_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCRT_00', 'SELECT COM_CODIGO = 0, * FROM CRT_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCST_00', 'SELECT COM_CODIGO = 0, * FROM CST_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCSTPC_00', ' SELECT COM_CODIGO = 0 '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,CSTPC_DESCRICAO = CSTP_DESCRICAO '+
    ' ,CSTPC_DESATIVADO = CSTP_DESATIVADO '+
    ' ,CSTPC_DATAALTERACAO = CSTP_DATAALTERACAO '+
    ' FROM CSTP_00 '+
    ' '+
    ' UNION '+
    ' '+
    ' SELECT  COM_CODIGO = 0 '+
    ' ,CSTPC_CODIGO = CSTC_CODIGO '+
    ' ,CSTPC_DESCRICAO = CSTC_DESCRICAO '+
    ' ,CSTPC_DESATIVADO = CSTC_DESATIVADO '+
    ' ,CSTPC_DATAALTERACAO = CSTC_DATAALTERACAO '+
    ' FROM CSTC_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTA_00',' SELECT CTA_CODIGO '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CTA_DATACADASTRO '+
    ' ,CID_IBGE '+
    ' ,CEP_CODIGO '+
    ' ,CTA_BAIRRO '+
    ' ,CTA_CONTA '+
    ' ,BCO_CODIGO '+
    ' ,PLC_CODIGO '+
    ' ,CTA_TIPO '+
    ' ,CTA_AGENCIA '+
    ' ,CTA_EMITENTE '+
    ' ,CTA_ENDERECO '+
    ' ,CTA_NOMEAPELIDO '+
    ' ,CTA_NUMEROENDERECO '+
    ' ,CTA_NUMEROCHEQUE '+
    ' ,CTA_DDD_TELEFONE_1 '+
    ' ,CTA_DDD_TELEFONE_2 '+
    ' ,CTA_DDD_FAX '+
    ' ,CTA_GERENTECONTA '+
    ' ,CTA_EMAIL '+
    ' ,CTA_SALDOESPECIAL '+
    ' ,CTA_SALDOLIMITEROTATIVO '+
    ' ,CTA_TOTALPREDATADOS '+
    ' ,CTA_INTEGRACAOCONTABIL '+
    ' ,CTA_CONFIGURACOES '+
    ' ,CTA_ULTIMONOSSONUMERO '+
    ' ,CTA_CONTROLER '+
    ' ,CTA_DESATIVADO '+
    ' ,CTA_DATAALTERACAO '+
    ' ,CID_NOME CTA_CIDADE '+
    ' ,UFS_SIGLA CTA_UF '+
    ' FROM CTA_00 '+
    ' LEFT JOIN CID_00 '+
    '  ON CID_00.CID_CODIGO = CTA_00.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '  ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO '+
    ' WHERE CTA_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTA_00_01', 'SELECT COM_CODIGO = 0, * FROM CTA_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTA_00_02', 'SELECT COM_CODIGO = 0, * FROM CTA_00_02');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTA_00_03', 'SELECT COM_CODIGO = 0, * FROM CTA_00_03');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTA_00_04', 'SELECT COM_CODIGO = 0, * FROM CTA_00_04');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTA_00_05', 'SELECT COM_CODIGO = 0, * FROM CTA_00_05');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTB_00', 'SELECT COM_CODIGO = 0, * FROM CTB_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTR_00', ' SELECT CTR_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CTR_DATAEMISSAO '+
    ' ,CTR_DATAENTREGA '+
    ' ,CTR_SERIE '+
    ' ,CTR_SUBSERIE '+
    ' ,MNF_CODIGO '+
    ' ,CTR_NOTAFISCAL '+
    ' ,VEI_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,CSTP_CODIGO CSTPC_CODIGO '+
    ' ,CTR_EMITENTE '+
    ' ,CTR_ESPECIEVOLUMES '+
    ' ,CTR_NATUREZA '+
    ' ,CTR_NATUREZACARGA '+
    ' ,CTR_NUMERODOCTO '+
    ' ,PES_CLIENTEOUTROS '+
    ' ,PES_CLIENTEREMETENTE '+
    ' ,PES_CLIENTEDESTINATARIO '+
    ' ,PES_CLIENTECONSIGNATARIO '+
    ' ,PES_CLIENTEREDESPACHO '+
    ' ,FOR_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTR_TIPOCTE '+
    ' ,CTR_TIPOFRETE '+
    ' ,CTR_TIPOSERVICO '+
    ' ,CTR_TOTALFRETE '+
    ' ,CTR_TOTALICMS '+
    ' ,CTR_TOTALSEGURO '+
    ' ,CTR_TOTALPEDAGIO '+
    ' ,CTR_TOTALDESPACHO '+
    ' ,CTR_TOTALPRESTACAO '+
    ' ,CTR_TOTALNOTAFISCAL '+
    ' ,CTR_TOTALPESOLIQUIDO '+
    ' ,CTR_TOTALNUMEROVOLUMES '+
    ' ,CTR_TOTALBASECALCULOICMS '+
    ' ,CTR_TOTALOUTRASDESPESAS '+
    ' ,CTR_TOTALMERCADORIASEGURADA '+
    ' ,CTR_NUMEROLIBERACAOSEGURO '+
    ' ,CTR_SERIELIBERACAOSEGURO '+
    ' ,CTR_TOTALBASECALCULOPIS CTR_TOTALBCALCULOPISCOFINS '+
    ' ,CTR_TOTALDESCONTO '+
    ' ,CTR_TOTALPIS '+
    ' ,CTR_TOTALCOFINS '+
    ' ,CTR_TOTALPRODUTOS '+
    ' ,CTR_PLACAVEICULO '+
    ' ,CTR_PERCENTUALICMS '+
    ' ,CTR_PERCENTUALDESCONTO '+
    ' ,CTR_PERCENTUALCOFINS '+
    ' ,CTR_UFVEICULO '+
    ' ,CTR_COBRADORA '+
    ' ,CTR_SEGURADORA '+
    ' ,CTR_APOLICE '+
    ' ,CTR_PERCENTUALFRETE '+
    ' ,CTR_VALORQUILOFRETE '+
    ' ,CTR_TOTALSEC_CAT '+
    ' ,CTR_PERCENTUALPIS '+
    ' ,CTR_NUMEROCIOT '+
    ' ,CST_CODIGOCTR '+
    ' ,CTR_TOTALPESOBRUTO '+
    ' ,CTR_TOTALAPROXIMADOIMPOSTO '+
    ' ,CTR_TOTALIBPTESTADUAL '+
    ' ,CTR_TOTALIBPTNACIONAL '+
    ' ,CTR_PERCENTUALIBPT '+
    ' ,CTR_PERCENTUALIBPTESTADUAL '+
    ' ,CTR_PERCENTUALIBPTNACIONAL '+
    ' ,CTR_CNPJTOMADOR '+
    ' ,CTR_CPFTOMADOR '+
    ' ,MNF_CODIGOTOMADOR '+
    ' ,CTR_SERIETOMADOR '+
    ' ,CTR_SUBSERIETOMADOR '+
    ' ,CTR_NOTAFISCALTOMADOR '+
    ' ,CTR_VALORNOTAFISCALTOMADOR '+
    ' ,CTR_DATAEMISSAONFTOMADOR '+
    ' ,CTR_TOMADORCONTRIBUINTEICMS '+
    ' ,CTR_CHAVEACESSOTOMADOR '+
    ' ,CTR_CHAVEACESSOSUBSTITUIDO '+
    ' ,CTR_CHAVEACESSOCOMPLEMENTO '+
    ' ,CTR_CHAVEACESSOANULACAO '+
    ' ,CTR_DATAEMISSAODECLARACAO '+
    ' ,ORIG.CID_IBGE CID_IBGEORIGEM '+
    ' ,ORIG.CID_NOME CTR_CIDADEORIGEM '+
    ' ,UFS_ORIG.UFS_SIGLA CTR_UFORIGEM '+
    ' ,DEST.CID_IBGE CID_IBGEDESTINO '+
    ' ,DEST.CID_NOME CTR_CIDADEDESTINO '+
    ' ,UFS_DEST.UFS_SIGLA CTR_UFDESTINO '+
    ' ,LIB_NUMEROLIBERACAO '+
    ' ,CTR_DATACANCELAMENTO '+
    ' ,CTR_OBSERVACAOCANCELAMENTO '+
    ' ,CTR_OBSERVACAO '+
    ' ,CTR_CANCELADO '+
    ' ,CTR_LIVROFISCAL '+
    ' ,CTR_PROCESSADO '+
    ' ,CTR_DATAALTERACAO '+
    ' ,LIB_ID '+
    ' ,CTR_AVERBADO '+
    ' ,CTR_NOMESEGURADORA '+
    ' ,CTR_CNPJSEGURADORA '+
    ' ,CTR_NUMEROAPOLICE '+
    ' ,CTR_NUMEROAVERBACAO '+
    ' ,CTR_DATAAVERBACAO '+
    ' ,CTR_HORAAVERBACAO '+
    ' ,CTR_PROTOCOLOAVERBACAO '+
    ' ,CTR_QUANTIDADECARGA '+
    ' ,CTR_UNIDADEMEDIDACARGA '+
    ' FROM CTR_00 '+
    ' LEFT JOIN CID_00 ORIG '+
    '  ON ORIG.CID_CODIGO = CTR_00.CID_CODIGOORIGEM '+
    ' LEFT JOIN UFS_00 UFS_ORIG '+
    '  ON UFS_ORIG.UFS_CODIGO = ORIG.UFS_CODIGO '+
    ' LEFT JOIN CID_00 DEST '+
    '  ON DEST.CID_CODIGO = CTR_00.CID_CODIGODESTINO '+
    ' LEFT JOIN UFS_00 UFS_DEST '+
    '  ON UFS_DEST.UFS_CODIGO = DEST.UFS_CODIGO '+
    ' WHERE CTR_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTR_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CTR_00_01 '+
    ' WHERE CTR_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTR_00_02', 'SELECT CTR_02_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CTR_ID '+
    ' ,CTR_DIA '+
    ' ,FPG_CODIGO '+
    ' ,BCO_CODIGO '+
    ' ,CID_IBGE '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,CTR_DATAVENCIMENTO '+
    ' ,CTR_DOCTOEMITENTE '+
    ' ,CTR_NUMERODOCTO '+
    ' ,CTR_EMITENTE '+
    ' ,CTR_CONTA '+
    ' ,CTR_AGENCIA '+
    ' ,CTR_CIDADE '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,CTR_VENCTOCARTAO '+
    ' ,CTR_AUTORIZACAOCARTAO '+
    ' ,CTR_PERCENTUALFINANCEIRO '+
    ' ,CTR_NUMEROPARCELA '+
    ' ,CTR_VALORPARCELA '+
    ' ,CTR_DATAALTERACAO '+
    ' ,CTR_NUMEROCHEQUE '+
    ' FROM CTR_00_02 '+
    ' LEFT JOIN CID_00 '+
    '  ON CID_00.CID_CODIGO = CTR_00_02.CID_CODIGO '+
    ' WHERE CTR_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTR_00_03', 'SELECT CTR_03_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CTR_ID '+
    ' ,CTR_CNPJ_CPF '+
    ' ,CTR_IE '+
    ' ,UFS_SIGLA CTR_UF '+
    ' ,CTR_NOMEEXPEDIDOR '+
    ' ,CTR_TIPODOCUMENTO '+
    ' ,CTR_SERIE '+
    ' ,CTR_SUBSERIE '+
    ' ,CTR_NUMERODOCTOFISCAL '+
    ' ,CTR_CHAVEACESSO '+
    ' ,CTR_DATAEMISSAO '+
    ' ,CTR_DATAALTERACAO '+
    ' FROM CTR_00_03 '+
    ' WHERE CTR_00_03.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TCTR_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM CTR_00_04 '+
    ' WHERE CTR_00_04.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TDCH_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM DCH_00 '+
    ' WHERE DCH_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TDCH_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,*' +
    ' FROM DCH_00_01 '+
    ' WHERE DCH_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TDEP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM DEP_00 '+
    ' WHERE DEP_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
  //  QueryList.Add('TDEV_00', ' SELECT DEV_ID, COM_CODIGO = FIL_CODIGO, PES_CODIGO, MNF_CODIGO, TDC_CODIGO, NTO_CODIGO, '+
  //  ' CTB_CODIGO, CFOP_CODIGO, VND_CODIGO, TRP_CODIGO, DEV_SERIE, DEV_NOTAFISCAL, '+
  //  ' DEV_DATALANCAMENTO, DEV_NUMERODOCTO, DEV_TOTALIPI, DEV_TOTALPIS, DEV_TOTALICMS, '+
  //  ' DEV_TOTALICMSR, DEV_TOTALFRETE, DEV_TOTALCOFINS, DEV_TOTALLIQUIDO, DEV_TOTALSEGURO, '+
  //  ' DEV_TOTALSERVICO, DEV_TOTALPRODUTOS, DEV_TOTALPESOBRUTO, DEV_TOTALPESOLIQUIDO, '+
  //  ' DEV_TOTALQTDDEVOLVIDA, DEV_TOTALSUBSTRIBUTARIA, DEV_TOTALDESPACESSORIA, '+
  //  ' DEV_TOTALBASEISENTOICMS, DEV_TOTALBASECALCULOICMS, DEV_TOTALBASECALCULOMVA, '+
  //  ' DEV_TOTALFINANCEIROPRAZO, DEV_TOTALCOMPLEMENTONFICMS, DEV_TOTALDESCTOITEM, '+
  //  ' DEV_TOTALDESCTOPRAZO, DEV_TOTALDESCTOAVULSO, DEV_TOTALCOMISSAO, DEV_TOTALADICIONAL, '+
  //  ' DEV_TOTALBASECALCULOPIS DEV_TOTALBCALCULOPISCOFINS, DEV_TOTALAPROXIMADOIMPOSTO, '+
  //  ' DEV_TOTALNUMEROVOLUMES, DEV_PERCENTUALFINANCEIROPRAZO, DEV_PERCENTUALDESCONTOPRAZO, '+
  //  ' DEV_PERCENTUALDESCTOAVULSO, DEV_PERCENTUALIBPT, DEV_NUMERACAOVOLUMES, DEV_INFCOMPLEMENTAR, '+
  //  ' DEV_MARCAVOLUMES, DEV_ESPECIEVOLUMES, USERS_LOGIN, DEV_PROCESSADO, DEV_OBSERVACAO, '+
  //  ' DEV_DATAALTERACAO, DEV_TIPOFRETE, DEV_CANCELADA, DEV_PLACAVEICULO, DEV_UFVEICULO, '+
  //  ' DEV_LIVROFISCAL, DEV_CHAVEACESSO, DEV_DATACANCELAMENTO, DEV_OBSERVACAOCANCELAMENTO, '+
  //  ' DEV_TOTALBASEDESCONTOCOMISSAO, DEV_PERCENTUALCOMISSAO, DEV_TOTALBASECALCULOCOMISSAO, '+
  //  ' DEV_DENEGADA, DEV_TOTALPRODUTOSLIQUIDO, DEV_TOTALIBPTMUNICIPAL, DEV_TOTALIBPTESTADUAL, '+
  //  ' DEV_TOTALIBPTNACIONAL, DEV_TOTALIBPTIMPORTADO, DEV_PERCENTUALIBPTMUNICIPAL, '+
  //  ' DEV_PERCENTUALIBPTESTADUAL, DEV_PERCENTUALIBPTNACIONAL, DEV_PERCENTUALIBPTIMPORTADO, '+
  //  ' DEV_CHAVEREFERENCIANFE, CON_CODIGO FROM DEV_00 ');
  //  QueryList.Add('TDEV_00_01', ' SELECT OMF_01_ID = DEV_01_ID, '+
  //  ' COM_CODIGO = FIL_CODIGO, '+
  //  ' OMF_ID = DEV_ID, '+
  //  ' DEV_ID = FAT_ID, '+
  //  ' DEV_01_ID = FAT_01_ID, '+
  //  ' DEV_NOTAFISCAL = FAT_NOTAFISCAL, '+
  //  ' PRO_CODIGO, '+
  //  ' CST_CODIGO, '+
  //  ' CFOP_CODIGO, '+
  //  ' NCM_CODIGO, '+
  //  ' LEE_CODIGO, '+
  //  ' GAI_CODIGO, '+
  //  ' CLF_CODIGO = PRO_00.CLF_CODIGO, '+
  //  ' LEF_CODIGO, '+
  //  ' GRD_CODIGO, '+
  //  ' CSTPC_CODIGO = CSTC_CODIGO, '+
  //  ' OMF_ORDEMITEM = DEV_ORDEMITEM, '+
  //  ' OMF_QTDFATURADA = DEV_QTDFATURADA, '+
  //  ' OMF_QTDDEVOLVIDA = DEV_QTDDEVOLVIDA, '+
  //  ' OMF_ITEMALTERADO = ''N'', '+
  //  ' OMF_VALORITEM = DEV_PRECOLIQUIDO, '+
  //  ' OMF_VALORIPIITEM = DEV_VALORIPIITEM, '+
  //  ' OMF_VALORPISITEM = DEV_VALORPISITEM, '+
  //  ' OMF_VALORICMSITEM = DEV_VALORICMSITEM, '+
  //  ' OMF_VALORVERBAITEM = 0, '+
  //  ' OMF_VALORCOFINSITEM = DEV_VALORCOFINSITEM, '+
  //  ' OMF_VALORSEGUROITEM = DEV_VALORSEGUROITEM, '+
  //  ' OMF_VALORSERVICOITEM = 0, '+
  //  ' OMF_VALORDESCTOITEM = (DEV_VALORDESCTOITEM + DEV_VALORDESCTOPRAZOITEM + DEV_VALORDESCTOAVULSOITEM), '+
  //  ' OMF_VALORICMSRNFITEM = = DEV_VALORICMSRITEM, '+
  //  ' OMF_VALORFRETENFITEM = DEV_VALORFRETEITEM, '+
  //  ' OMF_VALORFRETERPAITEM = 0, '+
  //  ' OMF_VALORICMSRDUAITEM = 0, '+
  //  ' OMF_VALORADICIONALITEM = 0, '+
  //  ' OMF_VALORFRETECTRITEM = 0, '+
  //  ' OMF_VALORICMSSIMPLESITEM = 0, '+
  //  ' OMF_VALORBONIFICACAOITEM = 0, '+
  //  ' OMF_VALORBASEOUTROSITEM = DEV_VALORBASEOUTROSITEM, '+
  //  ' OMF_VALORICMSFRETENFITEM = 0, '+
  //  ' OMF_VALORICMSFRETECTRITEM = 0, '+
  //  ' OMF_VALORICMSACESSORIAITEM = 0, '+
  //  ' OMF_VALORDESPACESSORIAITEM = DEV_VALORDESPACESSORIAITEM, '+
  //  ' OMF_VALORSUBSTRIBUTARIAITEM = DEV_VALORSUBSTRIBUTARIAITEM, '+
  //  ' OMF_VALORBASEISENTOICMSITEM = DEV_VALORBASEISENTOICMSITEM, '+
  //  ' OMF_VALORBASECALCULOMVAITEM = DEV_VALORBASECALCULOMVAITEM, '+
  //  ' OMF_VALORBASECALCULOICMSITEM = DEV_VALORBASECALCULOICMSITEM, '+
  //  ' OMF_VALORCOMPLEMENTONFICMSITEM = DEV_VALORCOMPLEMENTONFICMSITEM, '+
  //  ' OMF_PERCENTUALIPIITEM = DEV_PERCENTUALIPIITEM, '+
  //  ' OMF_PERCENTUALPISITEM = DEV_PERCENTUALPISITEM, '+
  //  ' OMF_PERCENTUALMVAITEM = DEV_PERCENTUALMVAITEM, '+
  //  ' OMF_PERCENTUALICMSITEM = DEV_PERCENTUALICMSITEM, '+
  //  ' OMF_PERCENTUALCOFINSITEM = DEV_PERCENTUALCOFINSITEM, '+
  //  ' OMF_PERCENTUALVERBAITEM = 0, '+
  //  ' OMF_PERCENTUALDESCTOITEM = DEV_PERCENTUALDESCTOITEM, '+
  //  ' OMF_PERCENTUALICMSRNFITEM = 0, '+
  //  ' OMF_PERCENTUALSERVICOITEM = 0, '+
  //  ' OMF_PERCENTUALSEGUROITEM = DEV_PERCENTUALSEGUROITEM, '+
  //  ' OMF_PERCENTUALFRETENFITEM = DEV_PERCENTUALFRETEITEM, '+
  //  ' OMF_PERCBCICMSFRETECTRITEM = 0, '+
  //  ' OMF_PERCENTUALICMSRDUAITEM = 0, '+
  //  ' OMF_PERCENTUALFRETECTRITEM = 0, '+
  //  ' OMF_PERCENTUALFRETERPAITEM = 0, '+
  //  ' OMF_PERCENTUALICMSSAIDAITEM = 0, '+
  //  ' OMF_PERCENTUALREDUCAOBCITEM = DEV_PERCENTUALREDUCAOBCITEM, '+
  //  ' OMF_PERCENTUALICMSSIMPLESITEM = 0, '+
  //  ' OMF_PERCENTUALICMSDESTINOITEM = DEV_PERCENTUALICMSDESTINOITEM, '+
  //  ' OMF_PERCENTUALBONIFICACAOITEM = 0, '+
  //  ' OMF_PERCENTUALICMSFRETENFITEM = 0, '+
  //  ' OMF_PERCENTUALICMSFRETECTRITEM = 0, '+
  //  ' OMF_PERCENTUALDESPACESSORIAITEM = DEV_PERCENTUALDESPACESSORIAITEM, '+
  //  ' OMF_PERCENTUALICMSACESSORIAITEM = 0, '+
  //  ' OMF_VALORCUSTOCOMPRAOMF = 0, '+
  //  ' OMF_VALORCUSTOLIQUIDOOMF = 0, '+
  //  ' OMF_VALORCUSTOINVENTARIOOMF = 0, '+
  //  ' OMF_VALORCUSTOCOMPRAMEDIO = 0, '+
  //  ' OMF_VALORCUSTOLIQUIDOMEDIO = 0, '+
  //  ' OMF_VALORCUSTOINVENTARIOMEDIO = 0, '+
  //  ' OMF_VALORBCICMSFRETECTRITEM = 0, '+
  //  ' OMF_VALORBCICMSFRETENFITEM = 0, '+
  //  ' OMF_VALORBCALCULOPISCOFINSITEM = 0, '+
  //  ' OMF_ULTIMOCUSTOCOMPRA = 0, '+
  //  ' OMF_ULTIMOCUSTOLIQUIDO = 0, '+
  //  ' OMF_ULTIMOCUSTOINVENTARIO = 0 '+
  //  ' OMF_ULTIMOCUSTOCOMPRAMEDIO = 0, '+
  //  ' OMF_ULTIMOCUSTOLIQUIDOMEDIO = 0, '+
  //  ' OMF_ULTIMOCUSTOINVENTARIOMEDIO = 0, '+
  //  ' OMF_PRECOZEROMKP = 0, '+
  //  ' OMF_PRECOVENDAMKP = 0, '+
  //  ' OMF_PRECOSUGERIDOMKP = 0, '+
  //  ' OMF_PERCENTUALLUCROVENDAMKP = 0, '+
  //  ' OMF_PERCENTUALLUCROSUGERIDOMKP = 0, '+
  //  ' OMF_PERCENTUALDESPESASLUCROMKP = 0, '+
  //  ' OMF_PERCENTUALMARKUPLUCRO = 0, '+
  //  ' OMF_PERCENTUALMARKUPZERO = 0, '+
  //  ' OMF_PERCENTUALICMSMARKUP = 0, '+
  //  ' OMF_TOTALITEM = DEV_TOTALPRECOLIQUIDO, '+
  //  ' OMF_TOTALIPIITEM = DEV_TOTALIPIITEM, '+
  //  ' OMF_TOTALPISITEM = DEV_TOTALPISITEM, '+
  //  ' OMF_TOTALICMSITEM = DEV_TOTALICMSITEM, '+
  //  ' OMF_TOTALVERBAITEM = 0, '+
  //  ' OMF_TOTALCOFINSITEM = DEV_TOTALCOFINSITEM, '+
  //  ' OMF_TOTALSEGUROITEM = DEV_TOTALSEGUROITEM, '+
  //  ' OMF_TOTALSERVICOITEM = 0, '+
  //  ' OMF_TOTALDESCTOITEM = (DEV_TOTALDESCTOITEM + DEV_TOTALDESCTOPRAZOITEM + DEV_TOTALDESCTOAVULSOITEM), '+
  //  ' OMF_TOTALICMSRNFITEM = DEV_TOTALICMSRITEM, '+
  //  ' OMF_TOTALFRETENFITEM = DEV_TOTALFRETEITEM, '+
  //  ' OMF_TOTALFRETERPAITEM = 0, '+
  //  ' OMF_TOTALICMSRDUAITEM = 0, '+
  //  ' OMF_TOTALADICIONALITEM = 0, '+
  //  ' OMF_TOTALFRETECTRITEM = 0, '+
  //  ' OMF_TOTALICMSSIMPLESITEM = 0, '+
  //  ' OMF_TOTALBONIFICACAOITEM = 0, '+
  //  ' OMF_TOTALBASEOUTROSITEM = DEV_TOTALBASEOUTROSITEM, '+
  //  ' OMF_TOTALICMSFRETENFITEM = 0, '+
  //  ' OMF_TOTALICMSFRETECTRITEM = 0, '+
  //  ' OMF_TOTALICMSACESSORIAITEM = 0, '+
  //  ' OMF_TOTALDESPACESSORIAITEM = DEV_TOTALDESPACESSORIAITEM, '+
  //  ' OMF_TOTALSUBSTRIBUTARIAITEM = DEV_TOTALSUBSTRIBUTARIAITEM, '+
  //  ' OMF_TOTALBASEISENTOICMSITEM = DEV_TOTALBASEISENTOICMSITEM, '+
  //  ' OMF_TOTALBASECALCULOMVAITEM = DEV_TOTALBASECALCULOMVAITEM, '+
  //  ' OMF_TOTALBASECALCULOICMSITEM = DEV_TOTALBASECALCULOICMSITEM, '+
  //  ' OMF_TOTALCOMPLEMENTONFICMSITEM = DEV_TOTALCOMPLEMENTONFICMSITEM, '+
  //  ' OMF_TOTALBCICMSFRETECTRITEM = 0, '+
  //  ' OMF_TOTALBCALCULOPISCOFINSITEM = 0, '+
  //  ' OMF_TOTALBCICMSFRETENFITEM = 0, '+
  //  ' OMF_RATEADO = ''S'', '+
  //  ' OMF_DATAALTERACAO = DEV_DATAALTERACAO, '+
  //  ' OMF_INTEGRACAOERP = '', '+
  //  ' OMF_NUMEROVOLUMES = DEV_NUMEROVOLUMES, '+
  //  ' OMF_PESOBRUTOITEM = DEV_PESOBRUTOITEM, '+
  //  ' OMF_PESOLIQUIDOITEM = DEV_PESOLIQUIDOITEM, '+
  //  ' OMF_01_ID_OLD = 0, '+
  //  ' OMF_ID_OLD = 0, '+
  //  ' DEV_ID_OLD = 0, '+
  //  ' DEV_01_ID_OLD = 0, '+
  //  ' OMF_TIPODOCTO = ''DVN'', '+
  //  ' OMF_PERCENTUALCOMISSAOITEM = DEV_PERCENTUALCOMISSAOITEM, '+
  //  ' OMF_VALORBASECALCULOPISCOFINSITEM = DEV_VALORBASECALCULOCOFINSITEM, '+
  //  ' OMF_TOTALBASECALCULOPISCOFINSITEM = DEV_TOTALBASECALCULOPISITEM, '+
  //  ' OMF_VALORBASEDESCTOCOMISSAOITEM = DEV_VALORBASEDESCTOCOMISSAOITEM, '+
  //  ' OMF_VALORCOMISSAOITEM = DEV_VALORCOMISSAOITEM, '+
  //  ' OMF_TOTALCOMISSAOITEM = DEV_TOTALCOMISSAOITEM, '+
  //  ' OMF_PERCENTUALIBPTITEM = DEV_PERCENTUALIBPTITEM, '+
  //  ' OMF_PERCENTUALIBPTMUNICIPALITEM = DEV_PERCENTUALIBPTMUNICIPALITEM, '+
  //  ' OMF_PERCENTUALIBPTESTADUALITEM = DEV_PERCENTUALIBPTESTADUALITEM, '+
  //  ' OMF_PERCENTUALIBPTNACIONALITEM = DEV_PERCENTUALIBPTNACIONALITEM, '+
  //  ' OMF_PERCENTUALIBPTIMPORTADOITEM = DEV_PERCENTUALIBPTIMPORTADOITEM, '+
  //  ' OMF_TOTALIBPTMUNICIPALITEM = DEV_TOTALIBPTMUNICIPALITEM, '+
  //  ' OMF_TOTALIBPTESTADUALITEM = DEV_TOTALIBPTESTADUALITEM, '+
  //  ' OMF_TOTALIBPTNACIONALITEM = DEV_TOTALIBPTNACIONALITEM, '+
  //  ' OMF_TOTALIBPTIMPORTADOITEM = DEV_TOTALIBPTIMPORTADOITEM, '+
  //  ' OMF_TOTALAPROXIMADOIMPOSTOITEM = DEV_TOTALAPROXIMADOIMPOSTOITEM, '+
  //  ' OMF_PERCENTUALFCPITEM = DEV_PERCENTUALFCPITEM, '+
  //  ' OMF_TOTALBASECALCULOFCPITEM = DEV_TOTALBASECALCULOFCPITEM, '+
  //  ' OMF_TOTALFCPITEM = DEV_TOTALFCPITEM, '+
  //  ' OMF_TOTALBASECALCULOFCPSTITEM = DEV_TOTALBASECALCULOFCPSTITEM, '+
  //  ' OMF_TOTALFCPSTITEM = DEV_TOTALFCPSTITEM '+
  //  ' OMF_TOTALBASECALCULOFCPRETITEM = DEV_TOTALBASECALCULOFCPRETITEM, '+
  //  ' OMF_TOTALFCPRETITEM = DEV_TOTALFCPRETITEM '+
  //  ' FROM DEV_00_01 '+
  //  ' LEFT JOIN PRO_00 ON DEV_00_01.PRO_CODIGO = PRO_00.PRO_CODIGO ');
    //----------------------------------------------------------------------------
    QueryList.Add('TDIZ_00', 'SELECT COM_CODIGO = 0, * FROM DIZ_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TDRQ_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM DRQ_00 '+
    ' WHERE DRQ_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TDRQ_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM DRQ_00_01 '+
    ' WHERE DRQ_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TDSP_00', 'SELECT COM_CODIGO = 0, * FROM DSP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TETQ_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM ETQ_00 '+
    ' WHERE ETQ_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TETQ_00_01', 'SELECT ETQ_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,ETQ_ANOGIRO '+
    ' ,ETQ_GIROJANEIRO '+
    ' ,ETQ_CUSTOCOMPRAJANEIRO '+
    ' ,ETQ_PRECOTABELAJANEIRO '+
    ' ,ETQ_PRECODIGITADOJANEIRO '+
    ' ,ETQ_QUANTIDADEVENDASJANEIRO '+
    ' ,ETQ_GIROFEVEREIRO '+
    ' ,ETQ_CUSTOCOMPRAFEVEREIRO '+
    ' ,ETQ_PRECOTABELAFEVEREIRO '+
    ' ,ETQ_PRECODIGITADOFEVEREIRO '+
    ' ,ETQ_QUANTIDADEVENDASFEVEREIRO '+
    ' ,ETQ_GIROMARCO '+
    ' ,ETQ_CUSTOCOMPRAMARCO '+
    ' ,ETQ_PRECOTABELAMARCO '+
    ' ,ETQ_PRECODIGITADOMARCO '+
    ' ,ETQ_QUANTIDADEVENDASMARCO '+
    ' ,ETQ_GIROABRIL '+
    ' ,ETQ_CUSTOCOMPRAABRIL '+
    ' ,ETQ_PRECOTABELAABRIL '+
    ' ,ETQ_PRECODIGITADOABRIL '+
    ' ,ETQ_QUANTIDADEVENDASABRIL '+
    ' ,ETQ_GIROMAIO '+
    ' ,ETQ_CUSTOCOMPRAMAIO '+
    ' ,ETQ_PRECOTABELAMAIO '+
    ' ,ETQ_PRECODIGITADOMAIO '+
    ' ,ETQ_QUANTIDADEVENDASMAIO '+
    ' ,ETQ_GIROJUNHO '+
    ' ,ETQ_CUSTOCOMPRAJUNHO '+
    ' ,ETQ_PRECOTABELAJUNHO '+
    ' ,ETQ_PRECODIGITADOJUNHO '+
    ' ,ETQ_QUANTIDADEVENDASJUNHO '+
    ' ,ETQ_GIROJULHO '+
    ' ,ETQ_CUSTOCOMPRAJULHO '+
    ' ,ETQ_PRECOTABELAJULHO '+
    ' ,ETQ_PRECODIGITADOJULHO '+
    ' ,ETQ_QUANTIDADEVENDASJULHO '+
    ' ,ETQ_GIROAGOSTO '+
    ' ,ETQ_CUSTOCOMPRAAGOSTO '+
    ' ,ETQ_PRECOTABELAAGOSTO '+
    ' ,ETQ_PRECODIGITADOAGOSTO '+
    ' ,ETQ_QUANTIDADEVENDASAGOSTO '+
    ' ,ETQ_GIROSETEMBRO '+
    ' ,ETQ_CUSTOCOMPRASETEMBRO '+
    ' ,ETQ_PRECOTABELASETEMBRO '+
    ' ,ETQ_PRECODIGITADOSETEMBRO '+
    ' ,ETQ_QUANTIDADEVENDASSETEMBRO '+
    ' ,ETQ_GIROOUTUBRO '+
    ' ,ETQ_CUSTOCOMPRAOUTUBRO '+
    ' ,ETQ_PRECOTABELAOUTUBRO '+
    ' ,ETQ_PRECODIGITADOOUTUBRO '+
    ' ,ETQ_QUANTIDADEVENDASOUTUBRO '+
    ' ,ETQ_GIRONOVEMBRO '+
    ' ,ETQ_CUSTOCOMPRANOVEMBRO '+
    ' ,ETQ_PRECOTABELANOVEMBRO '+
    ' ,ETQ_PRECODIGITADONOVEMBRO '+
    ' ,ETQ_QUANTIDADEVENDASNOVEMBRO '+
    ' ,ETQ_GIRODEZEMBRO '+
    ' ,ETQ_CUSTOCOMPRADEZEMBRO '+
    ' ,ETQ_PRECOTABELADEZEMBRO '+
    ' ,ETQ_PRECODIGITADODEZEMBRO '+
    ' ,ETQ_QUANTIDADEVENDASDEZEMBRO '+
    ' ,ETQ_01_ID_OLD '+
    ' FROM ETQ_00_01 '+
    ' WHERE ETQ_00_01.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TETQ_00_02', 'SELECT ETQ_02_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,ETQ_DATAVALIDADE '+
    ' ,ETQ_QUANTIDADEVALIDADE '+
    ' ,ETQ_DATAALTERACAO '+
    ' ,ETQ_LOTEVALIDADE '+
    ' ,ETQ_02_ID_OLD '+
    ' FROM ETQ_00_02 '+
    ' WHERE ETQ_00_02.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TETQG_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM ETQG_00 '+
    ' WHERE ETQG_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TETQP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM ETQP_00 '+
    ' WHERE ETQP_00.FIL_CODIGO IN (' + FiliaisWhere + ')');
    //----------------------------------------------------------------------------
    QueryList.Add('TEXP_00', 'SELECT COM_CODIGO = FIL_CODIGO, * FROM EXP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TEXP_00_01', 'SELECT COM_CODIGO = FIL_CODIGO, * FROM EXP_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00', 'SELECT FAT_ID '+
    ' ,FAT_NSV '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CGA_ID '+
    ' ,PDA_ID '+
    ' ,FAT_TIPO '+
    ' ,FPG_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,FAT_CPFCLIENTE '+
    ' ,FAT_NOMECLIENTE '+
    ' ,VND_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,PRZ_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,FAT_SERIE '+
    ' ,FAT_NOTAFISCAL '+
    ' ,FAT_NOTAFISCALSERVICO '+
    ' ,FAT_NUMERODOCTO '+
    ' ,FAT_DATALACRE '+
    ' ,FAT_DATAENTREGA '+
    ' ,FAT_DATALANCAMENTO '+
    ' ,FAT_DATACANCELAMENTO '+
    ' ,FAT_DATAATUALIZACAOFINANCEIRA '+
    ' ,FAT_TIPOFRETE '+
    ' ,FAT_NUMEROORCAMENTO '+
    ' ,FAT_COMISSAONEGOCIADA '+
    ' ,FAT_CODIGOLIBERACAOVENDA '+
    ' ,FAT_OBSERVACAOCANCELAMENTO '+
    ' ,FAT_NUMEROORDEMCOMPRA '+
    ' ,FAT_NUMERODOCTOREPRESENTANTE '+
    ' ,FAT_TOTALPESOBRUTO '+
    ' ,FAT_TOTALPESOLIQUIDO '+
    ' ,FAT_TOTALQTDFATURADA '+
    ' ,FAT_TOTALNUMEROVOLUMES '+
    ' ,FAT_PERCENTUALCOMISSAO '+
    ' ,FAT_TOTALBASEDESCONTOCOMISSAO '+
    ' ,FAT_PERCENTUALFINANCEIROPRAZO '+
    ' ,FAT_PERCENTUALDESCONTOPRAZO '+
    ' ,FAT_PERCENTUALDESCTOAVULSO '+
    ' ,FAT_PERCENTUALIBPTMUNICIPAL '+
    ' ,FAT_PERCENTUALIBPTESTADUAL '+
    ' ,FAT_PERCENTUALIBPTNACIONAL '+
    ' ,FAT_PERCENTUALIBPTIMPORTADO '+
    ' ,FAT_TOTALISS '+
    ' ,FAT_TOTALIPI '+
    ' ,FAT_TOTALPIS '+
    ' ,FAT_TOTALICMS '+
    ' ,FAT_TOTALICMSR '+
    ' ,FAT_TOTALFRETE '+
    ' ,FAT_TOTALCOFINS '+
    ' ,FAT_TOTALLIQUIDO '+
    ' ,FAT_TOTALSEGURO '+
    ' ,FAT_TOTALSERVICO '+
    ' ,FAT_TOTALADICIONAL '+
    ' ,FAT_TOTALPRODUTOS '+
    ' ,FAT_TOTALSUBSTRIBUTARIA '+
    ' ,FAT_TOTALDESPACESSORIA '+
    ' ,FAT_TOTALBASEISENTOICMS '+
    ' ,FAT_TOTALBASECALCULOICMS '+
    ' ,FAT_TOTALBASECALCULOMVA '+
    ' ,FAT_TOTALFINANCEIROPRAZO '+
    ' ,FAT_TOTALDESCTOITEM '+
    ' ,FAT_TOTALDESCTOPRAZO '+
    ' ,FAT_TOTALDESCTOAVULSO '+
    ' ,FAT_TOTALBASECALCULOISS '+
    ' ,FAT_TOTALBCALCULOPISCOFINS = FAT_TOTALBASECALCULOCOFINS '+
    ' ,FAT_TOTALAPROXIMADOIMPOSTO '+
    ' ,FAT_TOTALCOMPLEMENTONFICMS '+
    ' ,FAT_TOTALPRODUTOSLIQUIDO '+
    ' ,FAT_TOTALCOMISSAO '+
    ' ,FAT_TOTALTROCO '+
    ' ,FAT_PERCENTUALIBPT '+
    ' ,FAT_TOTALIBPTMUNICIPAL '+
    ' ,FAT_TOTALIBPTESTADUAL '+
    ' ,FAT_TOTALIBPTNACIONAL '+
    ' ,FAT_TOTALIBPTIMPORTADO '+
    ' ,FAT_TOTALBASECALCULOFCP '+
    ' ,FAT_TOTALFCP '+
    ' ,FAT_TOTALBASECALCULOFCPST '+
    ' ,FAT_TOTALFCPST '+
    ' ,FAT_TOTALBASECALCULOFCPRET '+
    ' ,FAT_TOTALFCPRET '+
    ' ,FAT_UFVEICULO '+
    ' ,FAT_PLACAVEICULO '+
    ' ,FAT_MARCAVOLUMES '+
    ' ,FAT_ESPECIEVOLUMES '+
    ' ,FAT_NUMERACAOVOLUMES '+
    ' ,FAT_INFCOMPLEMENTAR '+
    ' ,PES_CODIGOENTREGA '+
    ' ,PES_CODIGORETIRADA '+
    ' ,LIB_NUMEROLIBERACAO '+
    ' ,FAT_MESA '+
    ' ,FAT_OBSERVACAO '+
    ' ,FAT_POSVENDA '+
    ' ,FAT_DENEGADA '+
    ' ,FAT_CANCELADA '+
    ' ,FAT_DESATIVADO '+
    ' ,FAT_PROCESSADO '+
    ' ,FAT_LIVROFISCAL '+
    ' ,FAT_BLOQUEADO '+
    ' ,FAT_INTEGRACAO '+
    ' ,USERS_LOGIN '+
    ' ,FAT_HORAALTERACAO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,LIB_ID '+
    ' ,FAT_RPS '+
    ' ,FAT_COMPETENCIA = CAST(MONTH(FAT_DATALANCAMENTO) + YEAR(FAT_DATALANCAMENTO)AS VARCHAR(6)) '+
    ' ,CON_CODIGO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,CGA_ID_OLD = NULL '+
    ' ,LIB_ID_OLD = NULL '+
    ' ,PDA_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAO_OLD = NULL '+
    ' ,FAT_NUMEROREMESSA '+
    ' ,FAT_TOTALICMSDESONERADO '+
    ' ,FAT_EXPEDIDO = '+
    '   CASE '+
    '     WHEN FAT_00.FAT_EXPEDIDO IS NULL THEN ' + QuotedStr('N') + ' '+
    '     ELSE FAT_00.FAT_EXPEDIDO '+
    '   END '+
    ' ,FAT_RESERVARESTOQUE = ' + QuotedStr('N') + ' '+
    ' ,FAT_TIPOMOVTO = '+
    ' 	CASE '+
    ' 		WHEN (LEN(FAT_NOTAFISCAL) = 0) AND (LEN(FAT_NOTAFISCALSERVICO) = 0) AND FAT_PROCESSADO = ' + QuotedStr('N') + ' THEN ' + QuotedStr('ORC') + ' '+
    ' 		WHEN ((LEN(FAT_NOTAFISCAL) > 0) OR (LEN(FAT_NOTAFISCALSERVICO) > 0)) AND FAT_PROCESSADO = ' + QuotedStr('S') + ' THEN ' + QuotedStr('FAT') + ' '+
    '    	ELSE ' + QuotedStr('ORC') + ' '+
    '   END '+
    ' ,FAT_FATURADOPRODUTOS = '+
    ' 	CASE '+
    ' 		WHEN (LEN(FAT_NOTAFISCAL) > 0) AND FAT_PROCESSADO = ' + QuotedStr('S') + ' THEN ' + QuotedStr('S') + ' '+
    ' 		ELSE ' + QuotedStr('N') + ' '+
    ' 	END '+
    ' ,FAT_FATURADOSERVICOS = '+
    ' 	CASE '+
    ' 		WHEN (LEN(FAT_NOTAFISCALSERVICO) > 0) AND FAT_PROCESSADO = ' + QuotedStr('S') + ' THEN ' + QuotedStr('S') + ' '+
    ' 		ELSE ' + QuotedStr('N') + ' '+
    ' 	END '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' ,FAT_NUMEROLICITACAO = NULL '+
    ' FROM FAT_00 '+
    ' WHERE FAT_00.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_ID = PDA_ID '+
    ' ,FAT_NSV = ' + QuotedStr('') + ' '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CGA_ID '+
    ' ,PDA_ID '+
    ' ,FAT_TIPO = ' + QuotedStr('V') + ' '+
    ' ,FPG_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,FAT_CPFCLIENTE = NULL '+
    ' ,FAT_NOMECLIENTE = NULL '+
    ' ,VND_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,PRZ_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,FAT_SERIE = PDA_SERIE '+
    ' ,FAT_NOTAFISCAL = PDA_NOTAFISCAL '+
    ' ,FAT_NOTAFISCALSERVICO = NULL '+
    ' ,FAT_NUMERODOCTO = PDA_NUMERODOCTO '+
    ' ,FAT_DATALACRE = NULL '+
    ' ,FAT_DATAENTREGA = PDA_DATAENTREGA '+
    ' ,FAT_DATALANCAMENTO = PDA_DATALANCAMENTO '+
    ' ,FAT_DATACANCELAMENTO = PDA_DATACANCELAMENTO '+
    ' ,FAT_DATAATUALIZACAOFINANCEIRA = NULL '+
    ' ,FAT_TIPOFRETE = PDA_TIPOFRETE '+
    ' ,FAT_NUMEROORCAMENTO = NULL '+
    ' ,FAT_COMISSAONEGOCIADA = PDA_COMISSAONEGOCIADA '+
    ' ,FAT_CODIGOLIBERACAOVENDA = PDA_CODIGOLIBERACAOVENDA '+
    ' ,FAT_OBSERVACAOCANCELAMENTO = PDA_OBSERVACAOCANCELAMENTO '+
    ' ,FAT_NUMEROORDEMCOMPRA = PDA_NUMEROORDEMCOMPRA '+
    ' ,FAT_NUMERODOCTOREPRESENTANTE = PDA_NUMERODOCTOREPRESENTANTE '+
    ' ,FAT_TOTALPESOBRUTO = PDA_TOTALPESOBRUTO '+
    ' ,FAT_TOTALPESOLIQUIDO = PDA_TOTALPESOLIQUIDO '+
    ' ,FAT_TOTALQTDFATURADA = PDA_TOTALQTDPEDIDA '+
    ' ,FAT_TOTALNUMEROVOLUMES = PDA_TOTALNUMEROVOLUMES '+
    ' ,FAT_PERCENTUALCOMISSAO = PDA_PERCENTUALCOMISSAO '+
    ' ,FAT_TOTALBASEDESCONTOCOMISSAO = NULL '+
    ' ,FAT_PERCENTUALFINANCEIROPRAZO = PDA_PERCENTUALFINANCEIROPRAZO '+
    ' ,FAT_PERCENTUALDESCONTOPRAZO = PDA_PERCENTUALDESCONTOPRAZO '+
    ' ,FAT_PERCENTUALDESCTOAVULSO = PDA_PERCENTUALDESCTOAVULSO '+
    ' ,FAT_PERCENTUALIBPTMUNICIPAL = PDA_PERCENTUALIBPTMUNICIPAL '+
    ' ,FAT_PERCENTUALIBPTESTADUAL = PDA_PERCENTUALIBPTESTADUAL '+
    ' ,FAT_PERCENTUALIBPTNACIONAL = PDA_PERCENTUALIBPTNACIONAL '+
    ' ,FAT_PERCENTUALIBPTIMPORTADO = PDA_PERCENTUALIBPTIMPORTADO '+
    ' ,FAT_TOTALISS = 0 '+
    ' ,FAT_TOTALIPI = PDA_TOTALIPI '+
    ' ,FAT_TOTALPIS = PDA_TOTALPIS '+
    ' ,FAT_TOTALICMS = PDA_TOTALICMS '+
    ' ,FAT_TOTALICMSR = PDA_TOTALICMSR '+
    ' ,FAT_TOTALFRETE = PDA_TOTALFRETE '+
    ' ,FAT_TOTALCOFINS = PDA_TOTALCOFINS '+
    ' ,FAT_TOTALLIQUIDO = PDA_TOTALLIQUIDO '+
    ' ,FAT_TOTALSEGURO = PDA_TOTALSEGURO '+
    ' ,FAT_TOTALSERVICO = 0 '+
    ' ,FAT_TOTALADICIONAL = PDA_TOTALADICIONAL '+
    ' ,FAT_TOTALPRODUTOS = PDA_TOTALPRODUTOS '+
    ' ,FAT_TOTALSUBSTRIBUTARIA = PDA_TOTALSUBSTRIBUTARIA '+
    ' ,FAT_TOTALDESPACESSORIA = PDA_TOTALDESPACESSORIA '+
    ' ,FAT_TOTALBASEISENTOICMS = PDA_TOTALBASEISENTOICMS '+
    ' ,FAT_TOTALBASECALCULOICMS = PDA_TOTALBASECALCULOICMS '+
    ' ,FAT_TOTALBASECALCULOMVA = PDA_TOTALBASECALCULOMVA '+
    ' ,FAT_TOTALFINANCEIROPRAZO = PDA_TOTALFINANCEIROPRAZO '+
    ' ,FAT_TOTALDESCTOITEM = PDA_TOTALDESCTOITEM '+
    ' ,FAT_TOTALDESCTOPRAZO = PDA_TOTALDESCTOPRAZO '+
    ' ,FAT_TOTALDESCTOAVULSO = PDA_TOTALDESCTOAVULSO '+
    ' ,FAT_TOTALBASECALCULOISS = 0 '+
    ' ,FAT_TOTALBCALCULOPISCOFINS = PDA_TOTALBASECALCULOCOFINS '+
    ' ,FAT_TOTALAPROXIMADOIMPOSTO = PDA_TOTALAPROXIMADOIMPOSTO '+
    ' ,FAT_TOTALCOMPLEMENTONFICMS = PDA_TOTALCOMPLEMENTONFICMS '+
    ' ,FAT_TOTALPRODUTOSLIQUIDO = PDA_TOTALPRODUTOSLIQUIDO '+
    ' ,FAT_TOTALCOMISSAO = PDA_TOTALCOMISSAO '+
    ' ,FAT_TOTALTROCO = 0 '+
    ' ,FAT_PERCENTUALIBPT = PDA_PERCENTUALIBPT '+
    ' ,FAT_TOTALIBPTMUNICIPAL = PDA_TOTALIBPTMUNICIPAL '+
    ' ,FAT_TOTALIBPTESTADUAL = PDA_TOTALIBPTESTADUAL '+
    ' ,FAT_TOTALIBPTNACIONAL = PDA_TOTALIBPTNACIONAL '+
    ' ,FAT_TOTALIBPTIMPORTADO = PDA_TOTALIBPTIMPORTADO '+
    ' ,FAT_TOTALBASECALCULOFCP = ISNULL(PDA_TOTALBASECALCULOFCP,0) '+
    ' ,FAT_TOTALFCP = PDA_TOTALFCP '+
    ' ,FAT_TOTALBASECALCULOFCPST = PDA_TOTALBASECALCULOFCPST '+
    ' ,FAT_TOTALFCPST = PDA_TOTALFCPST '+
    ' ,FAT_TOTALBASECALCULOFCPRET = PDA_TOTALBASECALCULOFCPRET '+
    ' ,FAT_TOTALFCPRET = PDA_TOTALFCPRET '+
    ' ,FAT_UFVEICULO = NULL '+
    ' ,FAT_PLACAVEICULO = NULL '+
    ' ,FAT_MARCAVOLUMES = PDA_MARCAVOLUMES '+
    ' ,FAT_ESPECIEVOLUMES = PDA_ESPECIEVOLUMES '+
    ' ,FAT_NUMERACAOVOLUMES = PDA_NUMERACAOVOLUMES '+
    ' ,FAT_INFCOMPLEMENTAR = NULL '+
    ' ,PES_CODIGOENTREGA '+
    ' ,PES_CODIGORETIRADA '+
    ' ,LIB_NUMEROLIBERACAO '+
    ' ,FAT_MESA = NULL '+
    ' ,FAT_OBSERVACAO = PDA_OBSERVACAO '+
    ' ,FAT_POSVENDA = NULL '+
    ' ,FAT_DENEGADA = NULL '+
    ' ,FAT_CANCELADA = PDA_CANCELADA '+
    ' ,FAT_DESATIVADO = PDA_DESATIVADO '+
    ' ,FAT_PROCESSADO = ' + QuotedStr('N') + ' '+
    ' ,FAT_LIVROFISCAL = ' + QuotedStr('N') + ' '+
    ' ,FAT_BLOQUEADO = PDA_BLOQUEADO '+
    ' ,FAT_INTEGRACAO = PDA_INTEGRACAO '+
    ' ,USERS_LOGIN '+
    ' ,FAT_HORAALTERACAO = NULL '+
    ' ,FAT_DATAALTERACAO = PDA_DATAALTERACAO '+
    ' ,LIB_ID '+
    ' ,FAT_RPS = NULL '+
    ' ,FAT_COMPETENCIA = CAST(MONTH(PDA_DATALANCAMENTO) + YEAR(PDA_DATALANCAMENTO) AS VARCHAR(6)) '+
    ' ,CON_CODIGO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,CGA_ID_OLD = CGA_ID '+
    ' ,LIB_ID_OLD = LIB_ID '+
    ' ,PDA_ID_OLD = PDA_ID '+
    ' ,FAT_INTEGRACAO_OLD = PDA_INTEGRACAO_OLD '+
    ' ,FAT_NUMEROREMESSA = NULL '+
    ' ,FAT_TOTALICMSDESONERADO = 0 '+
    ' ,FAT_EXPEDIDO = '+
    '   CASE '+
    '     WHEN PDA_EXPEDIDO IS NULL THEN ' + QuotedStr('N') + ' '+
    '     ELSE PDA_EXPEDIDO '+
    '   END '+
    ' ,FAT_RESERVARESTOQUE = ' + QuotedStr('S') + ' '+
    ' ,FAT_TIPOMOVTO = '+
    ' 	CASE '+
    '   	WHEN (LEN(PDA_NOTAFISCAL) = 0) AND PDA_FATURADO = ' + QuotedStr('N') + ' THEN ' + QuotedStr('ORC') + ' '+
    '  	 	ELSE ' + QuotedStr('PDA_VERIFICAR') + ' '+
    '  	END '+
    ' ,FAT_FATURADOPRODUTOS = ' + QuotedStr('N') + ' '+
    ' ,FAT_FATURADOSERVICOS = ' + QuotedStr('N') + ' '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('PDA') + ' + CAST(PDA_ID AS VARCHAR(6))) '+
    ' ,FAT_NUMEROLICITACAO = PDA_NUMEROLICITACAO '+
    ' FROM PDA_00 '+
    ' WHERE (PDA_00.PDA_FATURADO = ' + QuotedStr('N') + ') '+
    ' AND (PDA_00.FIL_CODIGO IN (' + FiliaisWhere + ')) '+
    ' AND (PDA_00.PDA_CANCELADA = ' + QuotedStr('N') + ') '+
    ' AND (PDA_00.PDA_DESATIVADO = ' + QuotedStr('N') + ') '+
    ' AND (LEN(PDA_00.PDA_NOTAFISCAL) = 0) '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_ID = ORS_ID '+
    ' ,FAT_NSV = ' + QuotedStr('') + ' '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CGA_ID = NULL '+
    ' ,PDA_ID = NULL '+
    ' ,FAT_TIPO = ' + QuotedStr('V') + ' '+
    ' ,FPG_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,FAT_CPFCLIENTE = NULL '+
    ' ,FAT_NOMECLIENTE = ORS_NOMECLIENTE '+
    ' ,VND_CODIGO '+
    ' ,TRP_CODIGO = NULL '+
    ' ,PRZ_CODIGO '+
    ' ,MNF_CODIGO = NULL '+
    ' ,TDC_CODIGO = NULL '+
    ' ,NTO_CODIGO = NTO_CODIGO '+
    ' ,CTB_CODIGO = NULL '+
    ' ,CFOP_CODIGO = CFOP_CODIGO '+
    ' ,CCU_CODIGO = NULL '+
    ' ,FAT_SERIE = NULL '+
    ' ,FAT_NOTAFISCAL = ORS_NOTAFISCAL '+
    ' ,FAT_NOTAFISCALSERVICO = ORS_NOTAFISCALSERVICO '+
    ' ,FAT_NUMERODOCTO = ORS_NUMERODOCTO '+
    ' ,FAT_DATALACRE = NULL '+
    ' ,FAT_DATAENTREGA = NULL '+
    ' ,FAT_DATALANCAMENTO = ORS_DATAEMISSAO '+
    ' ,FAT_DATACANCELAMENTO = ORS_DATACANCELAMENTO '+
    ' ,FAT_DATAATUALIZACAOFINANCEIRA = NULL '+
    ' ,FAT_TIPOFRETE = ORS_TIPOFRETE '+
    ' ,FAT_NUMEROORCAMENTO = NULL '+
    ' ,FAT_COMISSAONEGOCIADA = ORS_COMISSAONEGOCIADA '+
    ' ,FAT_CODIGOLIBERACAOVENDA = NULL '+
    ' ,FAT_OBSERVACAOCANCELAMENTO = ORS_OBSERVACAOCANCELAMENTO '+
    ' ,FAT_NUMEROORDEMCOMPRA = ' + QuotedStr('') + ' '+
    ' ,FAT_NUMERODOCTOREPRESENTANTE = ' + QuotedStr('') + ' '+
    ' ,FAT_TOTALPESOBRUTO = 0 '+
    ' ,FAT_TOTALPESOLIQUIDO = 0 '+
    ' ,FAT_TOTALQTDFATURADA = ORS_TOTALQTDPEDIDA '+
    ' ,FAT_TOTALNUMEROVOLUMES = 0 '+
    ' ,FAT_PERCENTUALCOMISSAO = ORS_PERCENTUALCOMISSAO '+
    ' ,FAT_TOTALBASEDESCONTOCOMISSAO = ORS_TOTALBASEDESCONTOCOMISSAO '+
    ' ,FAT_PERCENTUALFINANCEIROPRAZO = 0 '+
    ' ,FAT_PERCENTUALDESCONTOPRAZO = 0 '+
    ' ,FAT_PERCENTUALDESCTOAVULSO = ORS_PERCENTUALDESCTOAVULSO '+
    ' ,FAT_PERCENTUALIBPTMUNICIPAL = 0 '+
    ' ,FAT_PERCENTUALIBPTESTADUAL = 0 '+
    ' ,FAT_PERCENTUALIBPTNACIONAL = 0 '+
    ' ,FAT_PERCENTUALIBPTIMPORTADO = 0 '+
    ' ,FAT_TOTALISS = ORS_TOTALISS '+
    ' ,FAT_TOTALIPI = ORS_TOTALIPI '+
    ' ,FAT_TOTALPIS = ORS_TOTALPIS '+
    ' ,FAT_TOTALICMS = ORS_TOTALICMS '+
    ' ,FAT_TOTALICMSR = ORS_TOTALICMSR '+
    ' ,FAT_TOTALFRETE = 0 '+
    ' ,FAT_TOTALCOFINS = ORS_TOTALCOFINS '+
    ' ,FAT_TOTALLIQUIDO = ORS_TOTALLIQUIDO '+
    ' ,FAT_TOTALSEGURO = 0 '+
    ' ,FAT_TOTALSERVICO = ORS_TOTALSERVICOS '+
    ' ,FAT_TOTALADICIONAL = 0 '+
    ' ,FAT_TOTALPRODUTOS = ORS_TOTALPRODUTOS '+
    ' ,FAT_TOTALSUBSTRIBUTARIA = ORS_TOTALSUBSTRIBUTARIA '+
    ' ,FAT_TOTALDESPACESSORIA = (ORS_TOTALACRESCIMOITEM + ORS_TOTALACRESCIMOAVULSO) '+
    ' ,FAT_TOTALBASEISENTOICMS = ORS_TOTALBASEISENTOICMS '+
    ' ,FAT_TOTALBASECALCULOICMS = ORS_TOTALBASECALCULOICMS '+
    ' ,FAT_TOTALBASECALCULOMVA = ORS_TOTALBASECALCULOMVA '+
    ' ,FAT_TOTALFINANCEIROPRAZO = 0 '+
    ' ,FAT_TOTALDESCTOITEM = ORS_TOTALDESCTOITEM '+
    ' ,FAT_TOTALDESCTOPRAZO = 0 '+
    ' ,FAT_TOTALDESCTOAVULSO = ORS_TOTALDESCTOAVULSO '+
    ' ,FAT_TOTALBASECALCULOISS = ORS_TOTALBASECALCULOISS '+
    ' ,FAT_TOTALBCALCULOPISCOFINS = ORS_TOTALBASECALCULOCOFINS '+
    ' ,FAT_TOTALAPROXIMADOIMPOSTO = ORS_TOTALAPROXIMADOIMPOSTO '+
    ' ,FAT_TOTALCOMPLEMENTONFICMS = 0 '+
    ' ,FAT_TOTALPRODUTOSLIQUIDO = ORS_TOTALPRODUTOSLIQUIDO '+
    ' ,FAT_TOTALCOMISSAO = ORS_TOTALCOMISSAO '+
    ' ,FAT_TOTALTROCO = 0 '+
    ' ,FAT_PERCENTUALIBPT = 0 '+
    ' ,FAT_TOTALIBPTMUNICIPAL = ORS_TOTALIBPTMUNICIPAL '+
    ' ,FAT_TOTALIBPTESTADUAL = ORS_TOTALIBPTESTADUAL '+
    ' ,FAT_TOTALIBPTNACIONAL = ORS_TOTALIBPTNACIONAL '+
    ' ,FAT_TOTALIBPTIMPORTADO = ORS_TOTALIBPTIMPORTADO '+
    ' ,FAT_TOTALBASECALCULOFCP = ORS_TOTALBASECALCULOFCP '+
    ' ,FAT_TOTALFCP = 0 '+
    ' ,FAT_TOTALBASECALCULOFCPST = ORS_TOTALBASECALCULOFCPST '+
    ' ,FAT_TOTALFCPST = ORS_TOTALFCPST '+
    ' ,FAT_TOTALBASECALCULOFCPRET = ORS_TOTALBASECALCULOFCPRET '+
    ' ,FAT_TOTALFCPRET = ORS_TOTALFCPRET '+
    ' ,FAT_UFVEICULO = NULL '+
    ' ,FAT_PLACAVEICULO = NULL '+
    ' ,FAT_MARCAVOLUMES = NULL '+
    ' ,FAT_ESPECIEVOLUMES = NULL '+
    ' ,FAT_NUMERACAOVOLUMES = NULL '+
    ' ,FAT_INFCOMPLEMENTAR = NULL '+
    ' ,PES_CODIGOENTREGA = NULL '+
    ' ,PES_CODIGORETIRADA = NULL '+
    ' ,LIB_NUMEROLIBERACAO '+
    ' ,FAT_MESA = NULL '+
    ' ,FAT_OBSERVACAO = ORS_OBSERVACAO '+
    ' ,FAT_POSVENDA = NULL '+
    ' ,FAT_DENEGADA = NULL '+
    ' ,FAT_CANCELADA = ORS_CANCELADA '+
    ' ,FAT_DESATIVADO = ' + QuotedStr('N') + ' '+
    ' ,FAT_PROCESSADO = ' + QuotedStr('N') + ' '+
    ' ,FAT_LIVROFISCAL = ' + QuotedStr('N') + ' '+
    ' ,FAT_BLOQUEADO = ORS_BLOQUEADO '+
    ' ,FAT_INTEGRACAO = ORS_INTEGRACAO '+
    ' ,USERS_LOGIN = NULL '+
    ' ,FAT_HORAALTERACAO = NULL '+
    ' ,FAT_DATAALTERACAO = ORS_DATAALTERACAO '+
    ' ,LIB_ID '+
    ' ,FAT_RPS = NULL '+
    ' ,FAT_COMPETENCIA = CAST(MONTH(ORS_DATAEMISSAO) + YEAR(ORS_DATAEMISSAO) AS VARCHAR(6)) '+
    ' ,CON_CODIGO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,CGA_ID_OLD = NULL '+
    ' ,LIB_ID_OLD = NULL '+
    ' ,PDA_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAO_OLD = NULL '+
    ' ,FAT_NUMEROREMESSA = NULL '+
    ' ,FAT_TOTALICMSDESONERADO = ORS_TOTALICMSDESONERADO '+
    ' ,FAT_EXPEDIDO = ' + QuotedStr('N') + ' '+
    ' ,FAT_RESERVARESTOQUE = ' + QuotedStr('S') + ' '+
    ' ,FAT_TIPOMOVTO = ORS_TIPODOCUMENTO '+
    ' ,FAT_FATURADOPRODUTOS = ' + QuotedStr('N') + ' '+
    ' ,FAT_FATURADOSERVICOS = ' + QuotedStr('N') + ' '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_ID AS VARCHAR(6))) '+
    ' ,FAT_NUMEROLICITACAO = NULL '+
    ' FROM ORS_00 '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND (ORS_00.FIL_CODIGO IN (' + FiliaisWhere + ')) '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_01', ' SELECT FAT_01_ID '+
    ' ,COM_CODIGO = FAT_00_01.FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,TAB_CODIGO '+
    ' ,LEE_CODIGO '+
    ' ,GAI_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTC_CODIGO '+
    ' ,FAT_LEFSTATUS '+
    ' ,FAT_DESTAQUE_NF '+
    ' ,FAT_QTDFATURADA '+
    ' ,FAT_QTDDEVOLVIDA '+
    ' ,FAT_QTDENTREGUE '+
    ' ,FAT_QTDRECOLHIDA '+
    ' ,FAT_PRECOCUSTO '+
    ' ,FAT_PRECOVENDA '+
    ' ,FAT_PRECOTABELA '+
    ' ,FAT_PRECOLIQUIDO '+
    ' ,FAT_PRECODIGITADO '+
    ' ,FAT_PRECOBASEDESCTO '+
    ' ,FAT_NUMEROVOLUMES '+
    ' ,FAT_PERCENTUALIPIITEM '+
    ' ,FAT_PERCENTUALPISITEM '+
    ' ,FAT_PERCENTUALMVAITEM '+
    ' ,FAT_PERCENTUALICMSITEM '+
    ' ,FAT_PERCENTUALCOFINSITEM '+
    ' ,FAT_PERCENTUALFRETEITEM '+
    ' ,FAT_PERCENTUALDESCTOITEM '+
    ' ,FAT_PERCENTUALSEGUROITEM '+
    ' ,FAT_PERCENTUALREDUCAOBCITEM '+
    ' ,FAT_PERCENTUALICMSDESTINOITEM '+
    ' ,FAT_PERCENTUALDESPACESSORIAITEM '+
    ' ,FAT_PERCENTUALCOMISSAOITEM '+
    ' ,FAT_VALORPISITEM '+
    ' ,FAT_VALORIPIITEM '+
    ' ,FAT_VALORICMSITEM '+
    ' ,FAT_VALORICMSRITEM '+
    ' ,FAT_VALORFRETEITEM '+
    ' ,FAT_VALORCOFINSITEM '+
    ' ,FAT_VALORDESCTOITEM '+
    ' ,FAT_VALORSEGUROITEM '+
    ' ,FAT_VALORBASEOUTROSITEM '+
    ' ,FAT_VALORDESCTOPRAZOITEM '+
    ' ,FAT_VALORDESCTOAVULSOITEM '+
    ' ,FAT_VALORDESPACESSORIAITEM '+
    ' ,FAT_VALORSUBSTRIBUTARIAITEM '+
    ' ,FAT_VALORBASEISENTOICMSITEM '+
    ' ,FAT_VALORBASECALCULOMVAITEM '+
    ' ,FAT_VALORBASECALCULOICMSITEM '+
    ' ,FAT_VALORFINANCEIROPRAZOITEM '+
    ' ,FAT_VALORCOMPLEMENTONFICMSITEM '+
    ' ,FAT_VALORBCALCULOPISCOFINSITEM = FAT_VALORBASECALCULOPISITEM '+
    ' ,FAT_VALORCOMISSAOITEM '+
    ' ,FAT_TOTALCOMISSAOITEM '+
    ' ,FAT_TOTALPISITEM '+
    ' ,FAT_TOTALIPIITEM '+
    ' ,FAT_TOTALICMSITEM '+
    ' ,FAT_TOTALICMSRITEM '+
    ' ,FAT_TOTALFRETEITEM '+
    ' ,FAT_TOTALCOFINSITEM '+
    ' ,FAT_TOTALDESCTOITEM '+
    ' ,FAT_TOTALSEGUROITEM '+
    ' ,FAT_TOTALBASEOUTROSITEM '+
    ' ,FAT_TOTALDESCTOPRAZOITEM '+
    ' ,FAT_TOTALDESCTOAVULSOITEM '+
    ' ,FAT_TOTALDESPACESSORIAITEM '+
    ' ,FAT_TOTALSUBSTRIBUTARIAITEM '+
    ' ,FAT_TOTALBASEISENTOICMSITEM '+
    ' ,FAT_TOTALBASECALCULOMVAITEM '+
    ' ,FAT_TOTALBASECALCULOICMSITEM '+
    ' ,FAT_TOTALFINANCEIROPRAZOITEM '+
    ' ,FAT_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,FAT_TOTALBCALCULOPISCOFINSITEM = FAT_TOTALBASECALCULOPISITEM '+
    ' ,FAT_TOTALPRECOLIQUIDO '+
    ' ,FAT_TOTALPRECOVENDA '+
    ' ,FAT_TOTALPRECOCUSTO '+
    ' ,FAT_TOTALPRECOTABELA '+
    ' ,FAT_TOTALPRECODIGITADO '+
    ' ,FAT_TOTALPRECOBASEDESCTO '+
    ' ,FAT_PERCENTUALIBPTITEM '+
    ' ,FAT_TOTALAPROXIMADOIMPOSTOITEM '+
    ' ,FAT_PESOBRUTOITEM '+
    ' ,FAT_PESOLIQUIDOITEM '+
    ' ,FAT_ORDEMITEM '+
    ' ,FAT_ORDEMXMLITEM '+
    ' ,FAT_PERCENTUALIBPTMUNICIPALITEM '+
    ' ,FAT_PERCENTUALIBPTESTADUALITEM '+
    ' ,FAT_PERCENTUALIBPTNACIONALITEM '+
    ' ,FAT_PERCENTUALIBPTIMPORTADOITEM '+
    ' ,FAT_TOTALIBPTMUNICIPALITEM '+
    ' ,FAT_TOTALIBPTESTADUALITEM '+
    ' ,FAT_TOTALIBPTNACIONALITEM '+
    ' ,FAT_TOTALIBPTIMPORTADOITEM '+
    ' ,FAT_PERCENTUALFCPITEM '+
    ' ,FAT_TOTALBASECALCULOFCPITEM '+
    ' ,FAT_TOTALFCPITEM '+
    ' ,FAT_TOTALBASECALCULOFCPSTITEM '+
    ' ,FAT_TOTALFCPSTITEM '+
    ' ,FAT_TOTALBASECALCULOFCPRETITEM '+
    ' ,FAT_TOTALFCPRETITEM '+
    ' ,FAT_TOTALREDUCAOBCSTITEM '+
    ' ,FAT_VALORREDUCAOBCSTITEM '+
    ' ,FAT_PERCENTUALREDUCAOBCSTITEM '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_01_ID_OLD '+
    ' ,FAT_ID_OLD '+
    ' ,FAT_CSTIPI '+
    ' ,FAT_TOTALICMSDESONERADOITEM '+
    ' ,FAT_MOTIVODESONERACAO '+
    ' ,FAT_ICMSDESONERADO '+
    ' ,FAT_CODIGOBENEFICIO '+
    ' ,FAT_OBSERVACAOPRODUTONFE '+
    ' ,FAT_TABELAPRECO_PRO = NULL '+
    ' ,PRO_DESCRICAO = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' ,FAT_PERCENTUALICMSCOMPETE '+
    ' ,FAT_TOTALDESCTOCDCITEM '+
    ' ,FAT_VALORDESCTOCDCITEM '+
    ' ,FAT_TOTALCOFINSITEM '+
    ' FROM FAT_00_01 '+
    ' WHERE FAT_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_01_ID = PDA_01_ID '+
    ' ,COM_CODIGO = PDA_00_01.FIL_CODIGO '+
    ' ,FAT_ID = PDA_00_01.PDA_ID '+
    ' ,TAB_CODIGO '+
    ' ,LEE_CODIGO '+
    ' ,GAI_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,PDA_00_01.CFOP_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTC_CODIGO '+
    ' ,FAT_LEFSTATUS = PDA_LEFSTATUS '+
    ' ,FAT_DESTAQUE_NF = PDA_DESTAQUE_NF '+
    ' ,FAT_QTDFATURADA = PDA_QTDPEDIDA '+
    ' ,FAT_QTDDEVOLVIDA = 0 '+
    ' ,FAT_QTDENTREGUE = 0 '+
    ' ,FAT_QTDRECOLHIDA = 0 '+
    ' ,FAT_PRECOCUSTO = PDA_PRECOCUSTO '+
    ' ,FAT_PRECOVENDA = PDA_PRECOVENDA '+
    ' ,FAT_PRECOTABELA = PDA_PRECOTABELA '+
    ' ,FAT_PRECOLIQUIDO = PDA_PRECOLIQUIDO '+
    ' ,FAT_PRECODIGITADO = PDA_PRECODIGITADO '+
    ' ,FAT_PRECOBASEDESCTO = PDA_PRECOBASEDESCTO '+
    ' ,FAT_NUMEROVOLUMES = PDA_NUMEROVOLUMES '+
    ' ,FAT_PERCENTUALIPIITEM = PDA_PERCENTUALIPIITEM '+
    ' ,FAT_PERCENTUALPISITEM = PDA_PERCENTUALPISITEM '+
    ' ,FAT_PERCENTUALMVAITEM = PDA_PERCENTUALMVAITEM '+
    ' ,FAT_PERCENTUALICMSITEM = PDA_PERCENTUALICMSITEM '+
    ' ,FAT_PERCENTUALCOFINSITEM = PDA_PERCENTUALCOFINSITEM '+
    ' ,FAT_PERCENTUALFRETEITEM = PDA_PERCENTUALFRETEITEM '+
    ' ,FAT_PERCENTUALDESCTOITEM = PDA_PERCENTUALDESCTOITEM '+
    ' ,FAT_PERCENTUALSEGUROITEM = PDA_PERCENTUALSEGUROITEM '+
    ' ,FAT_PERCENTUALREDUCAOBCITEM = PDA_PERCENTUALREDUCAOBCITEM '+
    ' ,FAT_PERCENTUALICMSDESTINOITEM = PDA_PERCENTUALICMSDESTINOITEM '+
    ' ,FAT_PERCENTUALDESPACESSORIAITEM = PDA_PERCENTUALDESPACESSORIAITEM '+
    ' ,FAT_PERCENTUALCOMISSAOITEM = PDA_PERCENTUALCOMISSAOITEM '+
    ' ,FAT_VALORPISITEM = PDA_VALORPISITEM '+
    ' ,FAT_VALORIPIITEM = PDA_VALORIPIITEM '+
    ' ,FAT_VALORICMSITEM = PDA_VALORICMSITEM '+
    ' ,FAT_VALORICMSRITEM = PDA_VALORICMSRITEM '+
    ' ,FAT_VALORFRETEITEM = PDA_VALORFRETEITEM '+
    ' ,FAT_VALORCOFINSITEM = PDA_VALORCOFINSITEM '+
    ' ,FAT_VALORDESCTOITEM = PDA_VALORDESCTOITEM '+
    ' ,FAT_VALORSEGUROITEM = PDA_VALORSEGUROITEM '+
    ' ,FAT_VALORBASEOUTROSITEM = PDA_VALORBASEOUTROSITEM '+
    ' ,FAT_VALORDESCTOPRAZOITEM = PDA_VALORDESCTOPRAZOITEM '+
    ' ,FAT_VALORDESCTOAVULSOITEM = PDA_VALORDESCTOAVULSOITEM '+
    ' ,FAT_VALORDESPACESSORIAITEM = PDA_VALORDESPACESSORIAITEM '+
    ' ,FAT_VALORSUBSTRIBUTARIAITEM = PDA_VALORSUBSTRIBUTARIAITEM '+
    ' ,FAT_VALORBASEISENTOICMSITEM = PDA_VALORBASEISENTOICMSITEM '+
    ' ,FAT_VALORBASECALCULOMVAITEM = PDA_VALORBASECALCULOMVAITEM '+
    ' ,FAT_VALORBASECALCULOICMSITEM = PDA_VALORBASECALCULOICMSITEM '+
    ' ,FAT_VALORFINANCEIROPRAZOITEM = PDA_VALORFINANCEIROPRAZOITEM '+
    ' ,FAT_VALORCOMPLEMENTONFICMSITEM = PDA_VALORCOMPLEMENTONFICMSITEM '+
    ' ,FAT_VALORBCALCULOPISCOFINSITEM = PDA_VALORBASECALCULOPISITEM '+
    ' ,FAT_VALORCOMISSAOITEM = PDA_VALORCOMISSAOITEM '+
    ' ,FAT_TOTALCOMISSAOITEM = PDA_TOTALCOMISSAOITEM '+
    ' ,FAT_TOTALPISITEM = PDA_TOTALPISITEM '+
    ' ,FAT_TOTALIPIITEM = PDA_TOTALIPIITEM '+
    ' ,FAT_TOTALICMSITEM = PDA_TOTALICMSITEM '+
    ' ,FAT_TOTALICMSRITEM = PDA_TOTALICMSRITEM '+
    ' ,FAT_TOTALFRETEITEM = PDA_TOTALFRETEITEM '+
    ' ,FAT_TOTALCOFINSITEM = PDA_TOTALCOFINSITEM '+
    ' ,FAT_TOTALDESCTOITEM = PDA_00_01.PDA_TOTALDESCTOITEM '+
    ' ,FAT_TOTALSEGUROITEM = PDA_TOTALSEGUROITEM '+
    ' ,FAT_TOTALBASEOUTROSITEM = PDA_TOTALBASEOUTROSITEM '+
    ' ,FAT_TOTALDESCTOPRAZOITEM = PDA_TOTALDESCTOPRAZOITEM '+
    ' ,FAT_TOTALDESCTOAVULSOITEM = PDA_TOTALDESCTOAVULSOITEM '+
    ' ,FAT_TOTALDESPACESSORIAITEM = PDA_TOTALDESPACESSORIAITEM '+
    ' ,FAT_TOTALSUBSTRIBUTARIAITEM = PDA_TOTALSUBSTRIBUTARIAITEM '+
    ' ,FAT_TOTALBASEISENTOICMSITEM = PDA_TOTALBASEISENTOICMSITEM '+
    ' ,FAT_TOTALBASECALCULOMVAITEM = PDA_TOTALBASECALCULOMVAITEM '+
    ' ,FAT_TOTALBASECALCULOICMSITEM = PDA_TOTALBASECALCULOICMSITEM '+
    ' ,FAT_TOTALFINANCEIROPRAZOITEM = PDA_TOTALFINANCEIROPRAZOITEM '+
    ' ,FAT_TOTALCOMPLEMENTONFICMSITEM = PDA_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,FAT_TOTALBCALCULOPISCOFINSITEM = PDA_TOTALBASECALCULOPISITEM '+
    ' ,FAT_TOTALPRECOLIQUIDO = PDA_TOTALPRECOLIQUIDO '+
    ' ,FAT_TOTALPRECOVENDA = PDA_TOTALPRECOVENDA '+
    ' ,FAT_TOTALPRECOCUSTO = PDA_TOTALPRECOCUSTO '+
    ' ,FAT_TOTALPRECOTABELA = PDA_TOTALPRECOTABELA '+
    ' ,FAT_TOTALPRECODIGITADO = PDA_TOTALPRECODIGITADO '+
    ' ,FAT_TOTALPRECOBASEDESCTO = PDA_TOTALPRECOBASEDESCTO '+
    ' ,FAT_PERCENTUALIBPTITEM = PDA_PERCENTUALIBPTITEM '+
    ' ,FAT_TOTALAPROXIMADOIMPOSTOITEM = PDA_TOTALAPROXIMADOIMPOSTOITEM '+
    ' ,FAT_PESOBRUTOITEM = PDA_PESOBRUTOITEM '+
    ' ,FAT_PESOLIQUIDOITEM = PDA_PESOLIQUIDOITEM '+
    ' ,FAT_ORDEMITEM = PDA_ORDEMITEM '+
    ' ,FAT_ORDEMXMLITEM = PDA_ORDEMXMLITEM '+
    ' ,FAT_PERCENTUALIBPTMUNICIPALITEM = PDA_PERCENTUALIBPTMUNICIPALITEM '+
    ' ,FAT_PERCENTUALIBPTESTADUALITEM = PDA_PERCENTUALIBPTESTADUALITEM '+
    ' ,FAT_PERCENTUALIBPTNACIONALITEM = PDA_PERCENTUALIBPTNACIONALITEM '+
    ' ,FAT_PERCENTUALIBPTIMPORTADOITEM = PDA_PERCENTUALIBPTIMPORTADOITEM '+
    ' ,FAT_TOTALIBPTMUNICIPALITEM = PDA_TOTALIBPTMUNICIPALITEM '+
    ' ,FAT_TOTALIBPTESTADUALITEM = PDA_TOTALIBPTESTADUALITEM '+
    ' ,FAT_TOTALIBPTNACIONALITEM = PDA_TOTALIBPTNACIONALITEM '+
    ' ,FAT_TOTALIBPTIMPORTADOITEM = PDA_TOTALIBPTIMPORTADOITEM '+
    ' ,FAT_PERCENTUALFCPITEM = PDA_PERCENTUALFCPITEM '+
    ' ,FAT_TOTALBASECALCULOFCPITEM = PDA_TOTALBASECALCULOFCPITEM '+
    ' ,FAT_TOTALFCPITEM = PDA_TOTALFCPITEM '+
    ' ,FAT_TOTALBASECALCULOFCPSTITEM = PDA_TOTALBASECALCULOFCPSTITEM '+
    ' ,FAT_TOTALFCPSTITEM = PDA_TOTALFCPSTITEM '+
    ' ,FAT_TOTALBASECALCULOFCPRETITEM = PDA_TOTALBASECALCULOFCPRETITEM '+
    ' ,FAT_TOTALFCPRETITEM = PDA_TOTALFCPRETITEM '+
    ' ,FAT_TOTALREDUCAOBCSTITEM = PDA_TOTALREDUCAOBCSTITEM '+
    ' ,FAT_VALORREDUCAOBCSTITEM = PDA_VALORREDUCAOBCSTITEM '+
    ' ,FAT_PERCENTUALREDUCAOBCSTITEM = PDA_PERCENTUALREDUCAOBCSTITEM '+
    ' ,FAT_DATAALTERACAO = PDA_00_01.PDA_DATAALTERACAO '+
    ' ,FAT_01_ID_OLD = PDA_01_ID_OLD '+
    ' ,FAT_ID_OLD = PDA_00_01.PDA_ID_OLD '+
    ' ,FAT_CSTIPI = NULL '+
    ' ,FAT_TOTALICMSDESONERADOITEM = 0 '+
    ' ,FAT_MOTIVODESONERACAO = NULL '+
    ' ,FAT_ICMSDESONERADO = NULL '+
    ' ,FAT_CODIGOBENEFICIO = NULL '+
    ' ,FAT_OBSERVACAOPRODUTONFE = PDA_OBSERVACAOPRODUTONFE '+
    ' ,FAT_TABELAPRECO_PRO = NULL '+
    ' ,PRO_DESCRICAO = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('PDA') + ' + CAST(PDA_00_01.PDA_ID AS VARCHAR(6))) '+
    ' ,FAT_PERCENTUALICMSCOMPETE = 0 '+
    ' ,FAT_TOTALDESCTOCDCITEM = PDA_TOTALDESCTOCDCITEM '+
    ' ,FAT_VALORDESCTOCDCITEM = PDA_VALORDESCTOCDCITEM '+
    ' ,FAT_TOTALCOFINSITEM = PDA_TOTALCOFINSITEM '+
    ' FROM PDA_00_01 '+
    ' LEFT JOIN PDA_00 ON PDA_00_01.PDA_ID = PDA_00.PDA_ID '+
    ' AND PDA_00_01.FIL_CODIGO = PDA_00.FIL_CODIGO '+
    ' WHERE PDA_00.PDA_FATURADO = ' + QuotedStr('N') + ' '+
    ' AND PDA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' AND (LEN(PDA_00.PDA_NOTAFISCAL) = 0) '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_01_ID = ORS_01_ID '+
    ' ,COM_CODIGO = ORS_00_01.FIL_CODIGO '+
    ' ,FAT_ID = ORS_00_01.ORS_ID '+
    ' ,TAB_CODIGO '+
    ' ,LEE_CODIGO = LEE_CODIGO '+
    ' ,GAI_CODIGO = GAI_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,LEF_CODIGO = LEF_CODIGO '+
    ' ,CST_CODIGO = CST_CODIGO '+
    ' ,NCM_CODIGO = NCM_CODIGO '+
    ' ,CFOP_CODIGO = ORS_00_01.CFOP_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTC_CODIGO '+
    ' ,FAT_LEFSTATUS = ORS_LEFSTATUS '+
    ' ,FAT_DESTAQUE_NF = ORS_DESTAQUE_NF '+
    ' ,FAT_QTDFATURADA = ORS_QTDPEDIDA '+
    ' ,FAT_QTDDEVOLVIDA = 0 '+
    ' ,FAT_QTDENTREGUE = 0 '+
    ' ,FAT_QTDRECOLHIDA = 0 '+
    ' ,FAT_PRECOCUSTO = ORS_PRECOCUSTO '+
    ' ,FAT_PRECOVENDA = ORS_PRECOVENDA '+
    ' ,FAT_PRECOTABELA = ORS_PRECOTABELA '+
    ' ,FAT_PRECOLIQUIDO =  ORS_PRECOLIQUIDO '+
    ' ,FAT_PRECODIGITADO = ORS_PRECODIGITADO '+
    ' ,FAT_PRECOBASEDESCTO = ORS_PRECOBASEDESCTO '+
    ' ,FAT_NUMEROVOLUMES = ORS_NUMEROVOLUMES '+
    ' ,FAT_PERCENTUALIPIITEM = ORS_PERCENTUALIPIITEM '+
    ' ,FAT_PERCENTUALPISITEM = ORS_PERCENTUALPISITEM '+
    ' ,FAT_PERCENTUALMVAITEM = ORS_PERCENTUALMVAITEM '+
    ' ,FAT_PERCENTUALICMSITEM = ORS_PERCENTUALICMSITEM '+
    ' ,FAT_PERCENTUALCOFINSITEM = ORS_PERCENTUALCOFINSITEM '+
    ' ,FAT_PERCENTUALFRETEITEM = 0 '+
    ' ,FAT_PERCENTUALDESCTOITEM = ORS_PERCENTUALDESCTOITEM '+
    ' ,FAT_PERCENTUALSEGUROITEM = 0 '+
    ' ,FAT_PERCENTUALREDUCAOBCITEM = ORS_PERCENTUALREDUCAOBCITEM '+
    ' ,FAT_PERCENTUALICMSDESTINOITEM = ORS_PERCENTUALICMSDESTINOITEM '+
    ' ,FAT_PERCENTUALDESPACESSORIAITEM = ORS_PERCENTUALACRESCIMOITEM '+
    ' ,FAT_PERCENTUALCOMISSAOITEM = ORS_PERCENTUALCOMISSAOITEM '+
    ' ,FAT_VALORPISITEM = ORS_VALORPISITEM '+
    ' ,FAT_VALORIPIITEM = ORS_VALORIPIITEM '+
    ' ,FAT_VALORICMSITEM = ORS_VALORICMSITEM '+
    ' ,FAT_VALORICMSRITEM = ORS_VALORICMSRITEM '+
    ' ,FAT_VALORFRETEITEM = ORS_VALORFRETEITEM '+
    ' ,FAT_VALORCOFINSITEM = ORS_VALORCOFINSITEM '+
    ' ,FAT_VALORDESCTOITEM = ORS_VALORDESCTOITEM '+
    ' ,FAT_VALORSEGUROITEM = 0 '+
    ' ,FAT_VALORBASEOUTROSITEM = ORS_VALORBASEOUTROSITEM '+
    ' ,FAT_VALORDESCTOPRAZOITEM = ORS_VALORDESCTOPRAZOITEM '+
    ' ,FAT_VALORDESCTOAVULSOITEM = ORS_VALORDESCTOAVULSOITEM '+
    ' ,FAT_VALORDESPACESSORIAITEM = ORS_VALORDESPACESSORIAITEM '+
    ' ,FAT_VALORSUBSTRIBUTARIAITEM = 0 '+
    ' ,FAT_VALORBASEISENTOICMSITEM = ORS_VALORBASEISENTOICMSITEM '+
    ' ,FAT_VALORBASECALCULOMVAITEM = ORS_VALORBASECALCULOMVAITEM '+
    ' ,FAT_VALORBASECALCULOICMSITEM = ORS_VALORBASECALCULOICMSITEM '+
    ' ,FAT_VALORFINANCEIROPRAZOITEM = ORS_VALORFINANCEIROPRAZOITEM '+
    ' ,FAT_VALORCOMPLEMENTONFICMSITEM = 0 '+
    ' ,FAT_VALORBCALCULOPISCOFINSITEM = ORS_VALORBASECALCULOPISITEM '+
    ' ,FAT_VALORCOMISSAOITEM = ORS_VALORCOMISSAOITEM '+
    ' ,FAT_TOTALCOMISSAOITEM = ORS_TOTALCOMISSAOITEM '+
    ' ,FAT_TOTALPISITEM = ORS_TOTALPISITEM '+
    ' ,FAT_TOTALIPIITEM = ORS_TOTALIPIITEM '+
    ' ,FAT_TOTALICMSITEM = ORS_TOTALICMSITEM '+
    ' ,FAT_TOTALICMSRITEM = ORS_TOTALICMSRITEM '+
    ' ,FAT_TOTALFRETEITEM = ORS_TOTALFRETEITEM '+
    ' ,FAT_TOTALCOFINSITEM = ORS_TOTALCOFINSITEM '+
    ' ,FAT_TOTALDESCTOITEM = ORS_00_01.ORS_TOTALDESCTOITEM '+
    ' ,FAT_TOTALSEGUROITEM = 0 '+
    ' ,FAT_TOTALBASEOUTROSITEM = ORS_TOTALBASEOUTROSITEM '+
    ' ,FAT_TOTALDESCTOPRAZOITEM = ORS_TOTALDESCTOPRAZOITEM '+
    ' ,FAT_TOTALDESCTOAVULSOITEM = ORS_TOTALDESCTOAVULSOITEM '+
    ' ,FAT_TOTALDESPACESSORIAITEM = ORS_TOTALDESPACESSORIAITEM '+
    ' ,FAT_TOTALSUBSTRIBUTARIAITEM = ORS_TOTALSUBSTRIBUTARIAITEM '+
    ' ,FAT_TOTALBASEISENTOICMSITEM = ORS_TOTALBASEISENTOICMSITEM '+
    ' ,FAT_TOTALBASECALCULOMVAITEM = ORS_TOTALBASECALCULOMVAITEM '+
    ' ,FAT_TOTALBASECALCULOICMSITEM = ORS_TOTALBASECALCULOICMSITEM '+
    ' ,FAT_TOTALFINANCEIROPRAZOITEM = ORS_TOTALFINANCEIROPRAZOITEM '+
    ' ,FAT_TOTALCOMPLEMENTONFICMSITEM = 0 '+
    ' ,FAT_TOTALBCALCULOPISCOFINSITEM = ORS_TOTALBASECALCULOPISITEM '+
    ' ,FAT_TOTALPRECOLIQUIDO = ORS_TOTALPRECOLIQUIDO '+
    ' ,FAT_TOTALPRECOVENDA = ORS_TOTALPRECOVENDA '+
    ' ,FAT_TOTALPRECOCUSTO = ORS_TOTALPRECOCUSTO '+
    ' ,FAT_TOTALPRECOTABELA = ORS_TOTALPRECOTABELA '+
    ' ,FAT_TOTALPRECODIGITADO = ORS_TOTALPRECODIGITADO '+
    ' ,FAT_TOTALPRECOBASEDESCTO = ORS_TOTALPRECOBASEDESCTO '+
    ' ,FAT_PERCENTUALIBPTITEM = 0 '+
    ' ,FAT_TOTALAPROXIMADOIMPOSTOITEM = ORS_TOTALAPROXIMADOIMPOSTOITEM '+
    ' ,FAT_PESOBRUTOITEM = ORS_PESOBRUTOITEM '+
    ' ,FAT_PESOLIQUIDOITEM = ORS_PESOLIQUIDOITEM '+
    ' ,FAT_ORDEMITEM = 0 '+
    ' ,FAT_ORDEMXMLITEM = 0 '+
    ' ,FAT_PERCENTUALIBPTMUNICIPALITEM = 0 '+
    ' ,FAT_PERCENTUALIBPTESTADUALITEM = 0 '+
    ' ,FAT_PERCENTUALIBPTNACIONALITEM = 0 '+
    ' ,FAT_PERCENTUALIBPTIMPORTADOITEM = 0 '+
    ' ,FAT_TOTALIBPTMUNICIPALITEM = ORS_TOTALIBPTMUNICIPALITEM '+
    ' ,FAT_TOTALIBPTESTADUALITEM = ORS_TOTALIBPTESTADUALITEM '+
    ' ,FAT_TOTALIBPTNACIONALITEM = ORS_TOTALIBPTNACIONALITEM '+
    ' ,FAT_TOTALIBPTIMPORTADOITEM = ORS_TOTALIBPTIMPORTADOITEM '+
    ' ,FAT_PERCENTUALFCPITEM = ORS_PERCENTUALFCPITEM '+
    ' ,FAT_TOTALBASECALCULOFCPITEM = ORS_TOTALBASECALCULOFCPITEM '+
    ' ,FAT_TOTALFCPITEM = ORS_TOTALFCPITEM '+
    ' ,FAT_TOTALBASECALCULOFCPSTITEM = ORS_TOTALBASECALCULOFCPSTITEM '+
    ' ,FAT_TOTALFCPSTITEM = ORS_TOTALFCPSTITEM '+
    ' ,FAT_TOTALBASECALCULOFCPRETITEM = ORS_TOTALBASECALCULOFCPRETITEM '+
    ' ,FAT_TOTALFCPRETITEM = ORS_TOTALFCPRETITEM '+
    ' ,FAT_TOTALREDUCAOBCSTITEM = ORS_TOTALREDUCAOBCSTITEM '+
    ' ,FAT_VALORREDUCAOBCSTITEM = ORS_VALORREDUCAOBCSTITEM '+
    ' ,FAT_PERCENTUALREDUCAOBCSTITEM = ORS_PERCENTUALREDUCAOBCSTITEM '+
    ' ,FAT_DATAALTERACAO = ORS_00_01.ORS_DATAALTERACAO '+
    ' ,FAT_01_ID_OLD = ORS_01_ID_OLD '+
    ' ,FAT_ID_OLD = ORS_00_01.ORS_ID_OLD '+
    ' ,FAT_CSTIPI = NULL '+
    ' ,FAT_TOTALICMSDESONERADOITEM = ORS_TOTALICMSDESONERADOITEM '+
    ' ,FAT_MOTIVODESONERACAO = NULL '+
    ' ,FAT_ICMSDESONERADO = ORS_ICMSDESONERADO '+
    ' ,FAT_CODIGOBENEFICIO = ORS_CODIGOBENEFICIO '+
    ' ,FAT_OBSERVACAOPRODUTONFE = ORS_OBSERVACAOPRODUTONFE '+
    ' ,FAT_TABELAPRECO_PRO = ORS_TABELAPRECO_PRO '+
    ' ,PRO_DESCRICAO '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_00_01.ORS_ID AS VARCHAR(6))) '+
    ' ,FAT_PERCENTUALICMSCOMPETE = 0 '+
    ' ,FAT_TOTALDESCTOCDCITEM = ORS_TOTALDESCTOCDCITEM '+
    ' ,FAT_VALORDESCTOCDCITEM = ORS_VALORDESCTOCDCITEM '+
    ' ,FAT_TOTALCOFINSITEM = ORS_TOTALCOFINSITEM '+
    ' FROM ORS_00_01 '+
    ' LEFT JOIN ORS_00 ON ORS_00_01.ORS_ID = ORS_00.ORS_ID '+
    ' AND ORS_00_01.FIL_CODIGO = ORS_00.FIL_CODIGO '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND ORS_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_01_01', ' SELECT FAT_01_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,FAT_01_ID '+
    ' ,PRO_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,FAT_PERCENTUALRATEIO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_01_ID_OLD = NULL '+
    ' ,FAT_01_01_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_01_01 '+
    ' WHERE FAT_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_01_01_ID = ORS_01_01_ID '+
    ' ,COM_CODIGO = ORS_00_01_01.FIL_CODIGO '+
    ' ,FAT_ID = ORS_00_01_01.ORS_ID '+
    ' ,FAT_01_ID = ORS_01_ID '+
    ' ,PRO_CODIGO '+
    ' ,ORS_00_01_01.PES_CODIGO '+
    ' ,FAT_PERCENTUALRATEIO = ORS_PERCENTUALRATEIO '+
    ' ,FAT_DATAALTERACAO = ORS_00_01_01.ORS_DATAALTERACAO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_01_ID_OLD = NULL '+
    ' ,FAT_01_01_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_00_01_01.ORS_ID AS VARCHAR(6))) '+
    ' FROM ORS_00_01_01'+
    ' LEFT JOIN ORS_00 ON ORS_00_01_01.ORS_ID = ORS_00.ORS_ID '+
    ' AND ORS_00_01_01.FIL_CODIGO = ORS_00.FIL_CODIGO '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND ORS_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_02', ' SELECT FAT_02_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,MDO_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,FAT_GARANTIASERVICO '+
    ' ,FAT_QTDHORAS '+
    ' ,FAT_ORDEMITEM '+
    ' ,FAT_VALORSERVICO '+
    ' ,FAT_VALORPISITEM '+
    ' ,FAT_VALORISSITEM '+
    ' ,FAT_VALORCOFINSITEM '+
    ' ,FAT_VALORBASECALCULOISSITEM '+
    ' ,FAT_VALORBCALCULOPISCOFINSITEM = FAT_VALORBASECALCULOPISITEM '+
    ' ,FAT_VALORLIQUIDOSERVICO '+
    ' ,FAT_PERCENTUALISSITEM '+
    ' ,FAT_PERCENTUALPISITEM '+
    ' ,FAT_PERCENTUALCOFINSITEM '+
    ' ,FAT_TOTALISSITEM '+
    ' ,FAT_TOTALPISITEM '+
    ' ,FAT_TOTALSERVICO '+
    ' ,FAT_TOTALCOFINSITEM '+
    ' ,FAT_TOTALBASECALCULOISSITEM '+
    ' ,FAT_TOTALBCALCULOPISCOFINSITEM = FAT_TOTALBASECALCULOPISITEM '+
    ' ,FAT_TOTALLIQUIDOSERVICO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_02_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_CSTIPI '+
    ' ,MDO_DESCRICAO = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_02 '+
    ' WHERE FAT_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  FAT_02_ID = ORS_02_ID '+
    ' ,COM_CODIGO = ORS_00_02.FIL_CODIGO '+
    ' ,FAT_ID = ORS_00_02.ORS_ID '+
    ' ,MDO_CODIGO = MDO_CODIGO '+
    ' ,CSTPC_CODIGO = NULL '+
    ' ,FAT_GARANTIASERVICO = NULL '+
    ' ,FAT_QTDHORAS = ORS_QTDHORAS '+
    ' ,FAT_ORDEMITEM = 0 '+
    ' ,FAT_VALORSERVICO = ORS_VALORSERVICO '+
    ' ,FAT_VALORPISITEM = 0 '+
    ' ,FAT_VALORISSITEM = ORS_VALORISSITEM '+
    ' ,FAT_VALORCOFINSITEM = 0 '+
    ' ,FAT_VALORBASECALCULOISSITEM = ORS_VALORBASECALCULOISSITEM '+
    ' ,FAT_VALORBCALCULOPISCOFINSITEM = 0 '+
    ' ,FAT_VALORLIQUIDOSERVICO = ORS_VALORLIQUIDOSERVICO '+
    ' ,FAT_PERCENTUALISSITEM = ORS_PERCENTUALISSITEM '+
    ' ,FAT_PERCENTUALPISITEM = 0 '+
    ' ,FAT_PERCENTUALCOFINSITEM = 0 '+
    ' ,FAT_TOTALISSITEM = ORS_TOTALISSITEM '+
    ' ,FAT_TOTALPISITEM = 0 '+
    ' ,FAT_TOTALSERVICO = ORS_TOTALSERVICO '+
    ' ,FAT_TOTALCOFINSITEM = 0 '+
    ' ,FAT_TOTALBASECALCULOISSITEM = ORS_TOTALBASECALCULOISSITEM '+
    ' ,FAT_TOTALBCALCULOPISCOFINSITEM = 0 '+
    ' ,FAT_TOTALLIQUIDOSERVICO = ORS_TOTALLIQUIDOSERVICO '+
    ' ,FAT_DATAALTERACAO = ORS_00_02.ORS_DATAALTERACAO '+
    ' ,FAT_02_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_CSTIPI = NULL '+
    ' ,MDO_DESCRICAO '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_00_02.ORS_ID AS VARCHAR(6))) '+
    ' FROM ORS_00_02 '+
    ' LEFT JOIN ORS_00 ON ORS_00_02.ORS_ID = ORS_00.ORS_ID '+
    ' AND ORS_00_02.FIL_CODIGO = ORS_00.FIL_CODIGO '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND ORS_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_02_01', 'SELECT FAT_02_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,FAT_02_ID '+
    ' ,FAT_SIGLA '+
    ' ,MDO_CODIGO = PRO_CODIGO'+
    ' ,PES_CODIGO '+
    ' ,FAT_PERCENTUALRATEIO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_02_ID_OLD = NULL '+
    ' ,FAT_02_01_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_02_01 '+
    ' WHERE FAT_00_02_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_02_01_ID = ORS_02_01_ID '+
    ' ,COM_CODIGO = ORS_00_02_01.FIL_CODIGO '+
    ' ,FAT_ID = ORS_00_02_01.ORS_ID '+
    ' ,FAT_02_ID = ORS_02_ID '+
    ' ,FAT_SIGLA = NULL '+
    ' ,MDO_CODIGO '+
    ' ,ORS_00_02_01.PES_CODIGO '+
    ' ,FAT_PERCENTUALRATEIO = ORS_PERCENTUALRATEIO '+
    ' ,FAT_DATAALTERACAO = ORS_00_02_01.ORS_DATAALTERACAO '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_02_ID_OLD = NULL '+
    ' ,FAT_02_01_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_00_02_01.ORS_ID AS VARCHAR(6))) '+
    ' FROM ORS_00_02_01'+
    ' LEFT JOIN ORS_00 ON ORS_00_02_01.ORS_ID = ORS_00.ORS_ID '+
    ' AND ORS_00_02_01.FIL_CODIGO = ORS_00.FIL_CODIGO '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND ORS_00_02_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_03', 'SELECT FAT_03_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,FAT_DESCRICAO '+
    ' ,FAT_RECOLHERPRODUTO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_03_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_03' +
    ' WHERE FAT_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_04', 'SELECT FAT_04_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,VEI_CODIGO '+
    ' ,FAT_MACACO '+
    ' ,FAT_NUMEROOS '+
    ' ,FAT_KMVEICULO '+
    ' ,FAT_CHAVERODA '+
    ' ,FAT_DIASRETORNO '+
    ' ,FAT_CONDUTORENTRADA '+
    ' ,FAT_CONDUTORSAIDA '+
    ' ,FAT_HORAABERTURA '+
    ' ,FAT_DATAABERTURA '+
    ' ,FAT_DATAFECHAMENTO '+
    ' ,FAT_HORAFECHAMENTO '+
    ' ,FAT_OBSENTRADAVEICULO '+
    ' ,FAT_POSICAOTANQUEVEICULO '+
    ' ,FAT_OBSSOLICITACAOCLIENTE '+
    ' ,FAT_OBSFECHAMENTOORDEMSERVICO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_04_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_04 '+
    ' WHERE FAT_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_04_ID = NULL '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID = ORS_ID '+
    ' ,VEI_CODIGO '+
    ' ,FAT_MACACO = NULL '+
    ' ,FAT_NUMEROOS = ORS_NUMEROOS '+
    ' ,FAT_KMVEICULO = ORS_TOTALKMVEICULO '+
    ' ,FAT_CHAVERODA = NULL '+
    ' ,FAT_DIASRETORNO = ORS_DIASRETORNO '+
    ' ,FAT_CONDUTORENTRADA = NULL '+
    ' ,FAT_CONDUTORSAIDA = NULL '+
    ' ,FAT_HORAABERTURA = ORS_HORAEMISSAO '+
    ' ,FAT_DATAABERTURA = ORS_DATAEMISSAO '+
    ' ,FAT_DATAFECHAMENTO = ORS_DATAFECHAMENTO '+
    ' ,FAT_HORAFECHAMENTO = ORS_HORAFECHAMENTO '+
    ' ,FAT_OBSENTRADAVEICULO = ORS_OBSERVACAOENTRADA '+
    ' ,FAT_POSICAOTANQUEVEICULO = NULL '+
    ' ,FAT_OBSSOLICITACAOCLIENTE = ORS_SOLICITACOES '+
    ' ,FAT_OBSFECHAMENTOORDEMSERVICO = ORS_OBSERVACAOFECHAMENTO '+
    ' ,FAT_DATAALTERACAO = ORS_DATAALTERACAO '+
    ' ,FAT_04_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_ID AS VARCHAR(6))) '+
    ' FROM ORS_00'+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND ORS_00.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_05', ' SELECT FAT_05_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,FAT_DIA '+
    ' ,FPG_CODIGO '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,CID_IBGE '+
    ' ,BCO_CODIGO '+
    ' ,FAT_EMITENTE '+
    ' ,FAT_CONTA '+
    ' ,FAT_CIDADE '+
    ' ,FAT_AGENCIA '+
    ' ,FAT_NUMERODOCTO '+
    ' ,FAT_NUMEROPARCELA '+
    ' ,FAT_VALORPARCELA '+
    ' ,FAT_VENCTOCARTAO '+
    ' ,FAT_NUMEROCHEQUE '+
    ' ,FAT_DOCTOEMITENTE '+
    ' ,FAT_DATAVENCIMENTO '+
    ' ,FAT_AUTORIZACAOCARTAO '+
    ' ,FAT_PERCENTUALFINANCEIRO '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,FPG_TIPOPAGTOCOMISSAO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_NUMEROPARCELAFPG '+
    ' ,FAT_05_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_CREDITOCLIENTE = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_05 '+
    ' LEFT JOIN CID_00 ON CID_00.CID_CODIGO = FAT_00_05.CID_CODIGO '+
    ' WHERE FAT_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_05_ID = PDA_02_ID '+
    ' ,COM_CODIGO = PDA_00_02.FIL_CODIGO '+
    ' ,FAT_ID = PDA_00_02.PDA_ID '+
    ' ,FAT_DIA = PDA_DIA '+
    ' ,PDA_00_02.FPG_CODIGO '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,CID_IBGE = CID_00.CID_IBGE '+
    ' ,BCO_CODIGO '+
    ' ,FAT_EMITENTE = PDA_EMITENTE '+
    ' ,FAT_CONTA = PDA_CONTA '+
    ' ,FAT_CIDADE = PDA_CIDADE '+
    ' ,FAT_AGENCIA = PDA_AGENCIA '+
    ' ,FAT_NUMERODOCTO = NULL '+
    ' ,FAT_NUMEROPARCELA = PDA_NUMEROPARCELA '+
    ' ,FAT_VALORPARCELA = PDA_VALORPARCELA '+
    ' ,FAT_VENCTOCARTAO = PDA_VENCTOCARTAO '+
    ' ,FAT_NUMEROCHEQUE = NULL '+
    ' ,FAT_DOCTOEMITENTE = PDA_DOCTOEMITENTE '+
    ' ,FAT_DATAVENCIMENTO = PDA_DATAVENCIMENTO '+
    ' ,FAT_AUTORIZACAOCARTAO = PDA_AUTORIZACAOCARTAO '+
    ' ,FAT_PERCENTUALFINANCEIRO = PDA_PERCENTUALFINANCEIRO '+
    ' ,FPG_TIPOPAGAMENTO = FPG_TIPOPAGAMENTO '+
    ' ,FPG_TIPOPAGTOCOMISSAO = FPG_TIPOPAGTOCOMISSAO '+
    ' ,FAT_DATAALTERACAO = PDA_00_02.PDA_DATAALTERACAO '+
    ' ,FAT_NUMEROPARCELAFPG = NULL '+
    ' ,FAT_05_ID_OLD = PDA_02_ID_OLD '+
    ' ,FAT_ID_OLD = PDA_00_02.PDA_ID_OLD '+
    ' ,FAT_CREDITOCLIENTE = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('PDA') + ' + CAST(PDA_00_02.PDA_ID AS VARCHAR(6))) '+
    ' FROM PDA_00_02 '+
    ' LEFT JOIN CID_00 ON PDA_00_02.CID_CODIGO = CID_00.CID_CODIGO '+
    ' LEFT JOIN PDA_00 ON PDA_00_02.PDA_ID = PDA_00.PDA_ID '+
    ' AND PDA_00_02.FIL_CODIGO = PDA_00.FIL_CODIGO '+
    ' WHERE PDA_00.PDA_FATURADO = ' + QuotedStr('N') + ' '+
    ' AND (LEN(PDA_00.PDA_NOTAFISCAL) = 0) '+
    ' AND PDA_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT FAT_05_ID = ORS_04_ID '+
    ' ,COM_CODIGO = ORS_00_04.FIL_CODIGO '+
    ' ,FAT_ID = ORS_00_04.ORS_ID '+
    ' ,FAT_DIA = ORS_DIA '+
    ' ,ORS_00_04.FPG_CODIGO '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,CID_IBGE = CID_00.CID_IBGE '+
    ' ,BCO_CODIGO '+
    ' ,FAT_EMITENTE = ORS_EMITENTE '+
    ' ,FAT_CONTA = ORS_CONTA '+
    ' ,FAT_CIDADE = ORS_CIDADE '+
    ' ,FAT_AGENCIA = ORS_AGENCIA '+
    ' ,FAT_NUMERODOCTO = ORS_00_04.ORS_NUMERODOCTO '+
    ' ,FAT_NUMEROPARCELA = ORS_NUMEROPARCELA '+
    ' ,FAT_VALORPARCELA = ORS_VALORPARCELA '+
    ' ,FAT_VENCTOCARTAO = ORS_VENCTOCARTAO '+
    ' ,FAT_NUMEROCHEQUE = NULL '+
    ' ,FAT_DOCTOEMITENTE = ORS_DOCTOEMITENTE '+
    ' ,FAT_DATAVENCIMENTO = ORS_DATAVENCIMENTO '+
    ' ,FAT_AUTORIZACAOCARTAO = ORS_AUTORIZACAOCARTAO '+
    ' ,FAT_PERCENTUALFINANCEIRO = ORS_PERCENTUALFINANCEIRO '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,FPG_TIPOPAGTOCOMISSAO '+
    ' ,FAT_DATAALTERACAO = ORS_00_04.ORS_DATAALTERACAO '+
    ' ,FAT_NUMEROPARCELAFPG = NULL '+
    ' ,FAT_05_ID_OLD = ORS_04_ID_OLD '+
    ' ,FAT_ID_OLD = ORS_00_04.ORS_ID_OLD '+
    ' ,FAT_CREDITOCLIENTE = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_00_04.ORS_ID AS VARCHAR(6))) '+
    ' FROM ORS_00_04 '+
    ' LEFT JOIN CID_00 ON ORS_00_04.CID_CODIGO = CID_00.CID_CODIGO'+
    ' LEFT JOIN ORS_00 ON ORS_00_04.ORS_ID = ORS_00.ORS_ID '+
    ' AND ORS_00_04.FIL_CODIGO = ORS_00.FIL_CODIGO '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) '+
    ' AND ORS_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_06', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_ID '+
    ' ,FAT_06_ID '+
    ' ,FAT_SIGLA '+
    ' ,PRO_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,FAT_PERCENTUALRATEIO '+
    ' ,FAT_DATAALTERACAO '+
    ' ,FAT_06_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('FAT') + ' + CAST(FAT_ID AS VARCHAR(6))) '+
    ' FROM FAT_00_06 '+
    ' WHERE FAT_00_06.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  COM_CODIGO = ORS_00_01_01.FIL_CODIGO '+
    ' ,FAT_ID = ORS_00_01_01.ORS_ID '+
    ' ,FAT_06_ID = ORS_01_01_ID '+
    ' ,FAT_SIGLA = NULL '+
    ' ,PRO_CODIGO = PRO_CODIGO '+
    ' ,PES_CODIGO = ORS_00_01_01.PES_CODIGO '+
    ' ,FAT_PERCENTUALRATEIO = ORS_PERCENTUALRATEIO '+
    ' ,FAT_DATAALTERACAO = ORS_00_01_01.ORS_DATAALTERACAO '+
    ' ,FAT_06_ID_OLD = NULL '+
    ' ,FAT_ID_OLD = NULL '+
    ' ,FAT_INTEGRACAOERP = (' + QuotedStr('ORS') + ' + CAST(ORS_00_01_01.ORS_ID AS VARCHAR(6))) '+
    ' FROM ORS_00_01_01'+
    ' LEFT JOIN ORS_00 ON ORS_00_01_01.ORS_ID = ORS_00.ORS_ID '+
    ' AND ORS_00_01_01.FIL_CODIGO = ORS_00.FIL_CODIGO '+
    ' WHERE (LEN(ORS_00.ORS_NOTAFISCAL) = 0) '+
    ' AND (LEN(ORS_00.ORS_NOTAFISCALSERVICO) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOPRODUTOS) = 0) '+
    ' AND (LEN(ORS_00.ORS_IDFATURAMENTOSERVICOS) = 0) '+
    ' AND ORS_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_00_07', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM FAT_00_07 '+
    ' WHERE FAT_00_07.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFCM_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM FCM_00 '+
    ' WHERE FCM_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCOMPANY', ' SELECT COM_CODIGO = A.FIL_CODIGO '+
    ' ,COM_CNPJ_CPF = A.FIL_CNPJ '+
    ' ,COM_IE_RG = A.FIL_IE '+
    ' ,COM_RAZAO = A.FIL_RAZAO '+
    ' ,COM_FANTASIA = A.FIL_FANTASIA_OU_APELIDO '+
    ' ,CEP_CODIGO = A.CEP_CODIGO '+
    ' ,COM_ENDERECO = A.FIL_ENDERECO '+
    ' ,COM_NUMEROENDERECO = A.FIL_NUMEROENDERECO '+
    ' ,COM_BAIRRO = A.FIL_BAIRRO '+
    ' ,COM_PONTOREFERENCIA = A.FIL_PONTOREFERENCIA '+
    ' ,CID_IBGE = CID_00.CID_IBGE '+
    ' ,COM_CIDADE = CID_00.CID_NOME '+
    ' ,COM_UF = A.UFS_SIGLA '+
    ' ,COM_DDD_TELEFONE_1 = A.FIL_DDD_TELEFONE_1 '+
    ' ,COM_DDD_TELEFONE_2 = A.FIL_DDD_TELEFONE_2 '+
    ' ,COM_DDD_CELULAR_1 = A.FIL_DDD_CELULAR '+
    ' ,COM_DDD_CELULAR_2 = ' + QuotedStr('') + ' '+
    ' ,COM_EMAIL = A.FIL_EMAIL '+
    ' ,COM_HTTP = A.FIL_HTTP '+
    ' ,COM_OBSERVACAO = A.FIL_OBSERVACAO '+
    ' ,COM_IE_MUNICIPAL = A.FIL_IE_MUNICIPAL '+
    ' ,COM_STATUS = '+
    '  CASE A.FIL_DESATIVADO '+
    '    WHEN ' + QuotedStr('N') + ' THEN ' + QuotedStr('A') +' '+
    '    ELSE ' + QuotedStr('D') + ' '+
    '  END '+
    ' ,CFG_CODIGO = A.FIL_CODIGO '+
    ' ,COM_DATACADASTRO = NULL '+
    ' ,COM_DATAHORAALTERACAO = CAST(A.FIL_DATAALTERACAO AS DATETIME) '+
    ' ,COM_TIPOPESSOA = NULL '+
    ' ,COA_CODIGO = NULL '+
    ' ,COM_INTEGRACAO = NULL '+
    ' ,ERP_VND_CODIGO = NULL '+
    ' ,COM_CAIXAPOSTAL = A.FIL_CAIXAPOSTAL '+
    ' FROM FIL_00 A '+
    ' LEFT JOIN CID_00 '+
    '  ON CID_00.CID_CODIGO = A.CID_CODIGO '+
    ' WHERE A.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00', 'SELECT CFG_CODIGO = A.FIL_CODIGO '+
    ' ,CFG_DESCRICAO = A.FIL_RAZAO '+
    ' ,CFG_OBSERVACAO = A.FIL_OBSERVACAO '+
    ' ,CFG_DATAALTERACAO = A.FIL_DATAALTERACAO '+
    ' ,CFG_DESATIVADO = A.FIL_DESATIVADO '+
    ' ,COM_CODIGOPAIS = PAI_00.PAI_CODIGOPAIS '+
    ' ,CFG_PAIS = PAI_00.PAI_NOME '+
    ' ,CFG_IE_MUNICIPAL = A.FIL_IE_MUNICIPAL '+
    ' ,PRO_CODIGOANP = A.PRO_CODIGOANP '+
    ' ,CFG_LICENSEKEY = A.FIL_LICENSEKEY '+
    ' ,CFG_LICENSEKEYACTIVATION = A.FIL_LICENSEKEYACTIVATION '+
    ' ,CFG_SIGLA = A.FIL_SIGLA '+
    ' ,CFG_NOMESOCIOPRIETARIO = NULL '+
    ' FROM FIL_00 A '+
    ' LEFT JOIN UFS_00 ON  UFS_00.UFS_SIGLA = A.UFS_SIGLA '+
    ' LEFT JOIN PAI_00 ON UFS_00.PAI_CODIGO = PAI_00.PAI_CODIGO '+
    ' WHERE A.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00_01', 'SELECT CFG_CODIGO = FIL_CODIGO '+
    ' ,CFG_CONFIGURACOES = FIL_CONFIGURACOES '+
    ' ,CFG_PORTEESTADUAL = FIL_PORTEESTADUAL '+
    ' ,CFG_PORTEFEDERAL = FIL_PORTEFEDERAL '+
    ' ,CFG_TIPOEMPRESA = FIL_TIPOEMPRESA '+
    ' ,CFG_PATHSINTEGRA = FIL_PATHSINTEGRA '+
    ' ,CFG_TITULORELATORIO = FIL_TITULORELATORIO '+
    ' ,CFG_CONVENIOSINTEGRA = FIL_CONVENIOSINTEGRA '+
    ' ,CFG_REGISTROSINTEGRA = FIL_REGISTROSINTEGRA '+
    ' ,CFG_CODIGOLOJAMATRIZ = FIL_CODIGOLOJAMATRIZ '+
    ' ,CFG_DIASMAXDEVOLUCAO = FIL_DIASMAXDEVOLUCAO '+
    ' ,CFG_DIASPARAPROTESTAR = FIL_DIASPARAPROTESTAR '+
    ' ,CFG_TAXADEJUROSAOMES = FIL_TAXADEJUROSAOMES '+
    ' ,CFG_LIMITEDIFERENCANFE = FIL_LIMITEDIFERENCANFE '+
    ' ,CFG_DIASATRASOPERMITIDO = FIL_DIASATRASOPERMITIDO '+
    ' ,CFG_DIASBLOQUEARCLIENTE = FIL_DIASBLOQUEARCLIENTE '+
    ' ,CFG_VALORMAXPESSOAFISICA = FIL_VALORMAXPESSOAFISICA '+
    ' ,CFG_VALORMINFATURAMENTO = FIL_VALORMINFATURAMENTO '+
    ' ,CFG_DIASTRAVARCLIENTEINATIVO = FIL_DIASTRAVARCLIENTEINATIVO '+
    ' ,CFG_CHEQUECLIENTEMAXPRORROGAR = FIL_CHEQUECLIENTEMAXPRORROGAR '+
    ' ,TAB_CODIGOPADRAO '+
    ' ,PRZ_CODIGOPADRAO '+
    ' ,BCO_CODIGOPADRAO '+
    ' ,FPG_CODIGOPADRAO '+
    ' ,CTA_CODIGOPADRAO '+
    ' ,VND_CODIGOPADRAO '+
    ' ,CLI_CODIGOPADRAO '+
    ' ,TDC_CODIGOPADRAO '+
    ' ,CFG_TOTALGGFDIARIOPRODUCAO = FIL_TOTALGGFDIARIOPRODUCAO '+
    ' ,CFG_RATEIOPRODUCAO = FIL_RATEIOPRODUCAO '+
    ' ,CFG_PATHEXPORTACAOXML = FIL_PATHEXPORTACAOXML '+
    ' ,CFG_DATAALTERACAO = FIL_DATAALTERACAO '+
    ' ,CLI_INTEGRACAOCONTABIL '+
    ' ,FOR_INTEGRACAOCONTABIL '+
    ' ,CTA_CODIGOPADRAOCHEQUEPENDENTE '+
    ' ,NTO_CODIGOPADRAOCOMPRA '+
    ' ,NTO_CODIGOPADRAOVENDA '+
    ' ,NTO_CODIGOPADRAOVENDACPF '+
    ' ,CST_CODIGOPADRAO '+
    ' ,CFG_PATHEXPORTACAOCONTABIL = FIL_PATHEXPORTACAOCONTABIL '+
    ' ,CFG_PERCENTUALMAXDESCTO = FIL_PERCENTUALMAXDESCTO '+
    ' ,CFG_PERCENTUALCONTSOCIALMKP = FIL_PERCENTUALCONTSOCIALMKP '+
    ' ,CFG_PERCENTUALCOMISSAOVNDMKP = FIL_PERCENTUALCOMISSAOVNDMKP '+
    ' ,CFG_PERCENTUALIMPOSTORENDAMKP = FIL_PERCENTUALIMPOSTORENDAMKP '+
    ' ,CFG_PERCENTUALADMINISTRATIVOMKP = FIL_PERCENTUALADMINISTRATIVOMKP '+
    ' ,CFG_PERCENTUALSIMPLESMKP_1 = FIL_PERCENTUALSIMPLESMKP_1 '+
    ' ,CFG_PERCENTUALSIMPLESMKP_2 = FIL_PERCENTUALSIMPLESMKP_2 '+
    ' ,CFG_MSGBOLETO1 = FIL_MSGBOLETO1 '+
    ' ,CFG_MSGBOLETO2 = FIL_MSGBOLETO2 '+
    ' ,CFG_MSGBOLETO3 = FIL_MSGBOLETO3 '+
    ' ,CFG_MSGBOLETO4 = FIL_MSGBOLETO4 '+
    ' ,CFG_PATHEXPORTACAOCOLETOR = FIL_PATHEXPORTACAOCOLETOR '+
    ' ,CFG_PATHEXPORTACAOBALANCA = FIL_PATHEXPORTACAOBALANCA '+
    ' ,CFG_VRDESCTOARREDONDAMENTOPDV = FIL_VRDESCTOARREDONDAMENTOPDV '+
    ' ,CFG_OBSERVACAOEXPORTACAOCNAB_1 = FIL_OBSERVACAOEXPORTACAOCNAB_1 '+
    ' ,CFG_OBSERVACAOEXPORTACAOCNAB_2 = FIL_OBSERVACAOEXPORTACAOCNAB_2 '+
    ' ,CFG_OBSERVACAOEXPORTACAOCNAB_3 = FIL_OBSERVACAOEXPORTACAOCNAB_3 '+
    ' ,CFG_OBSERVACAOEXPORTACAOCNAB_4 = FIL_OBSERVACAOEXPORTACAOCNAB_4 '+
    ' ,CFG_OBSERVACAOEXPORTACAOCNAB_5 = FIL_OBSERVACAOEXPORTACAOCNAB_5 '+
    ' ,CFG_ORDEMFILTRAPRODUTOS = FIL_ORDEMFILTRAPRODUTOS '+
    ' ,CFG_TIPOENVIOREGISTROSINTEGRA74 = FIL_TIPOENVIOREGISTROSINTEGRA74 '+
    ' ,TAB_CODIGOATACADO '+
    ' ,CFG_PATHSETTING = FIL_PATHSETTING '+
    ' ,CFG_PATHLOGORELATORIO = FIL_PATHLOGORELATORIO '+
    ' ,CFG_MODOFUNCIONAMENTO = FIL_MODOFUNCIONAMENTO '+
    ' ,CFG_DIASBLOQUEIOPALM_BOL = FIL_DIASBLOQUEIOPALM_BOL '+
    ' ,CFG_DIASBLOQUEIOPALM_CHE = FIL_DIASBLOQUEIOPALM_CHE '+
    ' ,CFG_DIASBLOQUEIOPALM_CAR = FIL_DIASBLOQUEIOPALM_CAR '+
    ' ,TRP_CODIGOPADRAO '+
    ' ,POR_CODIGOPADRAO '+
    ' ,CFG_EMAILSERVIDORENVIO = FIL_EMAILSERVIDORENVIO '+
    ' ,CFG_EMAILENVIO = FIL_EMAILENVIO '+
    ' ,CFG_EMAILUSUARIOENVIO = FIL_EMAILUSUARIOENVIO '+
    ' ,CFG_EMAILSENHAENVIO = FIL_EMAILSENHAENVIO '+
    ' ,CFG_EMAILPORTAENVIO = FIL_EMAILPORTAENVIO '+
    ' ,CFG_EMAILSSL = FIL_EMAILSSL '+
    ' ,CFG_MENSAGEMCARTACOBRANCA1 = FIL_MENSAGEMCARTACOBRANCA1 '+
    ' ,CFG_MENSAGEMCARTACOBRANCA2 = FIL_MENSAGEMCARTACOBRANCA2 '+
    ' ,GRP_CODIGOPADRAO '+
    ' ,SGP_CODIGOPADRAO '+
    ' ,CFG_TIPOIMPRESSAODOCTOBOLETO = FIL_TIPOIMPRESSAODOCTOBOLETO '+
    ' ,CFG_IBPTCHAVE = FIL_IBPTCHAVE '+
    ' ,CFG_IBPTVERSAO = FIL_IBPTVERSAO '+
    ' ,CFG_QTDCASADECIMALVALORUNITARIO = FIL_QTDCASADECIMALVALORUNITARIO '+
    ' ,CFG_DIASVALIDADEORCAMENTO = FIL_DIASVALIDADEORCAMENTO '+
    ' ,CFG_CONFIGURACAOIMPRESSAOVENDA = FIL_CONFIGURACAOIMPRESSAOVENDA '+
    ' ,CFG_SENHALIBERACAOVENDA = FIL_SENHALIBERACAOVENDA '+
    ' ,CFG_MARKUPMINVENDA = FIL_MARKUPMINVENDA '+
    ' ,CFG_VALORTOLERANCIADESCTO = FIL_VALORTOLERANCIADESCTO '+
    ' ,CFG_VALORMINIMOPARCELAMENTO = FIL_VALORMINIMOPARCELAMENTO '+
    ' ,CFG_QTDCASADECIMALQUANTIDADE = FIL_QTDCASADECIMALQUANTIDADE '+
    ' ,CFG_TIPOFRETE = FIL_TIPOFRETE '+
    ' ,CFG_TIPOSELECAOPRODUTO = FIL_TIPOSELECAOPRODUTO '+
    ' ,CFG_EXIBICAOCAMPOSDIGPRODUTO = FIL_EXIBICAOCAMPOSDIGPRODUTO '+
    ' ,CFG_PERCENTUALMARGEMLUCRO = FIL_PERCENTUALMARGEMLUCRO '+
    ' ,NTO_CODIGOPADRAOSERVICO = NTO_CODIGOPADRAOSERVICO '+
    ' ,CFG_EMAILCONTABILXML = FIL_EMAILCONTABILXML '+
    ' FROM FIL_00_01 '+
    ' WHERE FIL_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00_02', 'SELECT CFG_CODIGO = FIL_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,TDC_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,CTR_SERIE '+
    ' ,CTR_SUBSERIE '+
    ' ,CTR_ESPECIE '+
    ' ,CTR_APOLICE '+
    ' ,CTR_NATUREZA '+
    ' ,CTR_COBRADORA '+
    ' ,CTR_NATUREZACARGA '+
    ' ,CTR_CONFIGURACOES '+
    ' ,CTR_PERCENTUALICMS '+
    ' ,CTR_SERIECONTIGENCIA '+
    ' ,CTR_MANIFESTOCARGACPA '+
    ' ,CTR_TIPOMEIOTRANSPORTE '+
    ' ,CTR_CONTRATORODOVIARIOCPA '+
    ' ,CTR_OBSERVACAO '+
    ' ,CTR_AMBIENTEENVIO '+
    ' ,CTR_TIPOEMISSAO '+
    ' ,CTR_FINALIDADE '+
    ' ,CTR_TIPODACTE '+
    ' ,CTR_CERTIFICADONUMEROSERIE '+
    ' ,CTR_CERTIFICADOSENHA '+
    ' ,CTR_UFDESTINO '+
    ' ,CTR_PROXYHOST '+
    ' ,CTR_PROXYPORTA '+
    ' ,CTR_PROXYUSUARIO '+
    ' ,CTR_PROXYSENHA '+
    ' ,CTR_PATHLOGOMARCA '+
    ' ,CTR_PATHSCHEMA '+
    ' ,CTR_PATHREPOSITORIO '+
    ' ,CTR_PATHARQENVIORESPOSTA '+
    ' ,CTR_ATUALIZARCTEINICIAR '+
    ' ,CTR_ENVIAREMAILAPOSAUTORIZACAO '+
    ' ,CFG_DATAALTERACAO = FIL_DATAALTERACAO '+
    ' ,CTR_RNTRC '+
    ' ,FPG_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,PRZ_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,CTR_EMAILSERVIDORENVIO '+
    ' ,CTR_EMAILENVIO '+
    ' ,CTR_EMAILUSUARIOENVIO '+
    ' ,CTR_EMAILSENHAENVIO '+
    ' ,CTR_EMAILPORTAENVIO '+
    ' ,CTR_EMAILSSL '+
    ' ,MFC_TIPOEMISSAO '+
    ' ,MFC_AMBIENTEENVIO '+
    ' ,MFC_TIPODACTE '+
    ' ,MFC_CERTIFICADONUMEROSERIE '+
    ' ,MFC_CERTIFICADOSENHA '+
    ' ,MFC_UFDESTINO '+
    ' ,MFC_PROXYHOST '+
    ' ,MFC_PROXYPORTA '+
    ' ,MFC_PROXYUSUARIO '+
    ' ,MFC_PROXYSENHA '+
    ' ,MFC_PATHLOGOMARCA '+
    ' ,MFC_PATHSCHEMA '+
    ' ,MFC_PATHREPOSITORIO '+
    ' ,MFC_PATHARQENVIORESPOSTA '+
    ' ,MFC_ATUALIZARCTEINICIAR '+
    ' ,MFC_ENVIAREMAILAPOSAUTORIZACAO '+
    ' ,MFC_EMAILSERVIDORENVIO '+
    ' ,MFC_EMAILENVIO '+
    ' ,MFC_EMAILUSUARIOENVIO '+
    ' ,MFC_EMAILSENHAENVIO '+
    ' ,MFC_EMAILPORTAENVIO '+
    ' ,MFC_EMAILSSL '+
    ' ,MNF_CODIGO_MFC '+
    ' ,MFC_SERIE '+
    ' ,MFC_SUBSERIE '+
    ' ,MFC_SERIECONTIGENCIA '+
    ' ,MFC_TIPOEMITENTE '+
    ' ,CTR_PERCENTUALIBPT '+
    ' ,CTR_TIPOFRETE '+
    ' ,CTR_PERCENTUALIBPTESTADUAL '+
    ' ,CTR_PERCENTUALIBPTNACIONAL '+
    ' ,CTR_SSLLIB '+
    ' ,MFC_SSLLIB '+
    ' ,CTR_GLOBALIZADO '+
    ' ,CTR_PERCENTUALCDICMSSIMPLES '+
    ' ,CTR_USUARIOAPISEGURADORA '+
    ' ,CTR_SENHAAPISEGURADORA '+
    ' ,CTR_CODIGOAPISEGURADORA '+
    ' ,CTR_AVERBARAUTOMATICAMENTE '+
    ' ,MFC_DECLARARAUTOMATICAMENTE '+
    ' ,MFC_INTEGRADORACIOT '+
    ' ,MFC_USUARIOINTEGRADORACIOT '+
    ' ,MFC_SENHAINTEGRADORACIOT '+
    ' ,MFC_HASHINTEGRADORACIOT '+
    ' ,MFC_PATHSCHEMACIOT '+
    ' ,MFC_PATHREPOSITORIOCIOT '+
    ' ,CTR_SERIEINTERESTADUAL '+
    ' ,CTR_ULTIMONSUCOLETA '+
    ' FROM FIL_00_02 '+
    ' WHERE FIL_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00_03', 'SELECT CFG_CODIGO = FIL_CODIGO '+
    ' ,NFE_FINALIDADE '+
    ' ,NFE_TIPOEMISSAO '+
    ' ,NFE_AMBIENTEENVIO '+
    ' ,NFE_PATHEXPORTACAO '+
    ' ,NFE_PATHIMPORTACAO '+
    ' ,MNF_CODIGOPADRAOSAIDA '+
    ' ,MNF_CODIGOPADRAOENTRADA '+
    ' ,CFG_PERCENTUALCDICMSSIMPLES = FIL_PERCENTUALCDICMSSIMPLES '+
    ' ,NFE_SERIENFE '+
    ' ,NFE_SERIENFECONTIGENCIA '+
    ' ,NFE_ESPECIE '+
    ' ,NFE_MARCA '+
    ' ,CFG_DATAALTERACAO = FIL_DATAALTERACAO '+
    ' ,MNF_CODIGOPADRAOSERVICO '+
    ' ,NFSE_SERIESERVICO '+
    ' ,NFE_TIPODANFE '+
    ' ,NFE_CERTIFICADONUMEROSERIE '+
    ' ,NFE_CERTIFICADOSENHA '+
    ' ,NFE_UFDESTINO '+
    ' ,NFE_PROXYHOST '+
    ' ,NFE_PROXYPORTA '+
    ' ,NFE_PROXYUSUARIO '+
    ' ,NFE_PROXYSENHA '+
    ' ,NFE_PATHLOGOMARCA '+
    ' ,NFE_PATHSCHEMA '+
    ' ,NFE_PATHREPOSITORIO '+
    ' ,NFE_PATHARQENVIORESPOSTA '+
    ' ,NFE_ATUALIZARNOTASINICIAR '+
    ' ,NFE_ENVIAREMAILAPOSAUTORIZACAO '+
    ' ,NFE_TIPODESCRICAOPRODUTO '+
    ' ,NFE_MENSAGEMRODAPENOTASAIDA '+
    ' ,NFE_MENSAGEMRODAPENOTAENTRADA '+
    ' ,NFE_EMAILSERVIDORENVIO '+
    ' ,NFE_EMAILENVIO '+
    ' ,NFE_EMAILUSUARIOENVIO '+
    ' ,NFE_EMAILSENHAENVIO '+
    ' ,NFE_EMAILPORTAENVIO '+
    ' ,NFE_EMAILSSL '+
    ' ,NFE_ORDEMIMPRESSAOITENS '+
    ' ,NFE_SSLLIB '+
    ' ,MNF_CODIGOPADRAONFC '+
    ' ,NFE_SERIENFC '+
    ' ,NFE_CODIGOCSC '+
    ' ,NFE_MOTIVOCONTIGENCIA '+
    ' ,NFE_CODIGOIDCSC '+
    ' ,NFE_IMPRIMENOTAPROMISSORIANFCE '+
    ' ,NFE_ULTIMONSUMANIFESTACAO '+
    ' ,NFSE_AMBIENTEENVIO '+
    ' ,NFSE_CERTIFICADONUMEROSERIE '+
    ' ,NFSE_CERTIFICADOSENHA '+
    ' ,NFSE_SSLLIB '+
    ' ,NFSE_IBGECIDADE '+
    ' ,NFSE_PROXYHOST '+
    ' ,NFSE_PROXYPORTA '+
    ' ,NFSE_PROXYUSUARIO '+
    ' ,NFSE_PROXYSENHA '+
    ' ,NFSE_PATHLOGOMARCA '+
    ' ,NFSE_PATHLOGOMARCAPREFEITURA '+
    ' ,NFSE_PATHSCHEMAPROVEDOR '+
    ' ,NFSE_PATHREPOSITORIO '+
    ' ,NFSE_PATHARQENVIORESPOSTA '+
    ' ,NFSE_PATHARQUIVOINI '+
    ' ,NFSE_ATUALIZARNOTASINICIAR '+
    ' ,NFSE_ENVIAREMAILAPOSAUTORIZACAO '+
    ' ,NFSE_WEBUSUARIO '+
    ' ,NFSE_WEBSENHA '+
    ' ,NFSE_WEBFRASESECRETA '+
    ' ,NFSE_REGIMETRIBUTACAO '+
    ' ,NFSE_INCENTIVADORCULTURAL '+
    ' ,NFSE_CIDADE '+
    ' FROM FIL_00_03 '+
    ' WHERE FIL_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00_04', 'SELECT CFG_CODIGO = FIL_CODIGO '+
    ' ,CFG_IND_ATIV = FIL_IND_ATIV '+
    ' ,CFG_TIPO_ESCRIT = FIL_TIPO_ESCRIT '+
    ' ,CFG_IND_NAT_PJ = FIL_IND_NAT_PJ '+
    ' ,CFG_COD_INC_TRIB = FIL_COD_INC_TRIB '+
    ' ,CFG_IND_APRO_CRED = FIL_IND_APRO_CRED '+
    ' ,CFG_IND_REG_CUM = FIL_IND_REG_CUM '+
    ' ,CFG_IND_ESCRI = FIL_IND_ESCRI '+
    ' ,CFG_DATAALTERACAO = FIL_DATAALTERACAO '+
    ' ,CFG_IND_SIT_ESP = FIL_IND_SIT_ESP '+
    ' ,CFG_COD_TIPO_CONT = FIL_COD_TIPO_CONT '+
    ' ,CFG_GERASPED = FIL_GERASPED '+
    ' ,CFG_ALIQ_CONT = FIL_ALIQ_CONT '+
    ' ,CFG_COD_REC = FIL_COD_REC '+
    ' ,CFG_COD_INC_TRIB_0145 = FIL_COD_INC_TRIB_0145 '+
    ' ,CFG_ACPREVIDENCIARIARECEITAB = FIL_ACPREVIDENCIARIARECEITAB '+
    ' ,CFG_COD_REC_FISCAL = FIL_COD_REC_FISCAL '+
    ' ,CFG_COD_VER_FISCAL = FIL_COD_VER_FISCAL '+
    ' ,CFG_NUM_CAMPO = FIL_NUM_CAMPO '+
    ' ,CFG_COD_REC_M205 = FIL_COD_REC_M205 '+
    ' ,CFG_COD_REC_M605 = FIL_COD_REC_M605 '+
    ' ,CFG_CONFIGURACOES = FIL_CONFIGURACOES '+
    ' ,CFG_COD_1400_PRODUTOR = FIL_COD_1400_PRODUTOR '+
    ' ,CFG_COD_1400_VEICULO = FIL_COD_1400_VEICULO '+
    ' ,CFG_COD_1400_TRANSPORTE = FIL_COD_1400_TRANSPORTE '+
    ' ,CFG_COD_VER_SPEDPC = FIL_COD_VER_SPEDPC '+
    ' ,CFG_CLAS_ESTAB_IND = FIL_CLAS_ESTAB_IND '+
    ' FROM FIL_00_04 '+
    ' WHERE FIL_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00_05', 'SELECT CFG_CODIGO = FIL_CODIGO '+
    ' ,CFG_DATAALTERACAO = FIL_DATAALTERACAO '+
    ' ,CCU_CODIGOPADRAOBCX = ISNULL(RTRIM(LTRIM(CCU_CODIGOPADRAOBCX)),0) '+
    ' ,* '+
    ' FROM FIL_00_05 '+
    ' WHERE FIL_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TCONFIG_00_06', 'SELECT CFG_CODIGO = FIL_CODIGO '+
    ' ,CFG_TRIBUTACAOENTRADACST_00 = FIL_TRIBUTACAOENTRADACST_00 '+
    ' ,CFG_TRIBUTACAOENTRADACST_10 = FIL_TRIBUTACAOENTRADACST_10 '+
    ' ,CFG_TRIBUTACAOENTRADACST_20 = FIL_TRIBUTACAOENTRADACST_20 '+
    ' ,CFG_TRIBUTACAOENTRADACST_30 = FIL_TRIBUTACAOENTRADACST_30 '+
    ' ,CFG_TRIBUTACAOENTRADACST_40 = FIL_TRIBUTACAOENTRADACST_40 '+
    ' ,CFG_TRIBUTACAOENTRADACST_41 = FIL_TRIBUTACAOENTRADACST_41 '+
    ' ,CFG_TRIBUTACAOENTRADACST_50 = FIL_TRIBUTACAOENTRADACST_50 '+
    ' ,CFG_TRIBUTACAOENTRADACST_51 = FIL_TRIBUTACAOENTRADACST_51 '+
    ' ,CFG_TRIBUTACAOENTRADACST_60 = FIL_TRIBUTACAOENTRADACST_60 '+
    ' ,CFG_TRIBUTACAOENTRADACST_70 = FIL_TRIBUTACAOENTRADACST_70 '+
    ' ,CFG_TRIBUTACAOENTRADACST_90 = FIL_TRIBUTACAOENTRADACST_90 '+
    ' ,CST_CODIGOPADRAOENTRADACST_00 '+
    ' ,CST_CODIGOPADRAOENTRADACST_10 '+
    ' ,CST_CODIGOPADRAOENTRADACST_20 '+
    ' ,CST_CODIGOPADRAOENTRADACST_30 '+
    ' ,CST_CODIGOPADRAOENTRADACST_40 '+
    ' ,CST_CODIGOPADRAOENTRADACST_41 '+
    ' ,CST_CODIGOPADRAOENTRADACST_50 '+
    ' ,CST_CODIGOPADRAOENTRADACST_51 '+
    ' ,CST_CODIGOPADRAOENTRADACST_60 '+
    ' ,CST_CODIGOPADRAOENTRADACST_70 '+
    ' ,CST_CODIGOPADRAOENTRADACST_90 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_00 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_10 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_20 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_30 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_40 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_41 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_50 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_51 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_60 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_70 '+
    ' ,CFOP_CODIGOPADRAOENTRADACST_90 '+
    ' ,CFG_TRIBUTACAOSAIDACST_00 = FIL_TRIBUTACAOSAIDACST_00 '+
    ' ,CFG_TRIBUTACAOSAIDACST_10 = FIL_TRIBUTACAOSAIDACST_10 '+
    ' ,CFG_TRIBUTACAOSAIDACST_20 = FIL_TRIBUTACAOSAIDACST_20 '+
    ' ,CFG_TRIBUTACAOSAIDACST_30 = FIL_TRIBUTACAOSAIDACST_30 '+
    ' ,CFG_TRIBUTACAOSAIDACST_40 = FIL_TRIBUTACAOSAIDACST_40 '+
    ' ,CFG_TRIBUTACAOSAIDACST_41 = FIL_TRIBUTACAOSAIDACST_41 '+
    ' ,CFG_TRIBUTACAOSAIDACST_50 = FIL_TRIBUTACAOSAIDACST_50 '+
    ' ,CFG_TRIBUTACAOSAIDACST_51 = FIL_TRIBUTACAOSAIDACST_51 '+
    ' ,CFG_TRIBUTACAOSAIDACST_60 = FIL_TRIBUTACAOSAIDACST_60 '+
    ' ,CFG_TRIBUTACAOSAIDACST_70 = FIL_TRIBUTACAOSAIDACST_70 '+
    ' ,CFG_TRIBUTACAOSAIDACST_90 = FIL_TRIBUTACAOSAIDACST_90 '+
    ' ,CFG_DATAALTERACAO = FIL_DATAALTERACAO '+
    ' ,NCM_CODIGOPADRAOENTRADACST_00 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_00)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_10 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_10)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_20 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_20)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_30 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_30)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_40 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_40)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_41 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_41)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_50 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_50)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_51 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_51)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_60 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_60)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_70 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_70)),0) '+
    ' ,NCM_CODIGOPADRAOENTRADACST_90 = ISNULL(RTRIM(LTRIM(NCM_CODIGOPADRAOENTRADACST_90)),0) '+
    ' FROM FIL_00_06 '+
    ' WHERE FIL_00_06.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFLP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM FLP_00 '+
    ' WHERE FLP_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFLP_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM FLP_00_01 '+
    ' WHERE FLP_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFPG_00', 'SELECT FPG_CODIGO '+
    ' ,COM_CODIGO = 0 '+
    ' ,FPG_DESCRICAO '+
    ' ,PLC_CODIGO '+
    ' ,FPG_NOMEAPELIDO '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,FPG_TIPOPAGTOCOMISSAO '+
    ' ,FPG_FORMAPAGAMENTOECF '+
    ' ,FPG_DESATIVADO '+
    ' ,FPG_DATAALTERACAO '+
    ' ,FPG_GERARPALM '+
    ' ,FPG_OBSERVACAOPEDIDO '+
    ' ,CTB_CODIGO '+
    ' ,FPG_BLOQUEARDESCONTO '+
    ' ,TAB_CODIGO '+
    ' FROM FPG_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TFSP_00', 'SELECT COM_CODIGO = 0, * FROM FSP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TFUN_00', 'SELECT COM_CODIGO = 0, * FROM FUN_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TGAI_00', ' SELECT COM_CODIGO = 0 '+
    ' ,GAI_CODIGO '+
    ' ,GAI_DESCRICAO '+
    ' ,GAI_UF = UFS_SIGLA '+
    ' ,AQT_CODIGO_AC '+
    ' ,AQT_CODIGO_AL '+
    ' ,AQT_CODIGO_AP '+
    ' ,AQT_CODIGO_AM '+
    ' ,AQT_CODIGO_BA '+
    ' ,AQT_CODIGO_CE '+
    ' ,AQT_CODIGO_DF '+
    ' ,AQT_CODIGO_ES '+
    ' ,AQT_CODIGO_GO '+
    ' ,AQT_CODIGO_MA '+
    ' ,AQT_CODIGO_MT '+
    ' ,AQT_CODIGO_MS '+
    ' ,AQT_CODIGO_MG '+
    ' ,AQT_CODIGO_PA '+
    ' ,AQT_CODIGO_PB '+
    ' ,AQT_CODIGO_PR '+
    ' ,AQT_CODIGO_PE '+
    ' ,AQT_CODIGO_PI '+
    ' ,AQT_CODIGO_RN '+
    ' ,AQT_CODIGO_RS '+
    ' ,AQT_CODIGO_RJ '+
    ' ,AQT_CODIGO_RO '+
    ' ,AQT_CODIGO_RR '+
    ' ,AQT_CODIGO_SC '+
    ' ,AQT_CODIGO_SP '+
    ' ,AQT_CODIGO_SE '+
    ' ,AQT_CODIGO_TO '+
    ' ,AQT_CODIGO_EX '+
    ' ,GAI_DATAALTERACAO '+
    ' ,GAI_DESATIVADO '+
    ' FROM GAI_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TGNRE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM GNRE_00 '+
    ' WHERE GNRE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TGNRP_00', 'SELECT GNRP_CODIGO '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,UFS_SIGLA GNRP_UF '+
    ' ,GNRP_UF GNRP_CODIGOUF '+
    ' ,GNRP_REGIAO '+
    ' ,GNRP_BANCO '+
    ' ,GNRP_AGENCIA '+
    ' ,GNRP_RECEITA '+
    ' ,GNRP_CONDICAOPAGTO '+
    ' ,GNRP_DATAALTERACAO '+
    ' FROM GNRP_00 '+
    ' WHERE GNRP_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TGRD_00', 'SELECT COM_CODIGO = 0, * FROM GRD_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TGRP_00', 'SELECT COM_CODIGO = 0, * FROM GRP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('THSP_00', 'SELECT COM_CODIGO = 0, * FROM HSP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TINV_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM INV_00 '+
    ' WHERE INV_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TINV_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM INV_00_01 '+
    ' WHERE INV_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TINVP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM INVP_00 '+
    ' WHERE INVP_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TIRF_00', 'SELECT COM_CODIGO = 0, * FROM IRF_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TKEY_XX', 'SELECT COM_CODIGO = 0, * FROM KEY_XX');
    //----------------------------------------------------------------------------
    QueryList.Add('TLCZ_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LCZ_00 '+
    ' WHERE LCZ_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLEE_00', 'SELECT COM_CODIGO = 0 '+
    ' ,LEE_CODIGO '+
    ' ,LEE_DESCRICAO '+
    ' ,LEE_TIPOCLIENTE '+
    ' ,LEE_TIPOEMPRESA '+
    ' ,LEE_SIMBOLO '+
    ' ,LEE_COMENTARIO '+
    ' ,LEE_DATAINICIAL '+
    ' ,LEE_DATAFINAL '+
    ' ,LEE_DESTAQUE_NF '+
    ' ,UFS_SIGLA LEE_UF '+
    ' ,LEE_DESATIVADO '+
    ' ,LEE_DATAALTERACAO '+
    ' ,LEE_DESCTO_CONV_10097 '+
    ' ,LEE_INFADFISCO '+
    ' ,LEE_ABATEDESCTOBCST '+
    ' FROM LEE_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLEE_00_01', 'SELECT COM_CODIGO = 0, * FROM LEE_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TLEE_00_02', 'SELECT COM_CODIGO = 0 '+
    ' ,LEE_02_ID '+
    ' ,LEE_CODIGO '+
    ' ,UFS_SIGLA LEE_UF '+
    ' ,CFOP_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,MVA_CODIGO '+
    ' ,RBC_CODIGO '+
    ' ,AQT_CODIGO '+
    ' ,LEE_DATAALTERACAO '+
    ' FROM LEE_00_02 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLEE_00_03', ' SELECT COM_CODIGO = 0 '+
    ' ,LEE_03_ID '+
    ' ,LEE_CODIGO '+
    ' ,UFS_SIGLA LEE_UF '+
    ' ,CST_CODIGO '+
    ' ,MVA_CODIGO '+
    ' ,RBC_CODIGO '+
    ' ,AQT_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,RBC_CODIGO_ST '+
    ' ,LEE_PERCENTUALFCP '+
    ' ,LEE_DATAALTERACAO '+
    ' ,LEE_ICMSDESONERADO'+
    ' ,LEE_MOTIVODESONERACAO '+
    ' ,LEE_CODIGOBENEFICIO '+
    ' ,LEE_PERCENTUALICMSCOMPETE '+
    ' FROM LEE_00_03 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLEF_00', ' SELECT COM_CODIGO = 0 '+
    ' ,LEF_CODIGO '+
    ' ,LEF_DESCRICAO '+
    ' ,LEF_SIMBOLO '+
    ' ,LEF_COMENTARIO '+
    ' ,LEF_DATAINICIAL '+
    ' ,LEF_DATAFINAL '+
    ' ,LEF_STATUS '+
    ' ,LEF_VALORIPI '+
    ' ,LEF_PERCENTUALIPI '+
    ' ,LEF_PERCENTUALPIS '+
    ' ,LEF_PERCENTUALCOFINS '+
    ' ,CSTP_CODIGOENT CSTPC_CODIGOENT '+
    ' ,CSTP_CODIGO CSTPC_CODIGOSAI '+
    ' ,LEF_DESATIVADO '+
    ' ,LEF_DESCONTARICMSBCPISCOFINS '+
    ' ,LEF_ENQUADRAMENTOIPI '+
    ' ,LEF_DATAALTERACAO '+
    ' FROM LEF_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFE_00', 'SELECT LFE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FIL_PORTEFEDERAL '+
    ' ,FIL_PORTEESTADUAL '+
    ' ,PES_CODIGO '+
    ' ,LFE_SERIE '+
    ' ,TRP_CODIGO '+
    ' ,LFE_UFVEICULO '+
    ' ,LFE_PLACAVEICULO '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,LFE_EMITENTE '+
    ' ,LFE_NOTAFISCAL '+
    ' ,LFE_FINALIDADE '+
    ' ,LFE_DATAEMISSAO '+
    ' ,LFE_DATAENTRADA '+
    ' ,LFE_DATALANCAMENTO '+
    ' ,LFE_TIPOFRETE '+
    ' ,LFE_STATUSNFE '+
    ' ,LFE_TIPOLIGACAO '+
    ' ,LFE_TIPOPAGAMENTO '+
    ' ,LFE_TOTALPIS '+
    ' ,LFE_TOTALIPI '+
    ' ,LFE_TOTALICMS '+
    ' ,LFE_TOTALICMSR '+
    ' ,LFE_TOTALCOFINS '+
    ' ,LFE_TOTALDESCTO '+
    ' ,LFE_TOTALSEGURO '+
    ' ,LFE_TOTALSERVICO '+
    ' ,LFE_TOTALFRETENF '+
    ' ,LFE_TOTALPRODUTOS '+
    ' ,LFE_TIPONOTAFISCAL '+
    ' ,LFE_TOTALPESOBRUTO '+
    ' ,LFE_TOTALNOTAFISCAL '+
    ' ,LFE_TOTALPESOLIQUIDO '+
    ' ,LFE_TOTALDESPACESSORIA '+
    ' ,LFE_TOTALBASEISENTOICMS '+
    ' ,LFE_TOTALBASECALCULOMVA '+
    ' ,LFE_TOTALBASECALCULOICMS '+
    ' ,LFE_TOTALCOMPLEMENTONFICMS '+
    ' ,LFE_TOTALBASECALCULOICMSFRETENF '+
    ' ,LFE_TOTALBCICMSDESPACESSORIA '+
    ' ,LFE_TOTALBCALCULOPISCOFINS = LFE_TOTALBASECALCULOPIS '+
    ' ,LFE_TOTALNUMEROVOLUMES '+
    ' ,LFE_PERCENTUALICMSFRETENF '+
    ' ,LFE_PERCENTUALICMSDESPACESSORIA '+
    ' ,LFE_PERCENTUALPIS '+
    ' ,LFE_PERCENTUALCOFINS '+
    ' ,LFE_NUMERACAOVOLUMES '+
    ' ,LFE_INFCOMPLEMENTAR '+
    ' ,LFE_ESPECIEVOLUMES '+
    ' ,LFE_MARCAVOLUMES '+
    ' ,LFE_XMLNFEGERADO '+
    ' ,LFE_GRUPOTENSAO '+
    ' ,LFE_PISCOFINSCTR '+
    ' ,LFE_CHAVEACESSO '+
    ' ,LFE_CHAVEREFERENCIANFE '+
    ' ,LFE_RNTRC '+
    ' ,LFE_OBSERVACAO '+
    ' ,LFE_DENEGADA '+
    ' ,LFE_DESATIVADO '+
    ' ,LFE_CANCELADO '+
    ' ,LFE_INTEGRACAO '+
    ' ,LFE_DATAALTERACAO '+
    ' ,LFE_TOTALICMSDESONERADO '+
    ' ,LFE_PORTEFORNECEDOR '+
    ' ,LFE_ID_OLD '+
    ' ,LFE_INTEGRACAO_OLD '+
    ' ,COD_AJ '+
    ' FROM LFE_00 '+
    ' WHERE LFE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFE_00_01', 'SELECT LFE_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFE_ID '+
    ' ,GAI_CODIGO '+
    ' ,LEE_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,LFE_VALORITEM '+
    ' ,LFE_VALORITEMBRUTO '+
    ' ,LFE_VALORIPI '+
    ' ,LFE_VALORPIS '+
    ' ,LFE_VALORCOFINS '+
    ' ,LFE_VALORICMS '+
    ' ,LFE_VALORFRETENF '+
    ' ,LFE_VALORICMSRNF '+
    ' ,LFE_VALORBASEOUTROS '+
    ' ,LFE_VALORDESPACESSORIA '+
    ' ,LFE_VALORBASEISENTOICMS '+
    ' ,LFE_VALORBASECALCULOICMS '+
    ' ,LFE_VALORBASECALCULOMVA '+
    ' ,LFE_VALORBCALCULOPISCOFINS = LFE_VALORBASECALCULOPIS '+
    ' ,LFE_PERCENTUALICMS '+
    ' ,LFE_DATAALTERACAO '+
    ' ,LFE_PERCENTUALICMS '+
    ' ,LFE_ID_OLD '+
    ' ,LFE_01_ID_OLD '+
    ' FROM LFE_00_01 '+
    ' WHERE LFE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFE_00_01_01', 'SELECT LFE_01_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFE_01_ID '+
    ' ,LFE_ID '+
    ' ,PRO_CODIGO '+
    ' ,LFE_CSOSN '+
    ' ,CTB_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CST_CODIGOIPI '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,LFE_ORDEMITEM '+
    ' ,LFE_QTDENTRADA '+
    ' ,LFE_VALORITEM '+
    ' ,LFE_VALORITEMBRUTO '+
    ' ,LFE_VALORIPIITEM '+
    ' ,LFE_VALORPISITEM '+
    ' ,LFE_VALORICMSITEM '+
    ' ,LFE_VALORCOFINSITEM '+
    ' ,LFE_VALORSEGUROITEM '+
    ' ,LFE_VALORDESCTOITEM '+
    ' ,LFE_VALORICMSRNFITEM '+
    ' ,LFE_VALORFRETENFITEM '+
    ' ,LFE_VALORBASEOUTROSITEM '+
    ' ,LFE_VALORBASEISENTOICMSITEM '+
    ' ,LFE_VALORDESPACESSORIAITEM '+
    ' ,LFE_VALORBASECALCULOMVAITEM '+
    ' ,LFE_VALORBASECALCULOICMSITEM '+
    ' ,LFE_VALORBCALCULOPISCOFINSITEM = LFE_VALORBASECALCULOPISITEM '+
    ' ,LFE_PERCENTUALIPIITEM '+
    ' ,LFE_PERCENTUALPISITEM '+
    ' ,LFE_PERCENTUALMVAITEM '+
    ' ,LFE_PERCENTUALICMSITEM '+
    ' ,LFE_PERCENTUALCOFINSITEM '+
    ' ,LFE_PERCENTUALICMSDESTINOITEM '+
    ' ,LFE_PERCENTUALREDUCAOBCITEM '+
    ' ,LFE_TOTALITEM '+
    ' ,LFE_TOTALITEMBRUTO '+
    ' ,LFE_TOTALIPIITEM '+
    ' ,LFE_TOTALPISITEM '+
    ' ,LFE_TOTALICMSITEM '+
    ' ,LFE_TOTALCOFINSITEM '+
    ' ,LFE_TOTALSEGUROITEM '+
    ' ,LFE_TOTALDESCTOITEM '+
    ' ,LFE_TOTALICMSRNFITEM '+
    ' ,LFE_TOTALFRETENFITEM '+
    ' ,LFE_TOTALBASEOUTROSITEM '+
    ' ,LFE_TOTALBASEISENTOICMSITEM '+
    ' ,LFE_TOTALBASECALCULOMVAITEM '+
    ' ,LFE_TOTALBASECALCULOICMSITEM '+
    ' ,LFE_TOTALDESPACESSORIAITEM '+
    ' ,LFE_TOTALBCALCULOPISCOFINSITEM = LFE_TOTALBASECALCULOPISITEM '+
    ' ,LFE_DATAALTERACAO '+
    ' ,LFE_VALORICMSDESONERADOITEM '+
    ' ,LFE_PROCEDENCIA '+
    ' ,LFE_TOTALSERVICOITEM '+
    ' ,LFE_TOTALBCICMSFRETENFITEM '+
    ' ,LFE_01_01_ID_OLD '+
    ' ,LFE_01_ID_OLD '+
    ' ,LFE_ID_OLD '+
    ' ,LFE_TOTALICMSFRETENFITEM '+
    ' FROM LFE_00_01_01 '+
    ' WHERE LFE_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFE_00_03', 'SELECT LFE_03_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFE_ID '+
    ' ,CFOP_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,LFE_VALORITEM '+
    ' ,LFE_VALORITEMBRUTO '+
    ' ,LFE_VALORPIS '+
    ' ,LFE_VALORCOFINS '+
    ' ,LFE_VALORBCALCULOPISCOFINS = LFE_VALORBASECALCULOPISCOFINS '+
    ' ,LFE_PERCENTUALPISITEM '+
    ' ,LFE_PERCENTUALCOFINSITEM '+
    ' ,LFE_DATAALTERACAO '+
    ' ,LFE_03_ID_OLD = 0 '+
    ' ,LFE_ID_OLD = 0 '+
    ' FROM LFE_00_03 '+
    ' WHERE LFE_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00', 'SELECT LFS_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,CFG_PORTEESTADUAL = FIL_PORTEFEDERAL '+
    ' ,CFG_PORTEFEDERAL  = FIL_PORTEESTADUAL '+
    ' ,CGA_ID '+
    ' ,PES_CODIGO '+
    ' ,LFS_CPFCLIENTE '+
    ' ,LFS_NOMECLIENTE '+
    ' ,LFS_SERIE '+
    ' ,LFS_NOTAFISCAL '+
    ' ,LFS_FINALIDADE '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,LFS_UFVEICULO '+
    ' ,LFS_PLACAVEICULO '+
    ' ,MNF_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CST_CODIGOCTR '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,LFS_EMITENTE '+
    ' ,LFS_STATUSNFE '+
    ' ,LFS_DATASAIDA '+
    ' ,LFS_DATAEMISSAO '+
    ' ,LFS_TOTALICMSDESONERADO '+
    ' ,LFS_DATALANCAMENTO '+
    ' ,LFS_TOTALIPI '+
    ' ,LFS_TOTALPIS '+
    ' ,LFS_TOTALISS '+
    ' ,LFS_TOTALICMS '+
    ' ,LFS_TIPOFRETE '+
    ' ,LFS_TOTALICMSR '+
    ' ,LFS_TOTALCOFINS '+
    ' ,LFS_TOTALSEGURO '+
    ' ,LFS_TOTALDESCTO '+
    ' ,LFS_TOTALSERVICO '+
    ' ,LFS_TOTALFRETENF '+
    ' ,LFS_TOTALPRODUTOS '+
    ' ,LFS_TOTALNOTAFISCAL '+
    ' ,LFS_TOTALPESOBRUTO '+
    ' ,LFS_TOTALPESOLIQUIDO '+
    ' ,LFS_TOTALDESPACESSORIA '+
    ' ,LFS_TOTALBASEISENTOICMS '+
    ' ,LFS_TOTALBASECALCULOMVA '+
    ' ,LFS_TOTALBASECALCULOICMS '+
    ' ,LFS_TOTALCOMPLEMENTONFICMS '+
    ' ,LFS_TOTALBASECALCULOISS '+
    ' ,LFS_TOTALNUMEROVOLUMES '+
    ' ,LFS_TOTALBCALCULOPISCOFINS = LFS_TOTALBASECALCULOPIS '+
    ' ,LFS_TOTALAPROXIMADOIMPOSTO '+
    ' ,LFS_NUMERACAOVOLUMES '+
    ' ,LFS_INFCOMPLEMENTAR '+
    ' ,LFS_ESPECIEVOLUMES '+
    ' ,LFS_MARCAVOLUMES '+
    ' ,LFS_CHAVEREFERENCIANFE '+
    ' ,LFS_NUMEROORDEMCOMPRA '+
    ' ,LFS_CHAVEACESSO '+
    ' ,LFS_TIPONOTAFISCAL '+
    ' ,PES_CODIGOENTREGA '+
    ' ,PES_CODIGORETIRADA '+
    ' ,LFS_XMLNFEGERADO '+
    ' ,LFS_TIPOPAGAMENTO '+
    ' ,LFS_PISCOFINSCTR '+
    ' ,LFS_PERCENTUALPIS '+
    ' ,LFS_PERCENTUALCOFINS '+
    ' ,LFS_PERCENTUALIBPT '+
    ' ,LFS_NOTAFISCALRETIDAFONTE '+
    ' ,LFS_PERIODORETENCAO '+
    ' ,LFS_TOTALIBPTMUNICIPAL '+
    ' ,LFS_TOTALIBPTESTADUAL '+
    ' ,LFS_TOTALIBPTNACIONAL '+
    ' ,LFS_TOTALIBPTIMPORTADO '+
    ' ,LFS_PERCENTUALIBPTMUNICIPAL '+
    ' ,LFS_PERCENTUALIBPTESTADUAL '+
    ' ,LFS_PERCENTUALIBPTNACIONAL '+
    ' ,LFS_PERCENTUALIBPTIMPORTADO '+
    ' ,LFS_RNTRC '+
    ' ,LFS_ID_OLD = 0 '+
    ' ,LFS_INTEGRACAO_OLD '+
    ' ,CGA_ID_OLD '+
    ' ,LFS_TOTALBASECALCULOFCP '+
    ' ,LFS_TOTALFCP '+
    ' ,LFS_TOTALBASECALCULOFCPST '+
    ' ,LFS_TOTALFCPST '+
    ' ,LFS_TOTALBASECALCULOFCPRET '+
    ' ,LFS_TOTALFCPRET '+
    ' ,LFS_TOTALTROCO '+
    ' ,LFS_OBSERVACAO '+
    ' ,LFS_DENEGADA '+
    ' ,LFS_CANCELADO '+
    ' ,LFS_DESATIVADO '+
    ' ,LFS_INTEGRACAO '+
    ' ,LFS_DATAALTERACAO '+
    ' ,LFS_RPS '+
    ' ,LFS_QUANTIDADECARGA '+
    ' ,LFS_UNIDADEMEDIDACARGA '+
    ' FROM LFS_00 '+
    ' WHERE LFS_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_01', 'SELECT LFS_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFS_ID '+
    ' ,GAI_CODIGO '+
    ' ,LEE_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,LFS_VALORITEM '+
    ' ,LFS_VALORITEMBRUTO '+
    ' ,LFS_VALORIPI '+
    ' ,LFS_VALORISS '+
    ' ,LFS_VALORICMS '+
    ' ,LFS_VALORPIS '+
    ' ,LFS_VALORCOFINS '+
    ' ,LFS_VALORICMSRNF '+
    ' ,LFS_VALORFRETENF '+
    ' ,LFS_VALORBASEOUTROS '+
    ' ,LFS_VALORDESPACESSORIA '+
    ' ,LFS_VALORBASEISENTOICMS '+
    ' ,LFS_VALORBASECALCULOICMS '+
    ' ,LFS_ID_OLD '+
    ' ,LFS_01_ID_OLD '+
    ' ,LFS_VALORBASECALCULOMVA '+
    ' ,LFS_VALORBASECALCULOISS '+
    ' ,LFS_VALORBCALCULOPISCOFINS = LFS_VALORBASECALCULOPIS '+
    ' ,LFS_PERCENTUALISS '+
    ' ,LFS_PERCENTUALICMS '+
    ' ,LFS_NUMEROORDEMCOMPRA '+
    ' ,LFS_DATAALTERACAO '+
    ' FROM LFS_00_01 '+
    ' WHERE LFS_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_01_01', 'SELECT LFS_01_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFS_01_ID '+
    ' ,LFS_ID '+
    ' ,LFS_CSOSN '+
    ' ,PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,CST_CODIGOIPI '+
    ' ,LFS_ORDEMITEM '+
    ' ,LFS_QTDSAIDA '+
    ' ,LFS_VALORITEM '+
    ' ,LFS_VALORITEMBRUTO '+
    ' ,LFS_VALORIPIITEM '+
    ' ,LFS_VALORPISITEM '+
    ' ,LFS_VALORICMSITEM '+
    ' ,LFS_VALORCOFINSITEM '+
    ' ,LFS_VALORSEGUROITEM '+
    ' ,LFS_VALORDESCTOITEM '+
    ' ,LFS_VALORICMSRNFITEM '+
    ' ,LFS_MOTIVODESONERACAO '+
    ' ,LFS_CODIGOBENEFICIO '+
    ' ,LFS_VALORFRETENFITEM '+
    ' ,LFS_VALORICMSSNTBITEM '+
    ' ,LFS_VALORBASEOUTROSITEM '+
    ' ,LFS_VALORBASEISENTOICMSITEM '+
    ' ,LFS_VALORBASECALCULOMVAITEM '+
    ' ,LFS_VALORBASECALCULOICMSITEM '+
    ' ,LFS_VALORDESPACESSORIAITEM '+
    ' ,LFS_VALORICMSCREDITOSNSTITEM '+
    ' ,LFS_VALORICMSDESTINOSNSTITEM '+
    ' ,LFS_VALORBCALCULOPISCOFINSITEM = LFS_VALORBASECALCULOPISITEM '+
    ' ,LFS_PERCENTUALIPIITEM '+
    ' ,LFS_PERCENTUALPISITEM '+
    ' ,LFS_PERCENTUALICMSITEM '+
    ' ,LFS_PERCENTUALMVAITEM '+
    ' ,LFS_PERCENTUALCOFINSITEM '+
    ' ,LFS_PERCENTUALICMSDESTINOITEM '+
    ' ,LFS_PERCENTUALREDUCAOBCITEM '+
    ' ,LFS_PERCENTUALICMSSNTBITEM '+
    ' ,LFS_PERCICMSCREDITOSNSTITEM '+
    ' ,LFS_PERCICMSDESTINOSNSTITEM '+
    ' ,LFS_TOTALITEM '+
    ' ,LFS_TOTALITEMBRUTO '+
    ' ,LFS_TOTALIPIITEM '+
    ' ,LFS_TOTALPISITEM '+
    ' ,LFS_TOTALICMSITEM '+
    ' ,LFS_TOTALCOFINSITEM '+
    ' ,LFS_TOTALSEGUROITEM '+
    ' ,LFS_TOTALDESCTOITEM '+
    ' ,LFS_TOTALICMSRNFITEM '+
    ' ,LFS_TOTALFRETENFITEM '+
    ' ,LFS_TOTALBASEOUTROSITEM '+
    ' ,LFS_TOTALBASEISENTOICMSITEM '+
    ' ,LFS_TOTALBASECALCULOMVAITEM '+
    ' ,LFS_TOTALBASECALCULOICMSITEM '+
    ' ,LFS_TOTALBCALCULOPISCOFINSITEM = LFS_TOTALBASECALCULOPISITEM '+
    ' ,LFS_TOTALDESPACESSORIAITEM '+
    ' ,LFS_TOTALICMSCREDITOSNSTITEM '+
    ' ,LFS_TOTALICMSDESTINOSNSTITEM '+
    ' ,LFS_TOTALICMSSNTBITEM '+
    ' ,LFS_TOTALAPROXIMADOIMPOSTOITEM '+
    ' ,LFS_ORDEMXMLITEM '+
    ' ,LFS_EXTIPI '+
    ' ,LFS_PERCENTUALIBPTITEM '+
    ' ,LFS_PERCENTUALIBPTMUNICIPALITEM '+
    ' ,LFS_PERCENTUALIBPTESTADUALITEM '+
    ' ,LFS_PERCENTUALIBPTNACIONALITEM '+
    ' ,LFS_PERCENTUALIBPTIMPORTADOITEM '+
    ' ,LFS_TOTALIBPTMUNICIPALITEM '+
    ' ,LFS_TOTALIBPTESTADUALITEM '+
    ' ,LFS_TOTALIBPTNACIONALITEM '+
    ' ,LFS_TOTALIBPTIMPORTADOITEM '+
    ' ,LFS_PERCENTUALFCPITEM '+
    ' ,LFS_TOTALBASECALCULOFCPITEM '+
    ' ,LFS_TOTALFCPITEM '+
    ' ,LFS_TOTALBASECALCULOFCPSTITEM '+
    ' ,LFS_TOTALFCPSTITEM '+
    ' ,LFS_TOTALBASECALCULOFCPRETITEM '+
    ' ,LFS_TOTALFCPRETITEM '+
    ' ,LFS_DATAALTERACAO '+
    ' ,LFS_ID_OLD = 0 '+
    ' ,LFS_01_ID_OLD = 0 '+
    ' ,LFS_01_01_ID_OLD = 0 '+
    ' ,LFS_TOTALICMSDESONERADOITEM '+
    ' ,LFS_TOTALSERVICOITEM '+
    ' ,LFS_TOTALBCICMSFRETENFITEM '+
    ' ,LFS_TOTALICMSFRETENFITEM '+
    ' FROM LFS_00_01_01 '+
    ' WHERE LFS_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_01_02', 'SELECT LFS_01_02_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFS_01_ID '+
    ' ,LFS_ID '+
    ' ,MDO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CSTP_CODIGO CSTPC_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,LFS_ORDEMITEM '+
    ' ,LFS_QTDHORAS '+
    ' ,LFS_VALORSERVICO '+
    ' ,LFS_VALORISSITEM '+
    ' ,LFS_VALORPISITEM '+
    ' ,LFS_VALORCOFINSITEM '+
    ' ,LFS_VALORBASECALCULOISSITEM '+
    ' ,LFS_VALORBASECALCULOPISITEM LFS_VALORBCALCULOPISCOFINSITEM '+
    ' ,LFS_PERCENTUALISSITEM '+
    ' ,LFS_PERCENTUALCOFINSITEM '+
    ' ,LFS_PERCENTUALPISITEM '+
    ' ,LFS_ID_OLD = 0 '+
    ' ,LFS_01_ID_OLD '+
    ' ,LFS_TOTALSERVICO '+
    ' ,LFS_TOTALISSITEM '+
    ' ,LFS_TOTALPISITEM '+
    ' ,LFS_TOTALCOFINSITEM '+
    ' ,LFS_TOTALBASECALCULOPISITEM LFS_TOTALBCALCULOPISCOFINSITEM '+
    ' ,LFS_TOTALBASECALCULOISSITEM '+
    ' ,LFS_DATAALTERACAO '+
    ' FROM LFS_00_01_02 '+
    ' WHERE LFS_00_01_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LFS_00_02 '+
    ' WHERE LFS_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_03', ' SELECT LFS_03_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFS_ID '+
    ' ,CFOP_CODIGO '+
    ' ,CSTP_CODIGO CSTPC_CODIGO '+
    ' ,LFS_VALORITEM '+
    ' ,LFS_VALORITEMBRUTO '+
    ' ,LFS_VALORBASECALCULOPISCOFINS LFS_VALORBCALCULOPISCOFINS '+
    ' ,LFS_VALORPIS '+
    ' ,LFS_VALORCOFINS '+
    ' ,LFS_PERCENTUALPISITEM '+
    ' ,LFS_PERCENTUALCOFINSITEM '+
    ' ,LFS_03_ID_OLD '+
    ' ,LFS_ID_OLD ' +
    ' ,LFS_DATAALTERACAO '+
    ' FROM LFS_00_03 '+
    ' WHERE LFS_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LFS_00_04 '+
    ' WHERE LFS_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_05', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,LFS_ID '+
    ' ,LFS_DATAENTREGA '+
    ' ,LFS_TIPOCTE '+
    ' ,LFS_TIPOSERVICO '+
    ' ,LFS_EMITENTE '+
    ' ,LFS_APOLICE '+
    ' ,LFS_NUMEROCIOT '+
    ' ,CST_CODIGOCTR '+
    ' ,VEI_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,PES_CLIENTEDESTINATARIO '+
    ' ,PES_CLIENTECONSIGNATARIO '+
    ' ,PES_CLIENTEREDESPACHO '+
    ' ,PES_CLIENTEOUTROS '+
    ' ,LFS_TOTALPEDAGIO '+
    ' ,LFS_TOTALDESPACHO '+
    ' ,LFS_PERCENTUALICMS '+
    ' ,LFS_TOTALNOTAFISCAL '+
    ' ,LFS_TOTALMERCADORIASEGURADA '+
    ' ,LFS_NUMEROLIBERACAOSEGURO '+
    ' ,LFS_SERIELIBERACAOSEGURO '+
    ' ,LFS_COBRADORA '+
    ' ,LFS_NATUREZA '+
    ' ,LFS_NATUREZACARGA '+
    ' ,LFS_CHAVEACESSOSUBSTITUIDO '+
    ' ,LFS_TOMADORCONTRIBUINTEICMS '+
    ' ,LFS_CHAVEACESSOTOMADOR '+
    ' ,LFS_CNPJTOMADOR '+
    ' ,LFS_CPFTOMADOR '+
    ' ,MNF_CODIGOTOMADOR '+
    ' ,LFS_SERIETOMADOR '+
    ' ,LFS_SUBSERIETOMADOR '+
    ' ,LFS_NOTAFISCALTOMADOR '+
    ' ,LFS_VALORNOTAFISCALTOMADOR '+
    ' ,LFS_DATAEMISSAONFTOMADOR '+
    ' ,LFS_CHAVEACESSOCOMPLEMENTO '+
    ' ,LFS_CHAVEACESSOANULACAO '+
    ' ,LFS_DATAEMISSAODECLARACAO '+
    ' ,LFS_DATAALTERACAO '+
    ' ,CID_IBGEORIGEM = CID_ORIG.CID_IBGE '+
    ' ,LFS_CIDADEORIGEM = CID_ORIG.CID_NOME '+
    ' ,LFS_UFORIGEM = UFS_ORIG.UFS_SIGLA '+
    ' ,CID_IBGEDESTINO = CID_DEST.CID_IBGE '+
    ' ,LFS_CIDADEDESTINO = CID_DEST.CID_NOME '+
    ' ,LFS_UFDESTINO = UFS_DEST.UFS_SIGLA '+
    ' ,LFS_ID_OLD '+
    ' FROM LFS_00_05 '+
    ' LEFT JOIN CID_00 CID_ORIG '+
    '   ON CID_ORIG.CID_CODIGO = LFS_00_05.CID_CODIGOORIGEM '+
    ' LEFT JOIN UFS_00 UFS_ORIG '+
    '   ON UFS_ORIG.UFS_CODIGO = CID_ORIG.UFS_CODIGO '+
    ' LEFT JOIN CID_00 CID_DEST '+
    '   ON CID_DEST.CID_CODIGO = LFS_00_05.CID_CODIGODESTINO '+
    ' LEFT JOIN UFS_00 UFS_DEST '+
    '   ON UFS_DEST.UFS_CODIGO = CID_DEST.UFS_CODIGO '+
    ' WHERE LFS_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_06', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LFS_00_06 '+
    ' WHERE LFS_00_06.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_07', 'SELECT LFS_07_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,LFS_ID '+
    ' ,LFS_CNPJ_CPF '+
    ' ,LFS_IE '+
    ' ,UFS_SIGLA LFS_UF '+
    ' ,LFS_NOMEEXPEDIDOR '+
    ' ,LFS_TIPODOCUMENTO '+
    ' ,LFS_SERIE '+
    ' ,LFS_SUBSERIE '+
    ' ,LFS_NUMERODOCTOFISCAL '+
    ' ,LFS_CHAVEACESSO '+
    ' ,LFS_DATAEMISSAO '+
    ' ,LFS_07_ID_OLD '+
    ' ,LFS_ID_OLD '+
    ' ,LFS_DATAALTERACAO '+
    ' FROM LFS_00_07 '+
    ' WHERE LFS_00_07.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLFS_00_08', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LFS_00_08 '+
    ' WHERE LFS_00_08.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLIB_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LIB_00 '+
    ' WHERE LIB_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLIC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LIC_00 '+
    ' WHERE LIC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TLIC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LIC_00_01 '+
    ' WHERE LIC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');

    //----------------------------------------------------------------------------
    QueryList.Add('TLOD_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LOD_00 '+
    ' WHERE LOD_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');

    //----------------------------------------------------------------------------
    QueryList.Add('TLOG_XX', 'SELECT SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM LOG_XX '+
    ' WHERE LOG_DATA > DATEADD(yyyy, -1, GETDATE()) '+
    ' AND LOG_XX.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMAR_00', 'SELECT COM_CODIGO = 0, * FROM MAR_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TMDO_00', 'SELECT COM_CODIGO = 0, * FROM MDO_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TMDV_00', 'SELECT COM_CODIGO = 0, * FROM MDV_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TMEG_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MEG_00 '+
    ' WHERE MEG_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMEG_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MEG_00_01 '+
    ' WHERE MEG_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMEG_00_01_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MEG_00_01_01 '+
    ' WHERE MEG_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
//    QueryList.Add('TMEN_XX', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM MEN_XX '+
//    ' WHERE MEN_XX.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    //QueryList.Add('TMENUS', 'SELECT * FROM MENUS');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00', ' SELECT MFC_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,MFC_DATASAIDA '+
    ' ,MFC_SERIE '+
    ' ,MFC_SUBSERIE '+
    ' ,MNF_CODIGO '+
    ' ,MFC_STATUSMDFE '+
    ' ,MFC_NOTAFISCAL '+
    ' ,MFC_NUMEROCIOT '+
    ' ,MFC_DATARETORNO '+
    ' ,MFC_NUMERODOCTO '+
    ' ,VEI_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,MFC_UFORIGEM = UFS_SIGLAORIGEM '+
    ' ,MFC_UFDESTINO = UFS_SIGLADESTINO '+
    ' ,MFC_TOTALQTDNOTAFISCAL '+
    ' ,MFC_TOTALQTDCONHECIMENTO '+
    ' ,MFC_TOTALKM '+
    ' ,MFC_TOTALFRETECIF '+
    ' ,MFC_TOTALFRETEFOB '+
    ' ,MFC_TOTALFRETETRP '+
    ' ,MFC_TOTALFRETEOUTROS '+
    ' ,MFC_TOTALADIANTAMENTO '+
    ' ,MFC_TOTALNFCONHECIMENTO '+
    ' ,MFC_TOTALNFLIVROFISCAL '+
    ' ,MFC_TOTALNOTAFISCAL '+
    ' ,MFC_TOTALPESOBRUTOCTR '+
    ' ,MFC_TOTALPESOBRUTONF '+
    ' ,MFC_PLANOCONTARATEIO '+
    ' ,MFC_RESPONSAVELSEGURO '+
    ' ,MFC_CNPJCPF_RESPONSAVELSEGURO '+
    ' ,MFC_TIPOEMITENTEMDFE '+
    ' ,PES_PAGADORVALEPEDAGIO '+
    ' ,MFC_CATEGORIACOMBVEICULAR '+
    ' ,MFC_CHAVEACESSO '+
    ' ,MFC_OBSERVACAO '+
    ' ,MFC_PROCESSADO '+
    ' ,MFC_CANCELADO '+
    ' ,PRO_CODIGO '+
    ' ,MFC_ID_OLD '+
    ' ,MFC_DATACANCELAMENTO '+
    ' ,MFC_OBSERVACAOCANCELAMENTO '+
    ' ,MFC_DATAALTERACAO '+
    ' ,MFC_AVERBADO '+
    ' ,MFC_DATAAVERBACAO '+
    ' ,MFC_HORAAVERBACAO '+
    ' ,MFC_PROTOCOLOAVERBACAO '+
    ' ,MFC_TIPOPRODUTO '+
    ' ,MFC_TIPOCARGA '+
    ' ,MFC_LATITUDECARREGA '+
    ' ,MFC_LONGITUDECARREGA '+
    ' ,MFC_LATITUDEDESCARREGA '+
    ' ,MFC_LONGITUDEDESCARREGA '+
    ' ,MFC_TIPOVIAGEM '+
    ' ,MFC_TIPOEMBALAGEM '+
    ' ,MFC_TIPOPAGAMENTO '+
    ' ,BCO_CODIGOPAGTO '+
    ' ,MFC_AGENCIAPAGTO '+
    ' ,MFC_CONTAPAGTO '+
    ' ,MFC_TIPOCONTAPAGTO '+
    ' ,MFC_DATALIBERACAOPAGTO '+
    ' ,MFC_OBSTRANSPORTADOR '+
    ' ,MFC_OBSCREDENCIADO '+
    ' ,MFC_PROTOCOLOCIOT '+
    ' ,MFC_STATUSCIOT '+
    ' ,PES_FORNECEDORVALEPEDAGIO '+
    ' ,MFC_NUMEROCOMPRAVALEPEDAGIO '+
    ' ,MFC_VALORVALEPEDAGIO '+
    ' ,MFC_IDPAGAMENTOCIOT '+
    ' ,MFC_CATEGORIAPAGAMENTOCIOT '+
    ' FROM MFC_00 '+
    ' WHERE MFC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MFC_00_01 '+
    ' WHERE MFC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MFC_00_02 '+
    ' WHERE MFC_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MFC_00_03 '+
    ' WHERE MFC_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_03_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MFC_00_03_01 '+
    ' WHERE MFC_00_03_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_04', 'SELECT MFC_04_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,MFC_ID '+
    ' ,LFS_ID '+
    ' ,LFS_TIPO '+
    ' ,MNF_CODIGO '+
    ' ,LFS_NOTAFISCAL '+
    ' ,CID_ORIG.CID_IBGE CID_IBGEORIGEM '+
    ' ,CID_ORIG.CID_NOME MFC_CIDADEORIGEM '+
    ' ,UFS_ORIG.UFS_SIGLA MFC_UFORIGEM '+
    ' ,CID_DEST.CID_IBGE CID_IBGEDESTINO '+
    ' ,CID_DEST.CID_NOME MFC_CIDADEDESTINO '+
    ' ,UFS_DEST.UFS_SIGLA MFC_UFDESTINO '+
    ' ,MFC_ORDEMITEM '+
    ' ,MFC_TIPOFRETE '+
    ' ,MFC_PESOBRUTO '+
    ' ,MFC_VALORFRETE '+
    ' ,MFC_VALORNOTAFISCAL '+
    ' ,MFC_CODIGORASTREAMENTO '+
    ' ,LFS_CHAVEACESSO '+
    ' ,MFC_DATAALTERACAO '+
    ' ,LFS_ID_OLD '+
    ' ,MFC_ID_OLD '+
    ' ,MFC_04_ID_OLD '+
    ' FROM MFC_00_04 '+
    ' LEFT JOIN CID_00 CID_ORIG '+
    '  ON CID_ORIG.CID_CODIGO = MFC_00_04.CID_CODIGOORIGEM '+
    ' LEFT JOIN UFS_00 UFS_ORIG '+
    '  ON UFS_ORIG.UFS_CODIGO = CID_ORIG.UFS_CODIGO '+
    ' LEFT JOIN CID_00 CID_DEST '+
    '  ON CID_DEST.CID_CODIGO = MFC_00_04.CID_CODIGODESTINO '+
    ' LEFT JOIN UFS_00 UFS_DEST '+
    '  ON UFS_DEST.UFS_CODIGO = CID_DEST.UFS_CODIGO'+
    ' WHERE MFC_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_05', 'SELECT MFC_05_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,MFC_ID '+
    ' ,UFS_SIGLA MFC_UF '+
    ' ,MFC_ORDEMITEM '+
    ' ,MFC_DATAALTERACAO '+
    ' ,MFC_05_ID_OLD '+
    ' ,MFC_ID_OLD '+
    ' FROM MFC_00_05 '+
    ' WHERE MFC_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMFC_00_06', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MFC_00_06 '+
    ' WHERE MFC_00_06.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMIF_00', 'SELECT * FROM MIF_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TMNF_00', 'SELECT COM_CODIGO = 0, * FROM MNF_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TMTL_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MTL_00 '+
    ' WHERE MTL_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMTL_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM MTL_00_01 '+
    ' WHERE MTL_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMTL_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    'FROM MTL_00_02 '+
    ' WHERE MTL_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TMVA_00', 'SELECT COM_CODIGO = 0, * FROM MVA_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TNCM_00', 'SELECT COM_CODIGO = 0, * FROM NCM_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TNCM_00_01', 'SELECT COM_CODIGO = 0 '+
    ' ,NCM_01_ID '+
    ' ,NCM_CODIGO '+
    ' ,GAI_CODIGO '+
    ' ,UFS_SIGLA NCM_UF '+
    ' ,NCM_DATAALTERACAO '+
    ' FROM NCM_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00', 'SELECT NFE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,NFE_SERIE '+
    ' ,NFE_NOTAFISCAL '+
    ' ,NFE_PEDIDOCOMPRA '+
    ' ,NFE_DATAEMISSAO '+
    ' ,NFE_DATAENTRADA '+
    ' ,NFE_DATALANCAMENTO '+
    ' ,NFE_TIPOFRETE '+
    ' ,NFE_TOTALIPI '+
    ' ,NFE_TOTALPIS '+
    ' ,NFE_TOTALICMS '+
    ' ,NFE_TOTALCOFINS '+
    ' ,NFE_TOTALDESCTO '+
    ' ,NFE_TOTALSEGURO '+
    ' ,NFE_TOTALSERVICO '+
    ' ,NFE_TOTALFRETENF '+
    ' ,NFE_TOTALICMSRNF '+
    ' ,NFE_TOTALADICIONAL '+
    ' ,NFE_TOTALPRODUTOS '+
    ' ,NFE_TOTALNOTAFISCAL '+
    ' ,NFE_TOTALICMSSIMPLES '+
    ' ,NFE_TOTALFRETERPA '+
    ' ,NFE_TOTALICMSFRETENF '+
    ' ,NFE_TOTALDESPACESSORIA '+
    ' ,NFE_TOTALSUBSTRIBUTARIA '+
    ' ,NFE_TOTALBASEISENTOICMS '+
    ' ,NFE_TOTALBASECALCULOMVA '+
    ' ,NFE_TOTALBASECALCULOICMS '+
    ' ,NFE_TOTALBCALCULOPISCOFINS = NFE_TOTALBASECALCULOPIS '+
    ' ,NFE_TOTALBCICMSDESPACESSORIA '+
    ' ,NFE_TOTALCOMPLEMENTONFICMS '+
    ' ,NFE_TOTALICMSDESPACESSORIA '+
    ' ,NFE_TOTALBASECALCULOICMSFRETENF '+
    ' ,NFE_ID_OLD '+
    ' ,NFE_INTEGRACAO_OLD '+
    ' ,COD_AJ '+
    ' ,NFE_PERCENTUALICMSFRETENF '+
    ' ,NFE_PERCENTUALICMSDESPACESSORIA '+
    ' ,NFE_TOTALPESOBRUTO '+
    ' ,NFE_TOTALPESOLIQUIDO '+
    ' ,NFE_DATACANCELAMENTO '+
    ' ,NFE_OBSERVACAOCANCELAMENTO '+
    ' ,NFE_NUMERORPA '+
    ' ,NFE_PLANOCONTARATEIO '+
    ' ,NFE_CHAVEACESSO '+
    ' ,NFE_OBSERVACAO '+
    ' ,NFE_PROCESSADO '+
    ' ,NFE_LIVROFISCAL '+
    ' ,NFE_CANCELADA '+
    ' ,NFE_INTEGRACAO '+
    ' ,NFE_DATAALTERACAO '+
    ' ,NFE_TOTALICMSDESONERADO '+
    ' ,NFE_PORTEFORNECEDOR '+
    ' FROM NFE_00 '+
    ' WHERE NFE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_01', 'SELECT NFE_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,NFE_ID '+
    ' ,CMP_ID '+
    ' ,PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,LEE_CODIGO '+
    ' ,GAI_CODIGO '+
    ' ,CLF_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,NFE_ORDEMITEM '+
    ' ,NFE_QTDENTRADA '+
    ' ,NFE_QTDDEVOLVIDA = 0 '+
    ' ,NFE_ITEMALTERADO '+
    ' ,NFE_VALORITEM '+
    ' ,NFE_VALORIPIITEM '+
    ' ,NFE_VALORPISITEM '+
    ' ,NFE_VALORICMSITEM '+
    ' ,NFE_VALORVERBAITEM '+
    ' ,NFE_VALORCOFINSITEM '+
    ' ,NFE_VALORSEGUROITEM '+
    ' ,NFE_VALORSERVICOITEM '+
    ' ,NFE_VALORDESCTOITEM '+
    ' ,NFE_VALORICMSRNFITEM '+
    ' ,NFE_VALORFRETENFITEM '+
    ' ,NFE_VALORFRETERPAITEM '+
    ' ,NFE_VALORICMSRDUAITEM '+
    ' ,NFE_VALORADICIONALITEM '+
    ' ,NFE_VALORFRETECTRITEM '+
    ' ,NFE_VALORICMSSIMPLESITEM '+
    ' ,NFE_VALORBONIFICACAOITEM '+
    ' ,NFE_VALORBASEOUTROSITEM '+
    ' ,NFE_VALIDADE '+
    ' ,NFE_VALORICMSFRETENFITEM '+
    ' ,NFE_VALORICMSFRETECTRITEM '+
    ' ,NFE_VALORICMSACESSORIAITEM '+
    ' ,NFE_VALORDESPACESSORIAITEM '+
    ' ,NFE_VALORSUBSTRIBUTARIAITEM '+
    ' ,NFE_VALORBASEISENTOICMSITEM '+
    ' ,NFE_VALORBASECALCULOMVAITEM '+
    ' ,NFE_VALORBASECALCULOICMSITEM '+
    ' ,NFE_VALORCOMPLEMENTONFICMSITEM '+
    ' ,NFE_PRECOPRODUTOALTERADO '+
    ' ,CMP_ID_OLD '+
    ' ,NFE_01_ID_OLD '+
    ' ,NFE_ID_OLD '+
    ' ,NFE_PERCENTUALIPIITEM '+
    ' ,NFE_PERCENTUALPISITEM '+
    ' ,NFE_PERCENTUALMVAITEM '+
    ' ,NFE_PERCENTUALICMSITEM '+
    ' ,NFE_PERCENTUALCOFINSITEM '+
    ' ,NFE_PERCENTUALVERBAITEM '+
    ' ,NFE_PERCENTUALDESCTOITEM '+
    ' ,NFE_PERCENTUALICMSRNFITEM '+
    ' ,NFE_PERCENTUALSERVICOITEM '+
    ' ,NFE_PERCENTUALSEGUROITEM '+
    ' ,NFE_PERCENTUALFRETENFITEM '+
    ' ,NFE_PERCBCICMSFRETECTRITEM '+
    ' ,NFE_PERCENTUALICMSRDUAITEM '+
    ' ,NFE_PERCENTUALFRETECTRITEM '+
    ' ,NFE_PERCENTUALFRETERPAITEM '+
    ' ,NFE_PERCENTUALICMSSAIDAITEM '+
    ' ,NFE_PERCENTUALREDUCAOBCITEM '+
    ' ,NFE_PERCENTUALICMSSIMPLESITEM '+
    ' ,NFE_PERCENTUALICMSDESTINOITEM '+
    ' ,NFE_PERCENTUALBONIFICACAOITEM '+
    ' ,NFE_PERCENTUALICMSFRETENFITEM '+
    ' ,NFE_PERCENTUALICMSFRETECTRITEM '+
    ' ,NFE_PERCENTUALDESPACESSORIAITEM '+
    ' ,NFE_PERCENTUALICMSACESSORIAITEM '+
    ' ,NFE_VALORCUSTOCOMPRANFE '+
    ' ,NFE_VALORCUSTOLIQUIDONFE '+
    ' ,NFE_VALORCUSTOINVENTARIONFE '+
    ' ,NFE_VALORCUSTOCOMPRAMEDIO '+
    ' ,NFE_VALORCUSTOLIQUIDOMEDIO '+
    ' ,NFE_VALORCUSTOINVENTARIOMEDIO '+
    ' ,NFE_VALORBCICMSFRETECTRITEM '+
    ' ,NFE_VALORBCICMSFRETENFITEM '+
    ' ,NFE_VALORBCALCULOPISCOFINSITEM = NFE_VALORBASECALCULOPISITEM '+
    ' ,NFE_ULTIMOCUSTOCOMPRA '+
    ' ,NFE_ULTIMOCUSTOLIQUIDO '+
    ' ,NFE_ULTIMOCUSTOINVENTARIO '+
    ' ,NFE_ULTIMOCUSTOCOMPRAMEDIO '+
    ' ,NFE_ULTIMOCUSTOLIQUIDOMEDIO '+
    ' ,NFE_ULTIMOCUSTOINVENTARIOMEDIO '+
    ' ,NFE_PRECOZEROMKP '+
    ' ,NFE_PRECOVENDAMKP '+
    ' ,NFE_PRECOSUGERIDOMKP '+
    ' ,NFE_PERCENTUALLUCROVENDAMKP '+
    ' ,NFE_PERCENTUALLUCROSUGERIDOMKP '+
    ' ,NFE_PERCENTUALDESPESASLUCROMKP '+
    ' ,NFE_PERCENTUALMARKUPLUCRO '+
    ' ,NFE_PERCENTUALMARKUPZERO '+
    ' ,NFE_PERCENTUALICMSMARKUP '+
    ' ,NFE_TOTALITEM '+
    ' ,NFE_TOTALIPIITEM '+
    ' ,NFE_TOTALPISITEM '+
    ' ,NFE_TOTALICMSITEM   '+
    ' ,NFE_TOTALVERBAITEM '+
    ' ,NFE_TOTALCOFINSITEM '+
    ' ,NFE_TOTALSEGUROITEM '+
    ' ,NFE_TOTALSERVICOITEM '+
    ' ,NFE_TOTALDESCTOITEM '+
    ' ,NFE_TOTALICMSRNFITEM '+
    ' ,NFE_TOTALFRETENFITEM '+
    ' ,NFE_TOTALFRETERPAITEM '+
    ' ,NFE_TOTALICMSRDUAITEM '+
    ' ,NFE_TOTALADICIONALITEM '+
    ' ,NFE_TOTALFRETECTRITEM '+
    ' ,NFE_TOTALICMSSIMPLESITEM '+
    ' ,NFE_TOTALBONIFICACAOITEM '+
    ' ,NFE_TOTALBASEOUTROSITEM '+
    ' ,NFE_TOTALICMSFRETENFITEM '+
    ' ,NFE_TOTALICMSFRETECTRITEM '+
    ' ,NFE_TOTALICMSACESSORIAITEM '+
    ' ,NFE_TOTALDESPACESSORIAITEM '+
    ' ,NFE_TOTALSUBSTRIBUTARIAITEM '+
    ' ,NFE_TOTALBASEISENTOICMSITEM '+
    ' ,NFE_TOTALBASECALCULOMVAITEM '+
    ' ,NFE_TOTALBASECALCULOICMSITEM '+
    ' ,NFE_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,NFE_TOTALBCICMSFRETECTRITEM '+
    ' ,NFE_TOTALBCALCULOPISCOFINSITEM = NFE_TOTALBASECALCULOPISITEM '+
    ' ,NFE_TOTALBCICMSFRETENFITEM '+
    ' ,NFE_RATEADO '+
    ' ,NFE_DATAALTERACAO '+
    ' ,NFE_VALORICMSDESONERADOITEM '+
    ' ,NFE_PROCEDENCIA '+
    ' FROM NFE_00_01 '+
    ' WHERE NFE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFE_00_02 '+
    ' WHERE NFE_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    'FROM NFE_00_03 '+
    ' WHERE NFE_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFE_00_04 '+
    ' WHERE NFE_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_05', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFE_00_05 '+
    ' WHERE NFE_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_06', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFE_00_06 '+
    ' WHERE NFE_00_06.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_00_06_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFE_00_06_01 '+
    ' WHERE NFE_00_06_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFE_XML', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    'FROM NFE_XML '+
    ' WHERE NFE_XML.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00', 'SELECT NFP_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,NFP_SERIE '+
    ' ,TDC_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NFP_NOTAFISCAL '+
    ' ,NFP_NUMERODOCTO '+
    ' ,NFP_DATALANCAMENTO '+
    ' ,NFP_DATACANCELAMENTO '+
    ' ,NFP_OBSERVACAOCANCELAMENTO '+
    ' ,NFP_TOTALNOTAFISCAL '+
    ' ,NFP_TOTALPRODUTOS '+
    ' ,NFP_TIPOFRETE '+
    ' ,NFP_TOTALIPI '+
    ' ,NFP_TOTALICMS '+
    ' ,NFP_TOTALSERVICO '+
    ' ,NFP_TOTALSEGURO '+
    ' ,NFP_TOTALFRETENF '+
    ' ,NFP_TOTALADICIONAL '+
    ' ,NFP_TOTALFRETERPA '+
    ' ,NFP_TOTALPESOBRUTO '+
    ' ,NFP_TOTALPESOLIQUIDO '+
    ' ,NFP_TOTALQTDENTRADA '+
    ' ,NFP_TOTALDESCTOITEM '+
    ' ,NFP_TOTALICMSSIMPLES '+
    ' ,NFP_TOTALDESPACESSORIA '+
    ' ,NFP_TOTALBASEISENTOICMS '+
    ' ,NFP_TOTALNUMEROVOLUMES '+
    ' ,NFP_TOTALICMSFRETENF '+
    ' ,NFP_TOTALRBCICMSFRETENF '+
    ' ,NFP_PERCENTUALICMSFRETENF '+
    ' ,NFP_TOTALBASECALCULOICMS '+
    ' ,NFP_TOTALBCALCULOPISCOFINS = NFP_TOTALBASECALCULOPIS '+
    ' ,NFP_TOTALCOMPLEMENTONFICMS '+
    ' ,NFP_PLANOCONTARATEIO '+
    ' ,NFP_NUMERACAOVOLUMES '+
    ' ,NFP_INFCOMPLEMENTAR '+
    ' ,NFP_ESPECIEVOLUMES '+
    ' ,NFP_MARCAVOLUMES '+
    ' ,NFP_NUMERORPA '+
    ' ,NFP_PLACAVEICULO '+
    ' ,NFP_UFVEICULO '+
    ' ,NFP_TOTALCOFINS '+
    ' ,NFP_TOTALPIS '+
    ' ,NFP_ID_OLD '+
    ' ,NFP_CHAVEACESSO '+
    ' ,NFP_OBSERVACAO '+
    ' ,NFP_CANCELADA '+
    ' ,NFP_PROCESSADO '+
    ' ,NFP_DESATIVADO '+
    ' ,NFP_LIVROFISCAL '+
    ' ,NFP_DATAALTERACAO '+
    ' FROM NFP_00 '+
    ' WHERE NFP_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00_01', 'SELECT NFP_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,NFP_ID '+
    ' ,CST_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NFP_QTDENTRADA '+
    ' ,NFP_VALORITEM '+
    ' ,NFP_VALORIPIITEM '+
    ' ,NFP_VALORICMSITEM '+
    ' ,NFP_VALORVERBAITEM '+
    ' ,NFP_VALORDESCTOITEM '+
    ' ,NFP_VALORSEGUROITEM '+
    ' ,NFP_VALORSERVICOITEM '+
    ' ,NFP_VALORFRETENFITEM '+
    ' ,NFP_VALORFRETECTRITEM '+
    ' ,NFP_VALORFRETERPAITEM '+
    ' ,NFP_VALORADICIONALITEM '+
    ' ,NFP_VALORICMSFRETENFITEM '+
    ' ,NFP_VALORBASEOUTROSITEM '+
    ' ,NFP_VALORBONIFICACAOITEM '+
    ' ,NFP_VALORICMSFRETECTRITEM '+
    ' ,NFP_VALORDESPACESSORIAITEM '+
    ' ,NFP_VALORBASEISENTOICMSITEM '+
    ' ,NFP_VALORBASECALCULOICMSITEM '+
    ' ,NFP_VALORCOMPLEMENTONFICMSITEM '+
    ' ,NFP_PERCENTUALIPIITEM '+
    ' ,NFP_PERCENTUALICMSITEM '+
    ' ,NFP_PERCENTUALVERBAITEM '+
    ' ,NFP_PERCENTUALDESCTOITEM '+
    ' ,NFP_PERCENTUALSEGUROITEM '+
    ' ,NFP_PERCENTUALSERVICOITEM '+
    ' ,NFP_PERCENTUALFRETENFITEM '+
    ' ,NFP_PERCENTUALFRETERPAITEM '+
    ' ,NFP_PERCENTUALFRETECTRITEM '+
    ' ,NFP_PERCENTUALREDUCAOBCITEM '+
    ' ,NFP_PERCENTUALICMSSIMPLESITEM '+
    ' ,NFP_PERCENTUALICMSFRETENFITEM '+
    ' ,NFP_PERCENTUALBONIFICACAOITEM '+
    ' ,NFP_PERCENTUALICMSDESTINOITEM '+
    ' ,NFP_PERCENTUALICMSFRETECTRITEM '+
    ' ,NFP_PERCENTUALDESPACESSORIAITEM '+
    ' ,NFP_VALORICMSSIMPLESITEM '+
    ' ,NFP_VALORCUSTOCOMPRANFE '+
    ' ,NFP_VALORCUSTOLIQUIDONFE '+
    ' ,NFP_VALORCUSTOINVENTARIONFE '+
    ' ,NFP_VALORCUSTOCOMPRAMEDIO '+
    ' ,NFP_VALORCUSTOLIQUIDOMEDIO '+
    ' ,NFP_VALORCUSTOINVENTARIOMEDIO '+
    ' ,NFP_ULTIMOCUSTOCOMPRA '+
    ' ,NFP_ULTIMOCUSTOLIQUIDO '+
    ' ,NFP_ULTIMOCUSTOINVENTARIO '+
    ' ,NFP_DATAALTERACAO '+
    ' ,NFP_ULTIMOCUSTOCOMPRAMEDIO '+
    ' ,NFP_ULTIMOCUSTOLIQUIDOMEDIO '+
    ' ,NFP_ULTIMOCUSTOINVENTARIOMEDIO '+
    ' ,NFP_PERCENTUALCOFINSITEM '+
    ' ,NFP_PERCENTUALPISITEM '+
    ' ,NFP_VALORCOFINSITEM '+
    ' ,NFP_VALORPISITEM '+
    ' ,NFP_VALORBCALCULOPISCOFINSITEM = NFP_VALORBASECALCULOPISITEM '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,NFP_TOTALIPIITEM '+
    ' ,NFP_TOTALICMSITEM '+
    ' ,NFP_TOTALVERBAITEM '+
    ' ,NFP_TOTALDESCTOITEM '+
    ' ,NFP_TOTALSEGUROITEM '+
    ' ,NFP_TOTALSERVICOITEM '+
    ' ,NFP_TOTALFRETENFITEM '+
    ' ,NFP_TOTALFRETECTRITEM '+
    ' ,NFP_TOTALFRETERPAITEM '+
    ' ,NFP_TOTALADICIONALITEM '+
    ' ,NFP_TOTALICMSFRETENFITEM '+
    ' ,NFP_TOTALBASEOUTROSITEM '+
    ' ,NFP_TOTALBONIFICACAOITEM '+
    ' ,NFP_TOTALICMSFRETECTRITEM '+
    ' ,NFP_TOTALDESPACESSORIAITEM '+
    ' ,NFP_TOTALBASEISENTOICMSITEM '+
    ' ,NFP_TOTALBASECALCULOICMSITEM '+
    ' ,NFP_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,NFP_TOTALICMSSIMPLESITEM '+
    ' ,NFP_TOTALCOFINSITEM '+
    ' ,NFP_ID_OLD '+
    ' ,NFP_01_ID_OLD '+
    ' ,NFP_TOTALPISITEM '+
    ' ,NFP_TOTALBCALCULOPISCOFINSITEM = NFP_TOTALBASECALCULOPISITEM '+
    ' ,NFP_TOTALITEM '+
    ' FROM NFP_00_01 '+
    ' WHERE NFP_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFP_00_02 '+
    ' WHERE NFP_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFP_00_03 '+
    ' WHERE NFP_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFP_00_04 '+
    ' WHERE NFP_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00_05', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFP_00_05 '+
    ' WHERE NFP_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNFP_00_05_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM NFP_00_05_01 '+
    ' WHERE NFP_00_05_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TNLP_00', 'SELECT COM_CODIGO = 0, * FROM NLP_00');
   //----------------------------------------------------------------------------
    QueryList.Add('TNTC_00', 'SELECT COM_CODIGO = 0, * FROM NTC_00');
   //----------------------------------------------------------------------------
    QueryList.Add('TNTO_00', 'SELECT COM_CODIGO = 0, * FROM NTO_00');
  //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00', 'SELECT OMF_ID = SSE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_TIPODOCUMENTO = '+
    '  CASE '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('NRM') + ' THEN ' + QuotedStr('VRF') + ' '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('AJU') + ' THEN ' + QuotedStr('VRF') + ' '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('CPM') + ' THEN ' + QuotedStr('CIV') + ' '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('DEV') + ' THEN ' + QuotedStr('DCP') + ' '+
    '  END '+
    ' ,MNF_CODIGO '+
    ' ,OMF_SERIE = SSE_SERIE '+
    ' ,OMF_NOTAFISCAL = SSE_NOTAFISCAL '+
    ' ,OMF_PEDIDOCOMPRA = NULL '+
    ' ,OMF_DATAEMISSAO = SSE_DATALANCAMENTO '+
    ' ,OMF_DATAENTRADA = SSE_DATALANCAMENTO '+
    ' ,OMF_DATALANCAMENTO = SSE_DATALANCAMENTO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO = NULL '+
    ' ,CCU_CODIGO = NULL '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,OMF_TIPOFRETE = SSE_TIPOFRETE '+
    ' ,OMF_TOTALIPI = SSE_TOTALIPI '+
    ' ,OMF_TOTALPIS = SSE_TOTALPIS '+
    ' ,OMF_TOTALICMS = SSE_TOTALICMS '+
    ' ,OMF_TOTALCOFINS = SSE_TOTALCOFINS '+
    ' ,OMF_TOTALDESCTO = SSE_TOTALDESCTOAVULSO '+
    ' ,OMF_TOTALSEGURO = SSE_TOTALSEGURO '+
    ' ,OMF_TOTALSERVICO = SSE_TOTALSERVICO '+
    ' ,OMF_TOTALFRETENF = SSE_TOTALFRETE '+
    ' ,OMF_TOTALICMSRNF = SSE_TOTALICMSR '+
    ' ,OMF_TOTALADICIONAL = 0 '+
    ' ,OMF_TOTALPRODUTOS = SSE_TOTALPRODUTOS '+
    ' ,OMF_TOTALNOTAFISCAL = SSE_TOTALLIQUIDO '+
    ' ,OMF_TOTALICMSSIMPLES = 0 '+
    ' ,OMF_TOTALFRETERPA = 0 '+
    ' ,OMF_TOTALICMSFRETENF = 0 '+
    ' ,OMF_TOTALDESPACESSORIA = SSE_TOTALDESPACESSORIA '+
    ' ,OMF_TOTALSUBSTRIBUTARIA = SSE_TOTALSUBSTRIBUTARIA '+
    ' ,OMF_TOTALBASEISENTOICMS = SSE_TOTALBASEISENTOICMS '+
    ' ,OMF_TOTALBASECALCULOMVA = SSE_TOTALBASECALCULOMVA '+
    ' ,OMF_TOTALBASECALCULOICMS = SSE_TOTALBASECALCULOICMS '+
    ' ,OMF_TOTALBCALCULOPISCOFINS = SSE_TOTALBASECALCULOPIS '+
    ' ,OMF_TOTALBCICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALCOMPLEMENTONFICMS = SSE_TOTALCOMPLEMENTONFICMS '+
    ' ,OMF_TOTALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALBASECALCULOICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALPESOBRUTO = SSE_TOTALPESOBRUTO '+
    ' ,OMF_TOTALPESOLIQUIDO = SSE_TOTALPESOLIQUIDO '+
    ' ,OMF_DATACANCELAMENTO = SSE_DATACANCELAMENTO '+
    ' ,OMF_OBSERVACAOCANCELAMENTO = SSE_OBSERVACAOCANCELAMENTO '+
    ' ,OMF_INFCOMPLEMENTAR = SSE_INFCOMPLEMENTAR '+
    ' ,OMF_NUMERORPA = NULL '+
    ' ,OMF_PLANOCONTARATEIO = NULL '+
    ' ,OMF_CHAVEACESSO = NULL '+
    ' ,OMF_OBSERVACAO = SSE_OBSERVACAO '+
    ' ,OMF_FINANCEIRO = SSE_FINANCEIRO '+
    ' ,OMF_PROCESSADO = SSE_PROCESSADO '+
    ' ,OMF_LIVROFISCAL = SSE_LIVROFISCAL '+
    ' ,OMF_CANCELADA = SSE_CANCELADA '+
    ' ,OMF_INTEGRACAO = ' + QuotedStr('SSE') + ' + CAST(SSE_ID AS VARCHAR) '+
    ' ,OMF_DATAALTERACAO = SSE_DATAALTERACAO '+
    ' ,FAT_NOTAFISCAL = NULL '+
    ' ,FAT_SERIE = NULL '+
    ' ,OMF_CHAVEREFERENCIANFE = SSE_CHAVEREFERENCIANFE '+
    ' ,OMF_FINALIDADE = '+
    '  CASE '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('NRM') + ' THEN ' + QuotedStr('1') + ' '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('CPM') + ' THEN ' + QuotedStr('2') + ' '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('DEV') + ' THEN ' + QuotedStr('3') + ' '+
    '    WHEN SSE_TIPODOCUMENTO = ' + QuotedStr('AJU') + ' THEN ' + QuotedStr('4') + ' '+
    '  END '+
    ' ,OMF_ES = ' + QuotedStr('S') + ' '+
    ' ,OMF_ESPECIEVOLUMES = NULL '+
    ' ,OMF_NUMERACAOVOLUMES = NULL '+
    ' ,OMF_TOTALNUMEROVOLUMES = NULL '+
    ' ,OMF_MARCAVOLUMES = NULL '+
    ' ,OMF_ID_OLD = NULL '+
    ' ,OMF_INTEGRACAO_OLD = NULL '+
    ' ,VND_CODIGO = 0 '+
    ' ,TRP_CODIGO = 0 '+
    ' ,OMF_TOTALCOMISSAO = 0 '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTO = 0 '+
    ' ,OMF_PERCENTUALDESCTO = 0 '+
    ' ,OMF_PERCENTUALIBPT = 0 '+
    ' ,USERS_LOGIN = '''' '+
    ' ,OMF_PERCENTUALCOMISSAO = 0 '+
    ' ,OMF_TOTALBASECALCULOCOMISSAO = 0 '+
    ' ,OMF_TOTALIBPTMUNICIPAL = 0 '+
    ' ,OMF_TOTALIBPTESTADUAL = 0 '+
    ' ,OMF_TOTALIBPTNACIONAL = 0 '+
    ' ,OMF_TOTALIBPTIMPORTADO = 0 '+
    ' ,OMF_PERCENTUALIBPTMUNICIPAL = 0 '+
    ' ,OMF_PERCENTUALIBPTESTADUAL = 0 '+
    ' ,OMF_PERCENTUALIBPTNACIONAL = 0 '+
    ' ,OMF_PERCENTUALIBPTIMPORTADO = 0 '+
    ' ,CON_CODIGO = 0 '+
    ' ,OMF_TOTALBASECALCULOFCP = 0 '+
    ' ,OMF_TOTALFCP = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPST = 0 '+
    ' ,OMF_TOTALFCPST = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPRET = 0 '+
    ' ,OMF_TOTALFCPRET = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_ID = NULL '+
    ' ,OMF_TIPOLIGACAO = NULL '+
    ' ,OMF_GRUPOTENSAO = NULL '+
    ' FROM SSE_00 '+
    ' WHERE SSE_00.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_ID = SEE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_TIPODOCUMENTO = '+
    '  CASE '+
    '    WHEN SEE_TIPODOCUMENTO = ' + QuotedStr('NRM') + ' THEN ' + QuotedStr('CRF') + ' '+
    '    WHEN SEE_TIPODOCUMENTO = ' + QuotedStr('CPM') + ' THEN ' + QuotedStr('CRF') + ' '+
    '    WHEN SEE_TIPODOCUMENTO = ' + QuotedStr('CPI') + ' THEN ' + QuotedStr('CRF') + ' '+
    '    WHEN SEE_TIPODOCUMENTO = ' + QuotedStr('SRV') + ' THEN ' + QuotedStr('CSE') + ' '+
    '    WHEN SEE_TIPODOCUMENTO = ' + QuotedStr('CAP') + ' THEN ' + QuotedStr('CPI') + ' '+
    '  END '+
    ' ,MNF_CODIGO '+
    ' ,OMF_SERIE = SEE_SERIE '+
    ' ,OMF_NOTAFISCAL = SEE_NOTAFISCAL '+
    ' ,OMF_PEDIDOCOMPRA = NULL '+
    ' ,OMF_DATAEMISSAO = SEE_DATAEMISSAO '+
    ' ,OMF_DATAENTRADA = SEE_DATALANCAMENTO '+
    ' ,OMF_DATALANCAMENTO = SEE_DATALANCAMENTO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO = NULL '+
    ' ,CCU_CODIGO = NULL '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,OMF_TIPOFRETE = SEE_TIPOFRETE '+
    ' ,OMF_TOTALIPI = SEE_TOTALIPI '+
    ' ,OMF_TOTALPIS = SEE_TOTALPIS '+
    ' ,OMF_TOTALICMS = SEE_TOTALICMS '+
    ' ,OMF_TOTALCOFINS = SEE_TOTALCOFINS '+
    ' ,OMF_TOTALDESCTO = SEE_TOTALDESCTOAVULSO '+
    ' ,OMF_TOTALSEGURO = SEE_TOTALSEGURO '+
    ' ,OMF_TOTALSERVICO = SEE_TOTALSERVICO '+
    ' ,OMF_TOTALFRETENF = SEE_TOTALFRETE '+
    ' ,OMF_TOTALICMSRNF = SEE_TOTALICMSR '+
    ' ,OMF_TOTALADICIONAL = 0 '+
    ' ,OMF_TOTALPRODUTOS = SEE_TOTALPRODUTOS '+
    ' ,OMF_TOTALNOTAFISCAL = SEE_TOTALLIQUIDO '+
    ' ,OMF_TOTALICMSSIMPLES = 0 '+
    ' ,OMF_TOTALFRETERPA = 0 '+
    ' ,OMF_TOTALICMSFRETENF = 0 '+
    ' ,OMF_TOTALDESPACESSORIA = SEE_TOTALDESPACESSORIA '+
    ' ,OMF_TOTALSUBSTRIBUTARIA = SEE_TOTALSUBSTRIBUTARIA '+
    ' ,OMF_TOTALBASEISENTOICMS = SEE_TOTALBASEISENTOICMS '+
    ' ,OMF_TOTALBASECALCULOMVA = SEE_TOTALBASECALCULOMVA '+
    ' ,OMF_TOTALBASECALCULOICMS = SEE_TOTALBASECALCULOICMS '+
    ' ,OMF_TOTALBCALCULOPISCOFINS = SEE_TOTALBASECALCULOPIS '+
    ' ,OMF_TOTALBCICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALCOMPLEMENTONFICMS = SEE_TOTALCOMPLEMENTONFICMS '+
    ' ,OMF_TOTALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALBASECALCULOICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALPESOBRUTO = SEE_TOTALPESOBRUTO '+
    ' ,OMF_TOTALPESOLIQUIDO = SEE_TOTALPESOLIQUIDO '+
    ' ,OMF_DATACANCELAMENTO = SEE_DATACANCELAMENTO '+
    ' ,OMF_OBSERVACAOCANCELAMENTO = SEE_OBSERVACAOCANCELAMENTO '+
    ' ,OMF_INFCOMPLEMENTAR = SEE_INFCOMPLEMENTAR '+
    ' ,OMF_NUMERORPA = NULL '+
    ' ,OMF_PLANOCONTARATEIO = SEE_PLANOCONTARATEIO '+
    ' ,OMF_CHAVEACESSO = SEE_CHAVEACESSO '+
    ' ,OMF_OBSERVACAO = SEE_OBSERVACAO '+
    ' ,OMF_FINANCEIRO = SEE_FINANCEIRO '+
    ' ,OMF_PROCESSADO = SEE_PROCESSADO '+
    ' ,OMF_LIVROFISCAL = SEE_LIVROFISCAL '+
    ' ,OMF_CANCELADA = SEE_CANCELADA '+
    ' ,OMF_INTEGRACAO = ' + QuotedStr('SEE') + ' + CAST(SEE_ID AS VARCHAR) '+
    ' ,OMF_DATAALTERACAO = SEE_DATAALTERACAO '+
    ' ,FAT_NOTAFISCAL = NULL '+
    ' ,FAT_SERIE = NULL '+
    ' ,OMF_CHAVEREFERENCIANFE = SEE_CHAVEREFERENCIANFE '+
    ' ,OMF_FINALIDADE = ' + QuotedStr('1') + ' '+
    ' ,OMF_ES = ' + QuotedStr('E') + ' '+
    ' ,OMF_ESPECIEVOLUMES = NULL '+
    ' ,OMF_NUMERACAOVOLUMES = NULL '+
    ' ,OMF_TOTALNUMEROVOLUMES = NULL '+
    ' ,OMF_MARCAVOLUMES = NULL '+
    ' ,OMF_ID_OLD = NULL '+
    ' ,OMF_INTEGRACAO_OLD = NULL '+
    ' ,VND_CODIGO = 0 '+
    ' ,TRP_CODIGO = 0 '+
    ' ,OMF_TOTALCOMISSAO = 0 '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTO = 0 '+
    ' ,OMF_PERCENTUALDESCTO = 0 '+
    ' ,OMF_PERCENTUALIBPT = 0 '+
    ' ,USERS_LOGIN = ' + QuotedStr('') + ' '+
    ' ,OMF_PERCENTUALCOMISSAO = 0 '+
    ' ,OMF_TOTALBASECALCULOCOMISSAO = 0 '+
    ' ,OMF_TOTALIBPTMUNICIPAL = 0 '+
    ' ,OMF_TOTALIBPTESTADUAL = 0 '+
    ' ,OMF_TOTALIBPTNACIONAL = 0 '+
    ' ,OMF_TOTALIBPTIMPORTADO = 0 '+
    ' ,OMF_PERCENTUALIBPTMUNICIPAL = 0 '+
    ' ,OMF_PERCENTUALIBPTESTADUAL = 0 '+
    ' ,OMF_PERCENTUALIBPTNACIONAL = 0 '+
    ' ,OMF_PERCENTUALIBPTIMPORTADO = 0 '+
    ' ,CON_CODIGO = 0 '+
    ' ,OMF_TOTALBASECALCULOFCP = 0 '+
    ' ,OMF_TOTALFCP = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPST = 0 '+
    ' ,OMF_TOTALFCPST = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPRET = 0 '+
    ' ,OMF_TOTALFCPRET = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_ID = NULL '+
    ' ,OMF_TIPOLIGACAO = SEE_TIPOLIGACAO '+
    ' ,OMF_GRUPOTENSAO = SEE_GRUPOTENSAO '+
    ' FROM SEE_00 '+
    ' WHERE SEE_00.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_ID = ONE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_TIPODOCUMENTO = '+
    '  CASE '+
    '    WHEN ONE_TIPODOCUMENTO = ' + QuotedStr('NRM') + ' THEN ' + QuotedStr('REN') + ' '+
    '    WHEN ONE_TIPODOCUMENTO = ' + QuotedStr('TRF') + ' THEN ' + QuotedStr('ETR') + ' '+
    '  END '+
    ' ,MNF_CODIGO '+
    ' ,OMF_SERIE = ONE_SERIE '+
    ' ,OMF_NOTAFISCAL = ONE_NOTAFISCAL '+
    ' ,OMF_PEDIDOCOMPRA = NULL '+
    ' ,OMF_DATAEMISSAO = ONE_DATAEMISSAO '+
    ' ,OMF_DATAENTRADA = ONE_DATALANCAMENTO '+
    ' ,OMF_DATALANCAMENTO = ONE_DATALANCAMENTO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO = NULL '+
    ' ,CCU_CODIGO = NULL '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,OMF_TIPOFRETE = ONE_TIPOFRETE '+
    ' ,OMF_TOTALIPI = ONE_TOTALIPI '+
    ' ,OMF_TOTALPIS = ONE_TOTALPIS '+
    ' ,OMF_TOTALICMS = ONE_TOTALICMS '+
    ' ,OMF_TOTALCOFINS = ONE_TOTALCOFINS '+
    ' ,OMF_TOTALDESCTO = ONE_TOTALDESCTOAVULSO '+
    ' ,OMF_TOTALSEGURO = ONE_TOTALSEGURO '+
    ' ,OMF_TOTALSERVICO = ONE_TOTALSERVICO '+
    ' ,OMF_TOTALFRETENF = ONE_TOTALFRETE '+
    ' ,OMF_TOTALICMSRNF = ONE_TOTALICMSR '+
    ' ,OMF_TOTALADICIONAL = 0 '+
    ' ,OMF_TOTALPRODUTOS = ONE_TOTALPRODUTOS '+
    ' ,OMF_TOTALNOTAFISCAL = ONE_TOTALLIQUIDO '+
    ' ,OMF_TOTALICMSSIMPLES = 0 '+
    ' ,OMF_TOTALFRETERPA = 0 '+
    ' ,OMF_TOTALICMSFRETENF = 0 '+
    ' ,OMF_TOTALDESPACESSORIA = ONE_TOTALDESPACESSORIA '+
    ' ,OMF_TOTALSUBSTRIBUTARIA = ONE_TOTALSUBSTRIBUTARIA '+
    ' ,OMF_TOTALBASEISENTOICMS = ONE_TOTALBASEISENTOICMS '+
    ' ,OMF_TOTALBASECALCULOMVA = ONE_TOTALBASECALCULOMVA '+
    ' ,OMF_TOTALBASECALCULOICMS = ONE_TOTALBASECALCULOICMS '+
    ' ,OMF_TOTALBCALCULOPISCOFINS = ONE_TOTALBASECALCULOPIS '+
    ' ,OMF_TOTALBCICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALCOMPLEMENTONFICMS = ONE_TOTALCOMPLEMENTONFICMS '+
    ' ,OMF_TOTALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALBASECALCULOICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALPESOBRUTO = ONE_TOTALPESOBRUTO '+
    ' ,OMF_TOTALPESOLIQUIDO = ONE_TOTALPESOLIQUIDO '+
    ' ,OMF_DATACANCELAMENTO = ONE_DATACANCELAMENTO '+
    ' ,OMF_OBSERVACAOCANCELAMENTO = ONE_OBSERVACAOCANCELAMENTO '+
    ' ,OMF_INFCOMPLEMENTAR = ONE_INFCOMPLEMENTAR '+
    ' ,OMF_NUMERORPA = NULL '+
    ' ,OMF_PLANOCONTARATEIO = ONE_PLANOCONTARATEIO '+
    ' ,OMF_CHAVEACESSO = ONE_CHAVEACESSO '+
    ' ,OMF_OBSERVACAO = ONE_OBSERVACAO '+
    ' ,OMF_FINANCEIRO = ONE_FINANCEIRO '+
    ' ,OMF_PROCESSADO = ONE_PROCESSADO '+
    ' ,OMF_LIVROFISCAL = ONE_LIVROFISCAL '+
    ' ,OMF_CANCELADA = ONE_CANCELADA '+
    ' ,OMF_INTEGRACAO = ' + QuotedStr('ONE') + ' + CAST(ONE_ID AS VARCHAR) '+
    ' ,OMF_DATAALTERACAO = ONE_DATAALTERACAO '+
    ' ,FAT_NOTAFISCAL = NULL '+
    ' ,FAT_SERIE = NULL '+
    ' ,OMF_CHAVEREFERENCIANFE = NULL '+
    ' ,OMF_FINALIDADE = ' + QuotedStr('1') + ' '+
    ' ,OMF_ES = ' + QuotedStr('E') + ' '+
    ' ,OMF_ESPECIEVOLUMES = NULL '+
    ' ,OMF_NUMERACAOVOLUMES = NULL '+
    ' ,OMF_TOTALNUMEROVOLUMES = NULL '+
    ' ,OMF_MARCAVOLUMES = NULL '+
    ' ,OMF_ID_OLD = NULL '+
    ' ,OMF_INTEGRACAO_OLD = NULL '+
    ' ,VND_CODIGO = 0 '+
    ' ,TRP_CODIGO = 0 '+
    ' ,OMF_TOTALCOMISSAO = 0 '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTO = 0 '+
    ' ,OMF_PERCENTUALDESCTO = 0 '+
    ' ,OMF_PERCENTUALIBPT = 0 '+
    ' ,USERS_LOGIN = ' + QuotedStr('') + ' '+
    ' ,OMF_PERCENTUALCOMISSAO = 0 '+
    ' ,OMF_TOTALBASECALCULOCOMISSAO = 0 '+
    ' ,OMF_TOTALIBPTMUNICIPAL = 0 '+
    ' ,OMF_TOTALIBPTESTADUAL = 0 '+
    ' ,OMF_TOTALIBPTNACIONAL = 0 '+
    ' ,OMF_TOTALIBPTIMPORTADO = 0 '+
    ' ,OMF_PERCENTUALIBPTMUNICIPAL = 0 '+
    ' ,OMF_PERCENTUALIBPTESTADUAL = 0 '+
    ' ,OMF_PERCENTUALIBPTNACIONAL = 0 '+
    ' ,OMF_PERCENTUALIBPTIMPORTADO = 0 '+
    ' ,CON_CODIGO = 0 '+
    ' ,OMF_TOTALBASECALCULOFCP = 0 '+
    ' ,OMF_TOTALFCP = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPST = 0 '+
    ' ,OMF_TOTALFCPST = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPRET = 0 '+
    ' ,OMF_TOTALFCPRET = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_ID = NULL '+
    ' ,OMF_TIPOLIGACAO = NULL '+
    ' ,OMF_GRUPOTENSAO = NULL '+
    ' FROM ONE_00 '+
    ' WHERE ONE_00.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_ID = ONS_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_TIPODOCUMENTO = '+
    '  CASE '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('NRM') + ' THEN ' + QuotedStr('RSA') + ' '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('TRF') + ' THEN ' + QuotedStr('STR') + ' '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('DEV') + ' THEN ' + QuotedStr('DCP') + ' '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('AJU') + ' THEN ' + QuotedStr('RSA') + ' '+
    '  END '+
    ' ,MNF_CODIGO '+
    ' ,OMF_SERIE = ONS_SERIE '+
    ' ,OMF_NOTAFISCAL = ONS_NOTAFISCAL '+
    ' ,OMF_PEDIDOCOMPRA = NULL '+
    ' ,OMF_DATAEMISSAO = ONS_DATALANCAMENTO '+
    ' ,OMF_DATAENTRADA = ONS_DATALANCAMENTO '+
    ' ,OMF_DATALANCAMENTO = ONS_DATALANCAMENTO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO = NULL '+
    ' ,CCU_CODIGO = NULL '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,OMF_TIPOFRETE = ONS_TIPOFRETE '+
    ' ,OMF_TOTALIPI = ONS_TOTALIPI '+
    ' ,OMF_TOTALPIS = ONS_TOTALPIS '+
    ' ,OMF_TOTALICMS = ONS_TOTALICMS '+
    ' ,OMF_TOTALCOFINS = ONS_TOTALCOFINS '+
    ' ,OMF_TOTALDESCTO = ONS_TOTALDESCTOAVULSO '+
    ' ,OMF_TOTALSEGURO = ONS_TOTALSEGURO '+
    ' ,OMF_TOTALSERVICO = ONS_TOTALSERVICO '+
    ' ,OMF_TOTALFRETENF = ONS_TOTALFRETE '+
    ' ,OMF_TOTALICMSRNF = ONS_TOTALICMSR '+
    ' ,OMF_TOTALADICIONAL = 0 '+
    ' ,OMF_TOTALPRODUTOS = ONS_TOTALPRODUTOS '+
    ' ,OMF_TOTALNOTAFISCAL = ONS_TOTALLIQUIDO '+
    ' ,OMF_TOTALICMSSIMPLES = 0 '+
    ' ,OMF_TOTALFRETERPA = 0 '+
    ' ,OMF_TOTALICMSFRETENF = 0 '+
    ' ,OMF_TOTALDESPACESSORIA = ONS_TOTALDESPACESSORIA '+
    ' ,OMF_TOTALSUBSTRIBUTARIA = ONS_TOTALSUBSTRIBUTARIA '+
    ' ,OMF_TOTALBASEISENTOICMS = ONS_TOTALBASEISENTOICMS '+
    ' ,OMF_TOTALBASECALCULOMVA = ONS_TOTALBASECALCULOMVA '+
    ' ,OMF_TOTALBASECALCULOICMS = ONS_TOTALBASECALCULOICMS '+
    ' ,OMF_TOTALBCALCULOPISCOFINS = ONS_TOTALBASECALCULOPIS '+
    ' ,OMF_TOTALBCICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALCOMPLEMENTONFICMS = ONS_TOTALCOMPLEMENTONFICMS '+
    ' ,OMF_TOTALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALBASECALCULOICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALPESOBRUTO = ONS_TOTALPESOBRUTO '+
    ' ,OMF_TOTALPESOLIQUIDO = ONS_TOTALPESOLIQUIDO '+
    ' ,OMF_DATACANCELAMENTO = ONS_DATACANCELAMENTO '+
    ' ,OMF_OBSERVACAOCANCELAMENTO = ONS_OBSERVACAOCANCELAMENTO '+
    ' ,OMF_INFCOMPLEMENTAR = ONS_INFCOMPLEMENTAR '+
    ' ,OMF_NUMERORPA = NULL '+
    ' ,OMF_PLANOCONTARATEIO = NULL '+
    ' ,OMF_CHAVEACESSO = NULL '+
    ' ,OMF_OBSERVACAO = ONS_OBSERVACAO '+
    ' ,OMF_FINANCEIRO = ' + QuotedStr('N') + ' '+
    ' ,OMF_PROCESSADO = ONS_PROCESSADO '+
    ' ,OMF_LIVROFISCAL = ONS_LIVROFISCAL '+
    ' ,OMF_CANCELADA = ONS_CANCELADA '+
    ' ,OMF_INTEGRACAO = ' + QuotedStr('ONS') + ' + CAST(ONS_ID AS VARCHAR) '+
    ' ,OMF_DATAALTERACAO = ONS_DATAALTERACAO '+
    ' ,FAT_NOTAFISCAL = NULL '+
    ' ,FAT_SERIE = NULL '+
    ' ,OMF_CHAVEREFERENCIANFE = ONS_CHAVEREFERENCIANFE '+
    ' ,OMF_FINALIDADE = '+
    '  CASE '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('NRM') + ' THEN ' + QuotedStr('1') + ' '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('TRF') + ' THEN ' + QuotedStr('1') + ' '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('DEV') + ' THEN ' + QuotedStr('4') + ' '+
    '    WHEN ONS_TIPODOCUMENTO = ' + QuotedStr('AJU') + ' THEN ' + QuotedStr('3') + ' '+
    '  END '+
    ' ,OMF_ES = ' + QuotedStr('S') + ' '+
    ' ,OMF_ESPECIEVOLUMES = NULL '+
    ' ,OMF_NUMERACAOVOLUMES = NULL '+
    ' ,OMF_TOTALNUMEROVOLUMES = NULL '+
    ' ,OMF_MARCAVOLUMES = NULL '+
    ' ,OMF_ID_OLD = NULL '+
    ' ,OMF_INTEGRACAO_OLD = NULL '+
    ' ,VND_CODIGO = 0 '+
    ' ,TRP_CODIGO = 0 '+
    ' ,OMF_TOTALCOMISSAO = 0 '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTO = 0 '+
    ' ,OMF_PERCENTUALDESCTO = 0 '+
    ' ,OMF_PERCENTUALIBPT = 0 '+
    ' ,USERS_LOGIN = ' + QuotedStr('') + ' '+
    ' ,OMF_PERCENTUALCOMISSAO = 0 '+
    ' ,OMF_TOTALBASECALCULOCOMISSAO = 0 '+
    ' ,OMF_TOTALIBPTMUNICIPAL = 0 '+
    ' ,OMF_TOTALIBPTESTADUAL = 0 '+
    ' ,OMF_TOTALIBPTNACIONAL = 0 '+
    ' ,OMF_TOTALIBPTIMPORTADO = 0 '+
    ' ,OMF_PERCENTUALIBPTMUNICIPAL = 0 '+
    ' ,OMF_PERCENTUALIBPTESTADUAL = 0 '+
    ' ,OMF_PERCENTUALIBPTNACIONAL = 0 '+
    ' ,OMF_PERCENTUALIBPTIMPORTADO = 0 '+
    ' ,CON_CODIGO = 0 '+
    ' ,OMF_TOTALBASECALCULOFCP = 0 '+
    ' ,OMF_TOTALFCP = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPST = 0 '+
    ' ,OMF_TOTALFCPST = 0 '+
    ' ,OMF_TOTALBASECALCULOFCPRET = 0 '+
    ' ,OMF_TOTALFCPRET = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_ID = NULL '+
    ' ,OMF_TIPOLIGACAO = NULL '+
    ' ,OMF_GRUPOTENSAO = NULL '+
    ' FROM ONS_00 '+
    ' WHERE ONS_00.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_ID = DEV_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_TIPODOCUMENTO = ' + QuotedStr('DVN') + ' '+
    ' ,MNF_CODIGO = MNF_CODIGO '+
    ' ,OMF_SERIE = DEV_SERIE '+
    ' ,OMF_NOTAFISCAL = DEV_NOTAFISCAL '+
    ' ,OMF_PEDIDOCOMPRA = NULL '+
    ' ,OMF_DATAEMISSAO = DEV_DATALANCAMENTO '+
    ' ,OMF_DATAENTRADA = DEV_DATALANCAMENTO '+
    ' ,OMF_DATALANCAMENTO = DEV_DATALANCAMENTO '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO = NULL '+
    ' ,CCU_CODIGO = NULL '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,OMF_TIPOFRETE = DEV_TIPOFRETE '+
    ' ,OMF_TOTALIPI = DEV_TOTALIPI '+
    ' ,OMF_TOTALPIS = DEV_TOTALPIS '+
    ' ,OMF_TOTALICMS = DEV_TOTALICMS '+
    ' ,OMF_TOTALCOFINS = DEV_TOTALCOFINS '+
    ' ,OMF_TOTALDESCTO = (DEV_TOTALDESCTOITEM + DEV_TOTALDESCTOPRAZO + DEV_TOTALDESCTOAVULSO) '+
    ' ,OMF_TOTALSEGURO = DEV_TOTALSEGURO '+
    ' ,OMF_TOTALSERVICO = DEV_TOTALSERVICO '+
    ' ,OMF_TOTALFRETENF = DEV_TOTALFRETE '+
    ' ,OMF_TOTALICMSRNF = DEV_TOTALICMSR '+
    ' ,OMF_TOTALADICIONAL = DEV_TOTALADICIONAL '+
    ' ,OMF_TOTALPRODUTOS = DEV_TOTALPRODUTOS '+
    ' ,OMF_TOTALNOTAFISCAL = DEV_TOTALLIQUIDO '+
    ' ,OMF_TOTALICMSSIMPLES = 1 '+
    ' ,OMF_TOTALFRETERPA = 0 '+
    ' ,OMF_TOTALICMSFRETENF = 0 '+
    ' ,OMF_TOTALDESPACESSORIA = DEV_TOTALDESPACESSORIA '+
    ' ,OMF_TOTALSUBSTRIBUTARIA = DEV_TOTALSUBSTRIBUTARIA '+
    ' ,OMF_TOTALBASEISENTOICMS = DEV_TOTALBASEISENTOICMS '+
    ' ,OMF_TOTALBASECALCULOMVA = DEV_TOTALBASECALCULOMVA '+
    ' ,OMF_TOTALBASECALCULOICMS = DEV_TOTALBASECALCULOICMS '+
    ' ,OMF_TOTALBCALCULOPISCOFINS = DEV_TOTALBASECALCULOPIS '+
    ' ,OMF_TOTALBCICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALCOMPLEMENTONFICMS = DEV_TOTALCOMPLEMENTONFICMS '+
    ' ,OMF_TOTALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALBASECALCULOICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENF = 0 '+
    ' ,OMF_PERCENTUALICMSDESPACESSORIA = 0 '+
    ' ,OMF_TOTALPESOBRUTO = DEV_TOTALPESOBRUTO '+
    ' ,OMF_TOTALPESOLIQUIDO = DEV_TOTALPESOLIQUIDO '+
    ' ,OMF_DATACANCELAMENTO = DEV_DATACANCELAMENTO '+
    ' ,OMF_OBSERVACAOCANCELAMENTO = DEV_OBSERVACAOCANCELAMENTO '+
    ' ,OMF_INFCOMPLEMENTAR = DEV_INFCOMPLEMENTAR '+
    ' ,OMF_NUMERORPA = NULL '+
    ' ,OMF_PLANOCONTARATEIO = NULL '+
    ' ,OMF_CHAVEACESSO = DEV_CHAVEACESSO '+
    ' ,OMF_OBSERVACAO = DEV_OBSERVACAO '+
    ' ,OMF_FINANCEIRO = ' + QuotedStr('N') + ' '+
    ' ,OMF_PROCESSADO = '+
    '  CASE '+
    '    WHEN LEN(DEV_PROCESSADO) = 0 THEN ' + QuotedStr('S') + ' '+
    '    ELSE DEV_PROCESSADO '+
    '  END '+
    ' ,OMF_LIVROFISCAL = '+
    '  CASE '+
    '    WHEN LEN(DEV_LIVROFISCAL) = 0 THEN ' + QuotedStr('S') + ' '+
    '    ELSE DEV_LIVROFISCAL '+
    '  END '+
    ' ,OMF_CANCELADA = '+
    '  CASE '+
    '    WHEN LEN(DEV_CANCELADA) = 0 THEN ' + QuotedStr('N') + ' '+
    '    ELSE DEV_CANCELADA '+
    '  END '+
    ' ,OMF_INTEGRACAO = ' + QuotedStr('DVN') + ' + CAST(DEV_ID AS VARCHAR) '+
    ' ,OMF_DATAALTERACAO = DEV_DATAALTERACAO '+
    ' ,FAT_NOTAFISCAL = NULL '+
    ' ,FAT_SERIE = NULL '+
    ' ,OMF_CHAVEREFERENCIANFE = DEV_CHAVEREFERENCIANFE '+
    ' ,OMF_FINALIDADE = DEV_FINALIDADE '+
    ' ,OMF_ES = ' + QuotedStr('E') + ' '+
    ' ,OMF_ESPECIEVOLUMES = DEV_ESPECIEVOLUMES '+
    ' ,OMF_NUMERACAOVOLUMES = DEV_NUMERACAOVOLUMES '+
    ' ,OMF_TOTALNUMEROVOLUMES = DEV_TOTALNUMEROVOLUMES '+
    ' ,OMF_MARCAVOLUMES = DEV_MARCAVOLUMES '+
    ' ,OMF_ID_OLD = 0 '+
    ' ,OMF_INTEGRACAO_OLD = ' + QuotedStr('') + ' '+
    ' ,VND_CODIGO '+
    ' ,TRP_CODIGO '+
    ' ,OMF_TOTALCOMISSAO = DEV_TOTALCOMISSAO '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTO = DEV_TOTALAPROXIMADOIMPOSTO '+
    ' ,OMF_PERCENTUALDESCTO = (DEV_PERCENTUALFINANCEIROPRAZO + DEV_PERCENTUALDESCONTOPRAZO + DEV_PERCENTUALDESCTOAVULSO) '+
    ' ,OMF_PERCENTUALIBPT = DEV_PERCENTUALIBPT '+
    ' ,USERS_LOGIN '+
    ' ,OMF_PERCENTUALCOMISSAO = DEV_PERCENTUALCOMISSAO '+
    ' ,OMF_TOTALBASECALCULOCOMISSAO = DEV_TOTALBASECALCULOCOMISSAO '+
    ' ,OMF_TOTALIBPTMUNICIPAL = DEV_TOTALIBPTMUNICIPAL '+
    ' ,OMF_TOTALIBPTESTADUAL = DEV_TOTALIBPTESTADUAL '+
    ' ,OMF_TOTALIBPTNACIONAL = DEV_TOTALIBPTNACIONAL '+
    ' ,OMF_TOTALIBPTIMPORTADO = DEV_TOTALIBPTIMPORTADO '+
    ' ,OMF_PERCENTUALIBPTMUNICIPAL = DEV_PERCENTUALIBPTMUNICIPAL '+
    ' ,OMF_PERCENTUALIBPTESTADUAL = DEV_PERCENTUALIBPTESTADUAL '+
    ' ,OMF_PERCENTUALIBPTNACIONAL = DEV_PERCENTUALIBPTNACIONAL '+
    ' ,OMF_PERCENTUALIBPTIMPORTADO = DEV_PERCENTUALIBPTIMPORTADO '+
    ' ,CON_CODIGO '+
    ' ,OMF_TOTALBASECALCULOFCP = DEV_TOTALBASECALCULOFCP '+
    ' ,OMF_TOTALFCP = DEV_TOTALFCP '+
    ' ,OMF_TOTALBASECALCULOFCPST = DEV_TOTALBASECALCULOFCPST '+
    ' ,OMF_TOTALFCPST = DEV_TOTALFCPST '+
    ' ,OMF_TOTALBASECALCULOFCPRET = DEV_TOTALBASECALCULOFCPRET '+
    ' ,OMF_TOTALFCPRET = DEV_TOTALFCPRET '+
    ' ,DEV_ID_OLD = DEV_ID '+
    ' ,DEV_ID = DEV_ID '+
    ' ,OMF_TIPOLIGACAO = NULL '+
    ' ,OMF_GRUPOTENSAO = NULL '+
    ' FROM DEV_00 '+
    ' WHERE DEV_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_01', ' SELECT OMF_01_ID = SSE_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = SSE_ID '+
    ' ,DEV_ID = NULL '+
    ' ,DEV_01_ID = NULL '+
    ' ,DEV_NOTAFISCAL = NULL '+
    ' ,SSE_00_01.PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,LEE_CODIGO = NULL '+
    ' ,GAI_CODIGO = NULL '+
    ' ,CLF_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTC_CODIGO '+
    ' ,OMF_ORDEMITEM = SSE_ORDEMITEM '+
    ' ,OMF_QTDFATURADA = SSE_QTDFATURADA '+
    ' ,OMF_QTDDEVOLVIDA = 0 '+
    ' ,OMF_ITEMALTERADO = NULL '+
    ' ,OMF_VALORITEM = SSE_PRECODIGITADO '+
    ' ,OMF_VALORIPIITEM = SSE_VALORIPIITEM '+
    ' ,OMF_VALORPISITEM = SSE_VALORPISITEM '+
    ' ,OMF_VALORICMSITEM = SSE_VALORICMSITEM '+
    ' ,OMF_VALORVERBAITEM = 0 '+
    ' ,OMF_VALORCOFINSITEM = SSE_VALORCOFINSITEM '+
    ' ,OMF_VALORSEGUROITEM = SSE_VALORSEGUROITEM '+
    ' ,OMF_VALORSERVICOITEM = SSE_VALORSERVICOITEM '+
    ' ,OMF_VALORDESCTOITEM = SSE_VALORDESCTOITEM '+
    ' ,OMF_VALORICMSRNFITEM = SSE_VALORICMSRITEM '+
    ' ,OMF_VALORFRETENFITEM = SSE_VALORFRETEITEM '+
    ' ,OMF_VALORFRETERPAITEM = 0 '+
    ' ,OMF_VALORICMSRDUAITEM = 0 '+
    ' ,OMF_VALORADICIONALITEM = 0 '+
    ' ,OMF_VALORFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSSIMPLESITEM = 0 '+
    ' ,OMF_VALORBONIFICACAOITEM = 0 '+
    ' ,OMF_VALORBASEOUTROSITEM = SSE_VALORBASEOUTROSITEM '+
    ' ,OMF_VALORICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORDESPACESSORIAITEM = SSE_VALORDESPACESSORIAITEM '+
    ' ,OMF_VALORSUBSTRIBUTARIAITEM = SSE_VALORSUBSTRIBUTARIAITEM '+
    ' ,OMF_VALORBASEISENTOICMSITEM = SSE_VALORBASEISENTOICMSITEM '+
    ' ,OMF_VALORBASECALCULOMVAITEM = SSE_VALORBASECALCULOMVAITEM '+
    ' ,OMF_VALORBASECALCULOICMSITEM = SSE_VALORBASECALCULOICMSITEM '+
    ' ,OMF_VALORCOMPLEMENTONFICMSITEM = SSE_VALORCOMPLEMENTONFICMSITEM '+
    ' ,OMF_PERCENTUALIPIITEM = SSE_PERCENTUALIPIITEM '+
    ' ,OMF_PERCENTUALPISITEM = SSE_PERCENTUALPISITEM '+
    ' ,OMF_PERCENTUALMVAITEM = SSE_PERCENTUALMVAITEM '+
    ' ,OMF_PERCENTUALICMSITEM = SSE_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALCOFINSITEM = SSE_PERCENTUALCOFINSITEM '+
    ' ,OMF_PERCENTUALVERBAITEM = 0 '+
    ' ,OMF_PERCENTUALDESCTOITEM = SSE_PERCENTUALDESCTOITEM '+
    ' ,OMF_PERCENTUALICMSRNFITEM = 0 '+
    ' ,OMF_PERCENTUALSERVICOITEM = SSE_PERCENTUALSERVICOITEM '+
    ' ,OMF_PERCENTUALSEGUROITEM = SSE_PERCENTUALSEGUROITEM '+
    ' ,OMF_PERCENTUALFRETENFITEM = SSE_PERCENTUALFRETEITEM '+
    ' ,OMF_PERCBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALICMSRDUAITEM = 0 '+
    ' ,OMF_PERCENTUALFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALFRETERPAITEM = 0 '+
    ' ,OMF_PERCENTUALICMSSAIDAITEM = SSE_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALREDUCAOBCITEM = SSE_PERCENTUALREDUCAOBCITEM '+
    ' ,OMF_PERCENTUALICMSSIMPLESITEM = 0 '+
    ' ,OMF_PERCENTUALICMSDESTINOITEM = SSE_PERCENTUALICMSDESTINOITEM '+
    ' ,OMF_PERCENTUALBONIFICACAOITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENFITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALDESPACESSORIAITEM = SSE_PERCENTUALDESPACESSORIAITEM '+
    ' ,OMF_PERCENTUALICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAOMF = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOOMF = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOOMF = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_VALORBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORBCICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORBCALCULOPISCOFINSITEM = SSE_VALORBASECALCULOPISITEM '+
    ' ,OMF_ULTIMOCUSTOCOMPRA = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIO = 0 '+
    ' ,OMF_ULTIMOCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_PRECOZEROMKP = 0 '+
    ' ,OMF_PRECOVENDAMKP = 0 '+
    ' ,OMF_PRECOSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROVENDAMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALDESPESASLUCROMKP = 0 '+
    ' ,OMF_PERCENTUALMARKUPLUCRO = 0 '+
    ' ,OMF_PERCENTUALMARKUPZERO = 0 '+
    ' ,OMF_PERCENTUALICMSMARKUP = 0 '+
    ' ,OMF_TOTALITEM = SSE_TOTALPRECODIGITADO '+
    ' ,OMF_TOTALIPIITEM = SSE_TOTALIPIITEM '+
    ' ,OMF_TOTALPISITEM = SSE_TOTALPISITEM '+
    ' ,OMF_TOTALICMSITEM = SSE_TOTALICMSITEM '+
    ' ,OMF_TOTALVERBAITEM = 0 '+
    ' ,OMF_TOTALCOFINSITEM = SSE_TOTALCOFINSITEM '+
    ' ,OMF_TOTALSEGUROITEM = SSE_TOTALSEGUROITEM '+
    ' ,OMF_TOTALSERVICOITEM = SSE_TOTALSERVICOITEM '+
    ' ,OMF_TOTALDESCTOITEM = SSE_TOTALDESCTOITEM '+
    ' ,OMF_TOTALICMSRNFITEM = SSE_TOTALICMSRITEM '+
    ' ,OMF_TOTALFRETENFITEM = SSE_TOTALFRETEITEM '+
    ' ,OMF_TOTALFRETERPAITEM = 0 '+
    ' ,OMF_TOTALICMSRDUAITEM = 0 '+
    ' ,OMF_TOTALADICIONALITEM = 0 '+
    ' ,OMF_TOTALFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSSIMPLESITEM = 0 '+
    ' ,OMF_TOTALBONIFICACAOITEM = 0 '+
    ' ,OMF_TOTALBASEOUTROSITEM = SSE_TOTALBASEOUTROSITEM '+
    ' ,OMF_TOTALICMSFRETENFITEM = 0 '+
    ' ,OMF_TOTALICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSACESSORIAITEM = 0 '+
    ' ,OMF_TOTALDESPACESSORIAITEM = SSE_TOTALDESPACESSORIAITEM '+
    ' ,OMF_TOTALSUBSTRIBUTARIAITEM = SSE_TOTALSUBSTRIBUTARIAITEM '+
    ' ,OMF_TOTALBASEISENTOICMSITEM = SSE_TOTALBASEISENTOICMSITEM '+
    ' ,OMF_TOTALBASECALCULOMVAITEM = SSE_TOTALBASECALCULOMVAITEM '+
    ' ,OMF_TOTALBASECALCULOICMSITEM = SSE_TOTALBASECALCULOICMSITEM '+
    ' ,OMF_TOTALCOMPLEMENTONFICMSITEM = SSE_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,OMF_TOTALBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALBCALCULOPISCOFINSITEM = SSE_TOTALBASECALCULOPISITEM '+
    ' ,OMF_TOTALBCICMSFRETENFITEM = 0 '+
    ' ,OMF_RATEADO = '+ QuotedStr('N') + ' '+
    ' ,OMF_DATAALTERACAO = SSE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = '+ QuotedStr('SSE') + ' + CAST(SSE_ID AS VARCHAR) '+
    ' ,OMF_NUMEROVOLUMES = SSE_NUMEROVOLUMES '+
    ' ,OMF_PESOBRUTOITEM = SSE_PESOBRUTOITEM '+
    ' ,OMF_PESOLIQUIDOITEM = SSE_PESOLIQUIDOITEM '+
    ' ,OMF_01_ID_OLD = 0 '+
    ' ,OMF_ID_OLD = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_01_ID_OLD = 0 '+
    ' ,OMF_TIPODOCTO = '+ QuotedStr('DVN') + ' '+
    ' ,OMF_PERCENTUALCOMISSAOITEM = NULL '+
    ' ,OMF_VALORBASECALCULOPISCOFINSITEM = SSE_VALORBASECALCULOCOFINSITEM '+
    ' ,OMF_TOTALBASECALCULOPISCOFINSITEM = SSE_TOTALBASECALCULOPISITEM '+
    ' ,OMF_VALORBASEDESCTOCOMISSAOITEM = NULL '+
    ' ,OMF_VALORCOMISSAOITEM = NULL '+
    ' ,OMF_TOTALCOMISSAOITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTESTADUALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTNACIONALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_TOTALIBPTESTADUALITEM = NULL '+
    ' ,OMF_TOTALIBPTNACIONALITEM = NULL '+
    ' ,OMF_TOTALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTOITEM = NULL '+
    ' ,OMF_PERCENTUALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPITEM = NULL '+
    ' ,OMF_TOTALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPSTITEM = NULL '+
    ' ,OMF_TOTALFCPSTITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPRETITEM = NULL '+
    ' ,OMF_TOTALFCPRETITEM = NULL '+
    ' ,FAT_ID = NULL '+
    ' ,FAT_01_ID = NULL '+
    'FROM SSE_00_01 '+
    'LEFT JOIN PRO_00 '+
    '  ON PRO_00.PRO_CODIGO = SSE_00_01.PRO_CODIGO '+
    ' WHERE SSE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_01_ID = SEE_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = SEE_ID '+
    ' ,DEV_ID = NULL '+
    ' ,DEV_01_ID = NULL '+
    ' ,DEV_NOTAFISCAL = NULL '+
    ' ,SEE_00_01.PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,LEE_CODIGO = NULL '+
    ' ,GAI_CODIGO = NULL '+
    ' ,CLF_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,OMF_ORDEMITEM = SEE_ORDEMITEM '+
    ' ,OMF_QTDFATURADA = SEE_QTDENTRADA '+
    ' ,OMF_QTDDEVOLVIDA = 0 '+
    ' ,OMF_ITEMALTERADO = NULL '+
    ' ,OMF_VALORITEM = SEE_PRECODIGITADO '+
    ' ,OMF_VALORIPIITEM = SEE_VALORIPIITEM '+
    ' ,OMF_VALORPISITEM = SEE_VALORPISITEM '+
    ' ,OMF_VALORICMSITEM = SEE_VALORICMSITEM '+
    ' ,OMF_VALORVERBAITEM = 0 '+
    ' ,OMF_VALORCOFINSITEM = SEE_VALORCOFINSITEM '+
    ' ,OMF_VALORSEGUROITEM = SEE_VALORSEGUROITEM '+
    ' ,OMF_VALORSERVICOITEM = SEE_VALORSERVICOITEM '+
    ' ,OMF_VALORDESCTOITEM = SEE_VALORDESCTOITEM '+
    ' ,OMF_VALORICMSRNFITEM = SEE_VALORICMSRITEM '+
    ' ,OMF_VALORFRETENFITEM = SEE_VALORFRETEITEM '+
    ' ,OMF_VALORFRETERPAITEM = 0 '+
    ' ,OMF_VALORICMSRDUAITEM = 0 '+
    ' ,OMF_VALORADICIONALITEM = 0 '+
    ' ,OMF_VALORFRETECTRITEM = SEE_VALORFRETECTRITEM '+
    ' ,OMF_VALORICMSSIMPLESITEM = 0 '+
    ' ,OMF_VALORBONIFICACAOITEM = 0 '+
    ' ,OMF_VALORBASEOUTROSITEM = SEE_VALORBASEOUTROSITEM '+
    ' ,OMF_VALORICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORDESPACESSORIAITEM = SEE_VALORDESPACESSORIAITEM '+
    ' ,OMF_VALORSUBSTRIBUTARIAITEM = SEE_VALORSUBSTRIBUTARIAITEM '+
    ' ,OMF_VALORBASEISENTOICMSITEM = SEE_VALORBASEISENTOICMSITEM '+
    ' ,OMF_VALORBASECALCULOMVAITEM = SEE_VALORBASECALCULOMVAITEM '+
    ' ,OMF_VALORBASECALCULOICMSITEM = SEE_VALORBASECALCULOICMSITEM '+
    ' ,OMF_VALORCOMPLEMENTONFICMSITEM = SEE_VALORCOMPLEMENTONFICMSITEM '+
    ' ,OMF_PERCENTUALIPIITEM = SEE_PERCENTUALIPIITEM '+
    ' ,OMF_PERCENTUALPISITEM = SEE_PERCENTUALPISITEM '+
    ' ,OMF_PERCENTUALMVAITEM = SEE_PERCENTUALMVAITEM '+
    ' ,OMF_PERCENTUALICMSITEM = SEE_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALCOFINSITEM = SEE_PERCENTUALCOFINSITEM '+
    ' ,OMF_PERCENTUALVERBAITEM = 0 '+
    ' ,OMF_PERCENTUALDESCTOITEM = SEE_PERCENTUALDESCTOITEM '+
    ' ,OMF_PERCENTUALICMSRNFITEM = 0 '+
    ' ,OMF_PERCENTUALSERVICOITEM = SEE_PERCENTUALSERVICOITEM '+
    ' ,OMF_PERCENTUALSEGUROITEM = SEE_PERCENTUALSEGUROITEM '+
    ' ,OMF_PERCENTUALFRETENFITEM = SEE_PERCENTUALFRETEITEM '+
    ' ,OMF_PERCBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALICMSRDUAITEM = 0 '+
    ' ,OMF_PERCENTUALFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALFRETERPAITEM = 0 '+
    ' ,OMF_PERCENTUALICMSSAIDAITEM = SEE_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALREDUCAOBCITEM = SEE_PERCENTUALREDUCAOBCITEM '+
    ' ,OMF_PERCENTUALICMSSIMPLESITEM = 0 '+
    ' ,OMF_PERCENTUALICMSDESTINOITEM = SEE_PERCENTUALICMSDESTINOITEM '+
    ' ,OMF_PERCENTUALBONIFICACAOITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENFITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALDESPACESSORIAITEM = SEE_PERCENTUALDESPACESSORIAITEM '+
    ' ,OMF_PERCENTUALICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAOMF = SEE_VALORCUSTOCOMPRAMEDIO '+
    ' ,OMF_VALORCUSTOLIQUIDOOMF = SEE_VALORCUSTOLIQUIDOMEDIO '+
    ' ,OMF_VALORCUSTOINVENTARIOOMF = SEE_VALORCUSTOINVENTARIOMEDIO '+
    ' ,OMF_VALORCUSTOCOMPRAMEDIO = SEE_VALORCUSTOCOMPRAMEDIO '+
    ' ,OMF_VALORCUSTOLIQUIDOMEDIO = SEE_VALORCUSTOLIQUIDOMEDIO '+
    ' ,OMF_VALORCUSTOINVENTARIOMEDIO = SEE_VALORCUSTOINVENTARIOMEDIO '+
    ' ,OMF_VALORBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORBCICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORBCALCULOPISCOFINSITEM = SEE_VALORBASECALCULOPISITEM '+
    ' ,OMF_ULTIMOCUSTOCOMPRA = SEE_ULTIMOCUSTOCOMPRAMEDIO '+
    ' ,OMF_ULTIMOCUSTOLIQUIDO = SEE_ULTIMOCUSTOLIQUIDOMEDIO '+
    ' ,OMF_ULTIMOCUSTOINVENTARIO = SEE_ULTIMOCUSTOINVENTARIOMEDIO '+
    ' ,OMF_ULTIMOCUSTOCOMPRAMEDIO = SEE_ULTIMOCUSTOCOMPRAMEDIO '+
    ' ,OMF_ULTIMOCUSTOLIQUIDOMEDIO = SEE_ULTIMOCUSTOLIQUIDOMEDIO '+
    ' ,OMF_ULTIMOCUSTOINVENTARIOMEDIO = SEE_ULTIMOCUSTOINVENTARIOMEDIO '+
    ' ,OMF_PRECOZEROMKP = 0 '+
    ' ,OMF_PRECOVENDAMKP = 0 '+
    ' ,OMF_PRECOSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROVENDAMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALDESPESASLUCROMKP = 0 '+
    ' ,OMF_PERCENTUALMARKUPLUCRO = 0 '+
    ' ,OMF_PERCENTUALMARKUPZERO = 0 '+
    ' ,OMF_PERCENTUALICMSMARKUP = 0 '+
    ' ,OMF_TOTALITEM = SEE_TOTALPRECODIGITADO '+
    ' ,OMF_TOTALIPIITEM = SEE_TOTALIPIITEM '+
    ' ,OMF_TOTALPISITEM = SEE_TOTALPISITEM '+
    ' ,OMF_TOTALICMSITEM = SEE_TOTALICMSITEM '+
    ' ,OMF_TOTALVERBAITEM = 0 '+
    ' ,OMF_TOTALCOFINSITEM = SEE_TOTALCOFINSITEM '+
    ' ,OMF_TOTALSEGUROITEM = SEE_TOTALSEGUROITEM '+
    ' ,OMF_TOTALSERVICOITEM = SEE_TOTALSERVICOITEM '+
    ' ,OMF_TOTALDESCTOITEM = SEE_TOTALDESCTOITEM '+
    ' ,OMF_TOTALICMSRNFITEM = SEE_TOTALICMSRITEM '+
    ' ,OMF_TOTALFRETENFITEM = SEE_TOTALFRETEITEM '+
    ' ,OMF_TOTALFRETERPAITEM = 0 '+
    ' ,OMF_TOTALICMSRDUAITEM = 0 '+
    ' ,OMF_TOTALADICIONALITEM = 0 '+
    ' ,OMF_TOTALFRETECTRITEM = SEE_TOTALFRETECTRITEM '+
    ' ,OMF_TOTALICMSSIMPLESITEM = 0 '+
    ' ,OMF_TOTALBONIFICACAOITEM = 0 '+
    ' ,OMF_TOTALBASEOUTROSITEM = SEE_TOTALBASEOUTROSITEM '+
    ' ,OMF_TOTALICMSFRETENFITEM = 0 '+
    ' ,OMF_TOTALICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSACESSORIAITEM = 0 '+
    ' ,OMF_TOTALDESPACESSORIAITEM = SEE_TOTALDESPACESSORIAITEM '+
    ' ,OMF_TOTALSUBSTRIBUTARIAITEM = SEE_TOTALSUBSTRIBUTARIAITEM '+
    ' ,OMF_TOTALBASEISENTOICMSITEM = SEE_TOTALBASEISENTOICMSITEM '+
    ' ,OMF_TOTALBASECALCULOMVAITEM = SEE_TOTALBASECALCULOMVAITEM '+
    ' ,OMF_TOTALBASECALCULOICMSITEM = SEE_TOTALBASECALCULOICMSITEM '+
    ' ,OMF_TOTALCOMPLEMENTONFICMSITEM = SEE_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,OMF_TOTALBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALBCALCULOPISCOFINSITEM = SEE_TOTALBASECALCULOPISITEM '+
    ' ,OMF_TOTALBCICMSFRETENFITEM = 0 '+
    ' ,OMF_RATEADO = NULL '+
    ' ,OMF_DATAALTERACAO = SEE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = '+ QuotedStr('SEE') + ' + CAST(SEE_ID AS VARCHAR) '+
    ' ,OMF_NUMEROVOLUMES = SEE_NUMEROVOLUMES '+
    ' ,OMF_PESOBRUTOITEM = SEE_PESOBRUTOITEM '+
    ' ,OMF_PESOLIQUIDOITEM = SEE_PESOLIQUIDOITEM '+
    ' ,OMF_01_ID_OLD = 0 '+
    ' ,OMF_ID_OLD = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_01_ID_OLD = 0 '+
    ' ,OMF_TIPODOCTO = '+ QuotedStr('DVN') + ' '+
    ' ,OMF_PERCENTUALCOMISSAOITEM = NULL '+
    ' ,OMF_VALORBASECALCULOPISCOFINSITEM = SEE_VALORBASECALCULOCOFINSITEM '+
    ' ,OMF_TOTALBASECALCULOPISCOFINSITEM = SEE_TOTALBASECALCULOPISITEM '+
    ' ,OMF_VALORBASEDESCTOCOMISSAOITEM = NULL '+
    ' ,OMF_VALORCOMISSAOITEM = NULL '+
    ' ,OMF_TOTALCOMISSAOITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTESTADUALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTNACIONALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_TOTALIBPTESTADUALITEM = NULL '+
    ' ,OMF_TOTALIBPTNACIONALITEM = NULL '+
    ' ,OMF_TOTALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTOITEM = NULL '+
    ' ,OMF_PERCENTUALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPITEM = NULL '+
    ' ,OMF_TOTALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPSTITEM = NULL '+
    ' ,OMF_TOTALFCPSTITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPRETITEM = NULL '+
    ' ,OMF_TOTALFCPRETITEM = NULL '+
    ' ,FAT_ID = NULL '+
    ' ,FAT_01_ID = NULL '+
    ' FROM SEE_00_01 '+
    ' LEFT JOIN PRO_00 '+
    '  ON PRO_00.PRO_CODIGO = SEE_00_01.PRO_CODIGO '+
    ' WHERE SEE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_01_ID = ONE_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = ONE_ID '+
    ' ,DEV_ID = NULL '+
    ' ,DEV_01_ID = NULL '+
    ' ,DEV_NOTAFISCAL = NULL '+
    ' ,ONE_00_01.PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,LEE_CODIGO = NULL '+
    ' ,GAI_CODIGO = NULL '+
    ' ,CLF_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,GRD_CODIGO = NULL '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,OMF_ORDEMITEM = ONE_ORDEMITEM '+
    ' ,OMF_QTDFATURADA = ONE_QTDENTRADA '+
    ' ,OMF_QTDDEVOLVIDA = 0 '+
    ' ,OMF_ITEMALTERADO = NULL '+
    ' ,OMF_VALORITEM = ONE_PRECODIGITADO '+
    ' ,OMF_VALORIPIITEM = ONE_VALORIPIITEM '+
    ' ,OMF_VALORPISITEM = ONE_VALORPISITEM '+
    ' ,OMF_VALORICMSITEM = ONE_VALORICMSITEM '+
    ' ,OMF_VALORVERBAITEM = 0 '+
    ' ,OMF_VALORCOFINSITEM = ONE_VALORCOFINSITEM '+
    ' ,OMF_VALORSEGUROITEM = ONE_VALORSEGUROITEM '+
    ' ,OMF_VALORSERVICOITEM = ONE_VALORSERVICOITEM '+
    ' ,OMF_VALORDESCTOITEM = ONE_VALORDESCTOITEM '+
    ' ,OMF_VALORICMSRNFITEM = ONE_VALORICMSRITEM '+
    ' ,OMF_VALORFRETENFITEM = ONE_VALORFRETEITEM '+
    ' ,OMF_VALORFRETERPAITEM = 0 '+
    ' ,OMF_VALORICMSRDUAITEM = 0 '+
    ' ,OMF_VALORADICIONALITEM = 0 '+
    ' ,OMF_VALORFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSSIMPLESITEM = 0 '+
    ' ,OMF_VALORBONIFICACAOITEM = 0 '+
    ' ,OMF_VALORBASEOUTROSITEM = ONE_VALORBASEOUTROSITEM '+
    ' ,OMF_VALORICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORDESPACESSORIAITEM = ONE_VALORDESPACESSORIAITEM '+
    ' ,OMF_VALORSUBSTRIBUTARIAITEM = ONE_VALORSUBSTRIBUTARIAITEM '+
    ' ,OMF_VALORBASEISENTOICMSITEM = ONE_VALORBASEISENTOICMSITEM '+
    ' ,OMF_VALORBASECALCULOMVAITEM = ONE_VALORBASECALCULOMVAITEM '+
    ' ,OMF_VALORBASECALCULOICMSITEM = ONE_VALORBASECALCULOICMSITEM '+
    ' ,OMF_VALORCOMPLEMENTONFICMSITEM = ONE_VALORCOMPLEMENTONFICMSITEM '+
    ' ,OMF_PERCENTUALIPIITEM = ONE_PERCENTUALIPIITEM '+
    ' ,OMF_PERCENTUALPISITEM = ONE_PERCENTUALPISITEM '+
    ' ,OMF_PERCENTUALMVAITEM = ONE_PERCENTUALMVAITEM '+
    ' ,OMF_PERCENTUALICMSITEM = ONE_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALCOFINSITEM = ONE_PERCENTUALCOFINSITEM '+
    ' ,OMF_PERCENTUALVERBAITEM = 0 '+
    ' ,OMF_PERCENTUALDESCTOITEM = ONE_PERCENTUALDESCTOITEM '+
    ' ,OMF_PERCENTUALICMSRNFITEM = 0 '+
    ' ,OMF_PERCENTUALSERVICOITEM = ONE_PERCENTUALSERVICOITEM '+
    ' ,OMF_PERCENTUALSEGUROITEM = ONE_PERCENTUALSEGUROITEM '+
    ' ,OMF_PERCENTUALFRETENFITEM = ONE_PERCENTUALFRETEITEM '+
    ' ,OMF_PERCBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALICMSRDUAITEM = 0 '+
    ' ,OMF_PERCENTUALFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALFRETERPAITEM = 0 '+
    ' ,OMF_PERCENTUALICMSSAIDAITEM = ONE_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALREDUCAOBCITEM = ONE_PERCENTUALREDUCAOBCITEM '+
    ' ,OMF_PERCENTUALICMSSIMPLESITEM = 0 '+
    ' ,OMF_PERCENTUALICMSDESTINOITEM = ONE_PERCENTUALICMSDESTINOITEM '+
    ' ,OMF_PERCENTUALBONIFICACAOITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENFITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALDESPACESSORIAITEM = ONE_PERCENTUALDESPACESSORIAITEM '+
    ' ,OMF_PERCENTUALICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAOMF = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOOMF = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOOMF = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_VALORBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORBCICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORBCALCULOPISCOFINSITEM = ONE_VALORBASECALCULOPISITEM '+
    ' ,OMF_ULTIMOCUSTOCOMPRA = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIO = 0 '+
    ' ,OMF_ULTIMOCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_PRECOZEROMKP = 0 '+
    ' ,OMF_PRECOVENDAMKP = 0 '+
    ' ,OMF_PRECOSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROVENDAMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALDESPESASLUCROMKP = 0 '+
    ' ,OMF_PERCENTUALMARKUPLUCRO = 0 '+
    ' ,OMF_PERCENTUALMARKUPZERO = 0 '+
    ' ,OMF_PERCENTUALICMSMARKUP = 0 '+
    ' ,OMF_TOTALITEM = ONE_TOTALPRECODIGITADO '+
    ' ,OMF_TOTALIPIITEM = ONE_TOTALIPIITEM '+
    ' ,OMF_TOTALPISITEM = ONE_TOTALPISITEM '+
    ' ,OMF_TOTALICMSITEM = ONE_TOTALICMSITEM '+
    ' ,OMF_TOTALVERBAITEM = 0 '+
    ' ,OMF_TOTALCOFINSITEM = ONE_TOTALCOFINSITEM '+
    ' ,OMF_TOTALSEGUROITEM = ONE_TOTALSEGUROITEM '+
    ' ,OMF_TOTALSERVICOITEM = ONE_TOTALSERVICOITEM '+
    ' ,OMF_TOTALDESCTOITEM = ONE_TOTALDESCTOITEM '+
    ' ,OMF_TOTALICMSRNFITEM = ONE_TOTALICMSRITEM '+
    ' ,OMF_TOTALFRETENFITEM = ONE_TOTALFRETEITEM '+
    ' ,OMF_TOTALFRETERPAITEM = 0 '+
    ' ,OMF_TOTALICMSRDUAITEM = 0 '+
    ' ,OMF_TOTALADICIONALITEM = 0 '+
    ' ,OMF_TOTALFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSSIMPLESITEM = 0 '+
    ' ,OMF_TOTALBONIFICACAOITEM = 0 '+
    ' ,OMF_TOTALBASEOUTROSITEM = ONE_TOTALBASEOUTROSITEM '+
    ' ,OMF_TOTALICMSFRETENFITEM = 0 '+
    ' ,OMF_TOTALICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSACESSORIAITEM = 0 '+
    ' ,OMF_TOTALDESPACESSORIAITEM = ONE_TOTALDESPACESSORIAITEM '+
    ' ,OMF_TOTALSUBSTRIBUTARIAITEM = ONE_TOTALSUBSTRIBUTARIAITEM '+
    ' ,OMF_TOTALBASEISENTOICMSITEM = ONE_TOTALBASEISENTOICMSITEM '+
    ' ,OMF_TOTALBASECALCULOMVAITEM = ONE_TOTALBASECALCULOMVAITEM '+
    ' ,OMF_TOTALBASECALCULOICMSITEM = ONE_TOTALBASECALCULOICMSITEM '+
    ' ,OMF_TOTALCOMPLEMENTONFICMSITEM = ONE_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,OMF_TOTALBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALBCALCULOPISCOFINSITEM = ONE_TOTALBASECALCULOPISITEM '+
    ' ,OMF_TOTALBCICMSFRETENFITEM = 0 '+
    ' ,OMF_RATEADO = NULL '+
    ' ,OMF_DATAALTERACAO = ONE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = '+ QuotedStr('ONE') + ' + CAST(ONE_ID AS VARCHAR) '+
    ' ,OMF_NUMEROVOLUMES = ONE_NUMEROVOLUMES '+
    ' ,OMF_PESOBRUTOITEM = ONE_PESOBRUTOITEM '+
    ' ,OMF_PESOLIQUIDOITEM = ONE_PESOLIQUIDOITEM '+
    ' ,OMF_01_ID_OLD = 0 '+
    ' ,OMF_ID_OLD = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_01_ID_OLD = 0 '+
    ' ,OMF_TIPODOCTO = '+ QuotedStr('DVN') + ' '+
    ' ,OMF_PERCENTUALCOMISSAOITEM = NULL '+
    ' ,OMF_VALORBASECALCULOPISCOFINSITEM = ONE_VALORBASECALCULOCOFINSITEM '+
    ' ,OMF_TOTALBASECALCULOPISCOFINSITEM = ONE_TOTALBASECALCULOPISITEM '+
    ' ,OMF_VALORBASEDESCTOCOMISSAOITEM = NULL '+
    ' ,OMF_VALORCOMISSAOITEM = NULL '+
    ' ,OMF_TOTALCOMISSAOITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTESTADUALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTNACIONALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_TOTALIBPTESTADUALITEM = NULL '+
    ' ,OMF_TOTALIBPTNACIONALITEM = NULL '+
    ' ,OMF_TOTALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTOITEM = NULL '+
    ' ,OMF_PERCENTUALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPITEM = NULL '+
    ' ,OMF_TOTALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPSTITEM = NULL '+
    ' ,OMF_TOTALFCPSTITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPRETITEM = NULL '+
    ' ,OMF_TOTALFCPRETITEM = NULL '+
    ' ,FAT_ID = NULL '+
    ' ,FAT_01_ID = NULL '+
    ' FROM ONE_00_01 '+
    ' LEFT JOIN PRO_00 '+
    '  ON PRO_00.PRO_CODIGO = ONE_00_01.PRO_CODIGO '+
    ' WHERE ONE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_01_ID = ONS_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = ONS_ID '+
    ' ,DEV_ID = NULL '+
    ' ,DEV_01_ID = NULL '+
    ' ,DEV_NOTAFISCAL = NULL '+
    ' ,ONS_00_01.PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,LEE_CODIGO = NULL '+
    ' ,GAI_CODIGO = NULL '+
    ' ,CLF_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTP_CODIGO '+
    ' ,OMF_ORDEMITEM = ONS_ORDEMITEM '+
    ' ,OMF_QTDFATURADA = ONS_QTDFATURADA '+
    ' ,OMF_QTDDEVOLVIDA = 0 '+
    ' ,OMF_ITEMALTERADO = NULL '+
    ' ,OMF_VALORITEM = ONS_PRECODIGITADO '+
    ' ,OMF_VALORIPIITEM = ONS_VALORIPIITEM '+
    ' ,OMF_VALORPISITEM = ONS_VALORPISITEM '+
    ' ,OMF_VALORICMSITEM = ONS_VALORICMSITEM '+
    ' ,OMF_VALORVERBAITEM = 0 '+
    ' ,OMF_VALORCOFINSITEM = ONS_VALORCOFINSITEM '+
    ' ,OMF_VALORSEGUROITEM = ONS_VALORSEGUROITEM '+
    ' ,OMF_VALORSERVICOITEM = ONS_VALORSERVICOITEM '+
    ' ,OMF_VALORDESCTOITEM = ONS_VALORDESCTOITEM '+
    ' ,OMF_VALORICMSRNFITEM = ONS_VALORICMSRITEM '+
    ' ,OMF_VALORFRETENFITEM = ONS_VALORFRETEITEM '+
    ' ,OMF_VALORFRETERPAITEM = 0 '+
    ' ,OMF_VALORICMSRDUAITEM = 0 '+
    ' ,OMF_VALORADICIONALITEM = 0 '+
    ' ,OMF_VALORFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSSIMPLESITEM = 0 '+
    ' ,OMF_VALORBONIFICACAOITEM = 0 '+
    ' ,OMF_VALORBASEOUTROSITEM = ONS_VALORBASEOUTROSITEM '+
    ' ,OMF_VALORICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORDESPACESSORIAITEM = ONS_VALORDESPACESSORIAITEM '+
    ' ,OMF_VALORSUBSTRIBUTARIAITEM = ONS_VALORSUBSTRIBUTARIAITEM '+
    ' ,OMF_VALORBASEISENTOICMSITEM = ONS_VALORBASEISENTOICMSITEM '+
    ' ,OMF_VALORBASECALCULOMVAITEM = ONS_VALORBASECALCULOMVAITEM '+
    ' ,OMF_VALORBASECALCULOICMSITEM = ONS_VALORBASECALCULOICMSITEM '+
    ' ,OMF_VALORCOMPLEMENTONFICMSITEM = ONS_VALORCOMPLEMENTONFICMSITEM '+
    ' ,OMF_PERCENTUALIPIITEM = ONS_PERCENTUALIPIITEM '+
    ' ,OMF_PERCENTUALPISITEM = ONS_PERCENTUALPISITEM '+
    ' ,OMF_PERCENTUALMVAITEM = ONS_PERCENTUALMVAITEM '+
    ' ,OMF_PERCENTUALICMSITEM = ONS_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALCOFINSITEM = ONS_PERCENTUALCOFINSITEM '+
    ' ,OMF_PERCENTUALVERBAITEM = 0 '+
    ' ,OMF_PERCENTUALDESCTOITEM = ONS_PERCENTUALDESCTOITEM '+
    ' ,OMF_PERCENTUALICMSRNFITEM = 0 '+
    ' ,OMF_PERCENTUALSERVICOITEM = ONS_PERCENTUALSERVICOITEM '+
    ' ,OMF_PERCENTUALSEGUROITEM = ONS_PERCENTUALSEGUROITEM '+
    ' ,OMF_PERCENTUALFRETENFITEM = ONS_PERCENTUALFRETEITEM '+
    ' ,OMF_PERCBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALICMSRDUAITEM = 0 '+
    ' ,OMF_PERCENTUALFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALFRETERPAITEM = 0 '+
    ' ,OMF_PERCENTUALICMSSAIDAITEM = ONS_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALREDUCAOBCITEM = ONS_PERCENTUALREDUCAOBCITEM '+
    ' ,OMF_PERCENTUALICMSSIMPLESITEM = 0 '+
    ' ,OMF_PERCENTUALICMSDESTINOITEM = ONS_PERCENTUALICMSDESTINOITEM '+
    ' ,OMF_PERCENTUALBONIFICACAOITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENFITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALDESPACESSORIAITEM = ONS_PERCENTUALDESPACESSORIAITEM '+
    ' ,OMF_PERCENTUALICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAOMF = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOOMF = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOOMF = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_VALORBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORBCICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORBCALCULOPISCOFINSITEM = ONS_VALORBASECALCULOPISITEM '+
    ' ,OMF_ULTIMOCUSTOCOMPRA = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIO = 0 '+
    ' ,OMF_ULTIMOCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_PRECOZEROMKP = 0 '+
    ' ,OMF_PRECOVENDAMKP = 0 '+
    ' ,OMF_PRECOSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROVENDAMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALDESPESASLUCROMKP = 0 '+
    ' ,OMF_PERCENTUALMARKUPLUCRO = 0 '+
    ' ,OMF_PERCENTUALMARKUPZERO = 0 '+
    ' ,OMF_PERCENTUALICMSMARKUP = 0 '+
    ' ,OMF_TOTALITEM = ONS_TOTALPRECODIGITADO '+
    ' ,OMF_TOTALIPIITEM = ONS_TOTALIPIITEM '+
    ' ,OMF_TOTALPISITEM = ONS_TOTALPISITEM '+
    ' ,OMF_TOTALICMSITEM = ONS_TOTALICMSITEM '+
    ' ,OMF_TOTALVERBAITEM = 0 '+
    ' ,OMF_TOTALCOFINSITEM = ONS_TOTALCOFINSITEM '+
    ' ,OMF_TOTALSEGUROITEM = ONS_TOTALSEGUROITEM '+
    ' ,OMF_TOTALSERVICOITEM = ONS_TOTALSERVICOITEM '+
    ' ,OMF_TOTALDESCTOITEM = ONS_TOTALDESCTOITEM '+
    ' ,OMF_TOTALICMSRNFITEM = ONS_TOTALICMSRITEM '+
    ' ,OMF_TOTALFRETENFITEM = ONS_TOTALFRETEITEM '+
    ' ,OMF_TOTALFRETERPAITEM = 0 '+
    ' ,OMF_TOTALICMSRDUAITEM = 0 '+
    ' ,OMF_TOTALADICIONALITEM = 0 '+
    ' ,OMF_TOTALFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSSIMPLESITEM = 0 '+
    ' ,OMF_TOTALBONIFICACAOITEM = 0 '+
    ' ,OMF_TOTALBASEOUTROSITEM = ONS_TOTALBASEOUTROSITEM '+
    ' ,OMF_TOTALICMSFRETENFITEM = 0 '+
    ' ,OMF_TOTALICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSACESSORIAITEM = 0 '+
    ' ,OMF_TOTALDESPACESSORIAITEM = ONS_TOTALDESPACESSORIAITEM '+
    ' ,OMF_TOTALSUBSTRIBUTARIAITEM = ONS_TOTALSUBSTRIBUTARIAITEM '+
    ' ,OMF_TOTALBASEISENTOICMSITEM = ONS_TOTALBASEISENTOICMSITEM '+
    ' ,OMF_TOTALBASECALCULOMVAITEM = ONS_TOTALBASECALCULOMVAITEM '+
    ' ,OMF_TOTALBASECALCULOICMSITEM = ONS_TOTALBASECALCULOICMSITEM '+
    ' ,OMF_TOTALCOMPLEMENTONFICMSITEM = ONS_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,OMF_TOTALBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALBCALCULOPISCOFINSITEM = ONS_TOTALBASECALCULOPISITEM '+
    ' ,OMF_TOTALBCICMSFRETENFITEM = 0 '+
    ' ,OMF_RATEADO = NULL '+
    ' ,OMF_DATAALTERACAO = ONS_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = '+ QuotedStr('ONS') + ' + CAST(ONS_ID AS VARCHAR) '+
    ' ,OMF_NUMEROVOLUMES = ONS_NUMEROVOLUMES '+
    ' ,OMF_PESOBRUTOITEM = ONS_PESOBRUTOITEM '+
    ' ,OMF_PESOLIQUIDOITEM = ONS_PESOLIQUIDOITEM '+
    ' ,OMF_01_ID_OLD = 0 '+
    ' ,OMF_ID_OLD = 0 '+
    ' ,DEV_ID_OLD = 0 '+
    ' ,DEV_01_ID_OLD = 0 '+
    ' ,OMF_TIPODOCTO = '+ QuotedStr('DVN') + ' '+
    ' ,OMF_PERCENTUALCOMISSAOITEM = NULL '+
    ' ,OMF_VALORBASECALCULOPISCOFINSITEM = ONS_VALORBASECALCULOCOFINSITEM '+
    ' ,OMF_TOTALBASECALCULOPISCOFINSITEM = ONS_TOTALBASECALCULOPISITEM '+
    ' ,OMF_VALORBASEDESCTOCOMISSAOITEM = NULL '+
    ' ,OMF_VALORCOMISSAOITEM = NULL '+
    ' ,OMF_TOTALCOMISSAOITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTESTADUALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTNACIONALITEM = NULL '+
    ' ,OMF_PERCENTUALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALIBPTMUNICIPALITEM = NULL '+
    ' ,OMF_TOTALIBPTESTADUALITEM = NULL '+
    ' ,OMF_TOTALIBPTNACIONALITEM = NULL '+
    ' ,OMF_TOTALIBPTIMPORTADOITEM = NULL '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTOITEM = NULL '+
    ' ,OMF_PERCENTUALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPITEM = NULL '+
    ' ,OMF_TOTALFCPITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPSTITEM = NULL '+
    ' ,OMF_TOTALFCPSTITEM = NULL '+
    ' ,OMF_TOTALBASECALCULOFCPRETITEM = NULL '+
    ' ,OMF_TOTALFCPRETITEM = NULL '+
    ' ,FAT_ID = NULL '+
    ' ,FAT_01_ID = NULL '+
    ' FROM ONS_00_01 '+
    ' LEFT JOIN PRO_00 '+
    '  ON PRO_00.PRO_CODIGO = ONS_00_01.PRO_CODIGO '+
    ' WHERE ONS_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    'UNION ALL '+
    ' '+
    'SELECT '+
    '  OMF_01_ID = 0 '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = 0 '+
    ' ,DEV_ID = DEV_ID '+
    ' ,DEV_01_ID = DEV_01_ID '+
    ' ,DEV_NOTAFISCAL = FAT_NOTAFISCAL '+
    ' ,DEV_00_01.PRO_CODIGO '+
    ' ,CST_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,DEV_00_01.NCM_CODIGO '+
    ' ,LEE_CODIGO '+
    ' ,GAI_CODIGO '+
    ' ,CLF_CODIGO = PRO_00.CLF_CODIGO '+
    ' ,DEV_00_01.LEF_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,CSTPC_CODIGO = CSTC_CODIGO '+
    ' ,OMF_ORDEMITEM = DEV_ORDEMITEM '+
    ' ,OMF_QTDFATURADA = DEV_QTDFATURADA '+
    ' ,OMF_QTDDEVOLVIDA = DEV_QTDDEVOLVIDA '+
    ' ,OMF_ITEMALTERADO = '+ QuotedStr('N') + ' '+
    ' ,OMF_VALORITEM = DEV_PRECOLIQUIDO '+
    ' ,OMF_VALORIPIITEM = DEV_VALORIPIITEM '+
    ' ,OMF_VALORPISITEM = DEV_VALORPISITEM '+
    ' ,OMF_VALORICMSITEM = DEV_VALORICMSITEM '+
    ' ,OMF_VALORVERBAITEM = 0 '+
    ' ,OMF_VALORCOFINSITEM = DEV_VALORCOFINSITEM '+
    ' ,OMF_VALORSEGUROITEM = DEV_VALORSEGUROITEM '+
    ' ,OMF_VALORSERVICOITEM = 0 '+
    ' ,OMF_VALORDESCTOITEM = (DEV_VALORDESCTOITEM + DEV_VALORDESCTOPRAZOITEM + DEV_VALORDESCTOAVULSOITEM) '+
    ' ,OMF_VALORICMSRNFITEM = DEV_VALORICMSRITEM '+
    ' ,OMF_VALORFRETENFITEM = DEV_VALORFRETEITEM '+
    ' ,OMF_VALORFRETERPAITEM = 0 '+
    ' ,OMF_VALORICMSRDUAITEM = 0 '+
    ' ,OMF_VALORADICIONALITEM = 0 '+
    ' ,OMF_VALORFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSSIMPLESITEM = 0 '+
    ' ,OMF_VALORBONIFICACAOITEM = 0 '+
    ' ,OMF_VALORBASEOUTROSITEM = DEV_VALORBASEOUTROSITEM '+
    ' ,OMF_VALORICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORDESPACESSORIAITEM = DEV_VALORDESPACESSORIAITEM '+
    ' ,OMF_VALORSUBSTRIBUTARIAITEM = DEV_VALORSUBSTRIBUTARIAITEM '+
    ' ,OMF_VALORBASEISENTOICMSITEM = DEV_VALORBASEISENTOICMSITEM '+
    ' ,OMF_VALORBASECALCULOMVAITEM = DEV_VALORBASECALCULOMVAITEM '+
    ' ,OMF_VALORBASECALCULOICMSITEM = DEV_VALORBASECALCULOICMSITEM '+
    ' ,OMF_VALORCOMPLEMENTONFICMSITEM = DEV_VALORCOMPLEMENTONFICMSITEM '+
    ' ,OMF_PERCENTUALIPIITEM = DEV_PERCENTUALIPIITEM '+
    ' ,OMF_PERCENTUALPISITEM = DEV_PERCENTUALPISITEM '+
    ' ,OMF_PERCENTUALMVAITEM = DEV_PERCENTUALMVAITEM '+
    ' ,OMF_PERCENTUALICMSITEM = DEV_PERCENTUALICMSITEM '+
    ' ,OMF_PERCENTUALCOFINSITEM = DEV_PERCENTUALCOFINSITEM '+
    ' ,OMF_PERCENTUALVERBAITEM = 0 '+
    ' ,OMF_PERCENTUALDESCTOITEM = DEV_PERCENTUALDESCTOITEM '+
    ' ,OMF_PERCENTUALICMSRNFITEM = 0 '+
    ' ,OMF_PERCENTUALSERVICOITEM = 0 '+
    ' ,OMF_PERCENTUALSEGUROITEM = DEV_PERCENTUALSEGUROITEM '+
    ' ,OMF_PERCENTUALFRETENFITEM = DEV_PERCENTUALFRETEITEM '+
    ' ,OMF_PERCBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALICMSRDUAITEM = 0 '+
    ' ,OMF_PERCENTUALFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALFRETERPAITEM = 0 '+
    ' ,OMF_PERCENTUALICMSSAIDAITEM = 0 '+
    ' ,OMF_PERCENTUALREDUCAOBCITEM = DEV_PERCENTUALREDUCAOBCITEM '+
    ' ,OMF_PERCENTUALICMSSIMPLESITEM = 0 '+
    ' ,OMF_PERCENTUALICMSDESTINOITEM = DEV_PERCENTUALICMSDESTINOITEM '+
    ' ,OMF_PERCENTUALBONIFICACAOITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETENFITEM = 0 '+
    ' ,OMF_PERCENTUALICMSFRETECTRITEM = 0 '+
    ' ,OMF_PERCENTUALDESPACESSORIAITEM = DEV_PERCENTUALDESPACESSORIAITEM '+
    ' ,OMF_PERCENTUALICMSACESSORIAITEM = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAOMF = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOOMF = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOOMF = 0 '+
    ' ,OMF_VALORCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_VALORCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_VALORCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_VALORBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_VALORBCICMSFRETENFITEM = 0 '+
    ' ,OMF_VALORBCALCULOPISCOFINSITEM = 0 '+
    ' ,OMF_ULTIMOCUSTOCOMPRA = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIO = 0 '+
    ' ,OMF_ULTIMOCUSTOCOMPRAMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOLIQUIDOMEDIO = 0 '+
    ' ,OMF_ULTIMOCUSTOINVENTARIOMEDIO = 0 '+
    ' ,OMF_PRECOZEROMKP = 0 '+
    ' ,OMF_PRECOVENDAMKP = 0 '+
    ' ,OMF_PRECOSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROVENDAMKP = 0 '+
    ' ,OMF_PERCENTUALLUCROSUGERIDOMKP = 0 '+
    ' ,OMF_PERCENTUALDESPESASLUCROMKP = 0 '+
    ' ,OMF_PERCENTUALMARKUPLUCRO = 0 '+
    ' ,OMF_PERCENTUALMARKUPZERO = 0 '+
    ' ,OMF_PERCENTUALICMSMARKUP = 0 '+
    ' ,OMF_TOTALITEM = DEV_TOTALPRECOLIQUIDO '+
    ' ,OMF_TOTALIPIITEM = DEV_TOTALIPIITEM '+
    ' ,OMF_TOTALPISITEM = DEV_TOTALPISITEM '+
    ' ,OMF_TOTALICMSITEM = DEV_TOTALICMSITEM '+
    ' ,OMF_TOTALVERBAITEM = 0 '+
    ' ,OMF_TOTALCOFINSITEM = DEV_TOTALCOFINSITEM '+
    ' ,OMF_TOTALSEGUROITEM = DEV_TOTALSEGUROITEM '+
    ' ,OMF_TOTALSERVICOITEM = 0 '+
    ' ,OMF_TOTALDESCTOITEM = (DEV_TOTALDESCTOITEM + DEV_TOTALDESCTOPRAZOITEM + DEV_TOTALDESCTOAVULSOITEM) '+
    ' ,OMF_TOTALICMSRNFITEM = DEV_TOTALICMSRITEM '+
    ' ,OMF_TOTALFRETENFITEM = DEV_TOTALFRETEITEM '+
    ' ,OMF_TOTALFRETERPAITEM = 0 '+
    ' ,OMF_TOTALICMSRDUAITEM = 0 '+
    ' ,OMF_TOTALADICIONALITEM = 0 '+
    ' ,OMF_TOTALFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSSIMPLESITEM = 0 '+
    ' ,OMF_TOTALBONIFICACAOITEM = 0 '+
    ' ,OMF_TOTALBASEOUTROSITEM = DEV_TOTALBASEOUTROSITEM '+
    ' ,OMF_TOTALICMSFRETENFITEM = 0 '+
    ' ,OMF_TOTALICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALICMSACESSORIAITEM = 0 '+
    ' ,OMF_TOTALDESPACESSORIAITEM = DEV_TOTALDESPACESSORIAITEM '+
    ' ,OMF_TOTALSUBSTRIBUTARIAITEM = DEV_TOTALSUBSTRIBUTARIAITEM '+
    ' ,OMF_TOTALBASEISENTOICMSITEM = DEV_TOTALBASEISENTOICMSITEM '+
    ' ,OMF_TOTALBASECALCULOMVAITEM = DEV_TOTALBASECALCULOMVAITEM '+
    ' ,OMF_TOTALBASECALCULOICMSITEM = DEV_TOTALBASECALCULOICMSITEM '+
    ' ,OMF_TOTALCOMPLEMENTONFICMSITEM = DEV_TOTALCOMPLEMENTONFICMSITEM '+
    ' ,OMF_TOTALBCICMSFRETECTRITEM = 0 '+
    ' ,OMF_TOTALBCALCULOPISCOFINSITEM = 0 '+
    ' ,OMF_TOTALBCICMSFRETENFITEM = 0 '+
    ' ,OMF_RATEADO = '+ QuotedStr('S') + ' '+
    ' ,OMF_DATAALTERACAO = DEV_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ' + QuotedStr('DVN') + ' + CAST(DEV_ID AS VARCHAR) '+
    ' ,OMF_NUMEROVOLUMES = DEV_NUMEROVOLUMES '+
    ' ,OMF_PESOBRUTOITEM = DEV_PESOBRUTOITEM '+
    ' ,OMF_PESOLIQUIDOITEM = DEV_PESOLIQUIDOITEM '+
    ' ,OMF_01_ID_OLD = 0 '+
    ' ,OMF_ID_OLD = 0 '+
    ' ,DEV_ID_OLD = DEV_ID '+
    ' ,DEV_01_ID_OLD = DEV_01_ID '+
    ' ,OMF_TIPODOCTO = '+ QuotedStr('DVN') + ' '+
    ' ,OMF_PERCENTUALCOMISSAOITEM = DEV_PERCENTUALCOMISSAOITEM '+
    ' ,OMF_VALORBASECALCULOPISCOFINSITEM = DEV_VALORBASECALCULOCOFINSITEM '+
    ' ,OMF_TOTALBASECALCULOPISCOFINSITEM = DEV_TOTALBASECALCULOPISITEM '+
    ' ,OMF_VALORBASEDESCTOCOMISSAOITEM = DEV_VALORBASEDESCTOCOMISSAOITEM '+
    ' ,OMF_VALORCOMISSAOITEM = DEV_VALORCOMISSAOITEM '+
    ' ,OMF_TOTALCOMISSAOITEM = DEV_TOTALCOMISSAOITEM '+
    ' ,OMF_PERCENTUALIBPTITEM = DEV_PERCENTUALIBPTITEM '+
    ' ,OMF_PERCENTUALIBPTMUNICIPALITEM = DEV_PERCENTUALIBPTMUNICIPALITEM '+
    ' ,OMF_PERCENTUALIBPTESTADUALITEM = DEV_PERCENTUALIBPTESTADUALITEM '+
    ' ,OMF_PERCENTUALIBPTNACIONALITEM = DEV_PERCENTUALIBPTNACIONALITEM '+
    ' ,OMF_PERCENTUALIBPTIMPORTADOITEM = DEV_PERCENTUALIBPTIMPORTADOITEM '+
    ' ,OMF_TOTALIBPTMUNICIPALITEM = DEV_TOTALIBPTMUNICIPALITEM '+
    ' ,OMF_TOTALIBPTESTADUALITEM = DEV_TOTALIBPTESTADUALITEM '+
    ' ,OMF_TOTALIBPTNACIONALITEM = DEV_TOTALIBPTNACIONALITEM '+
    ' ,OMF_TOTALIBPTIMPORTADOITEM = DEV_TOTALIBPTIMPORTADOITEM '+
    ' ,OMF_TOTALAPROXIMADOIMPOSTOITEM = DEV_TOTALAPROXIMADOIMPOSTOITEM '+
    ' ,OMF_PERCENTUALFCPITEM = DEV_PERCENTUALFCPITEM '+
    ' ,OMF_TOTALBASECALCULOFCPITEM = DEV_TOTALBASECALCULOFCPITEM '+
    ' ,OMF_TOTALFCPITEM = DEV_TOTALFCPITEM '+
    ' ,OMF_TOTALBASECALCULOFCPSTITEM = DEV_TOTALBASECALCULOFCPSTITEM '+
    ' ,OMF_TOTALFCPSTITEM = DEV_TOTALFCPSTITEM '+
    ' ,OMF_TOTALBASECALCULOFCPRETITEM = DEV_TOTALBASECALCULOFCPRETITEM '+
    ' ,OMF_TOTALFCPRETITEM = DEV_TOTALFCPRETITEM '+
    ' ,FAT_ID '+
    ' ,FAT_01_ID '+
    ' FROM DEV_00_01 '+
    ' LEFT JOIN PRO_00 '+
    '  ON DEV_00_01.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    ' WHERE DEV_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_03', 'SELECT SEE_ID OMF_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,SEE_SERIE OMF_SERIE '+
    ' ,MNF_CODIGO '+
    ' ,SEE_NOTAFISCAL OMF_NOTAFISCAL '+
    ' ,PES_CODIGO '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,TDC_CODIGO '+
    ' ,NTO_CODIGO '+
    ' ,CTB_CODIGO '+
    ' ,CFOP_CODIGO '+
    ' ,NULL FPG_CODIGO '+
    ' ,SEE_DATAVENCIMENTO OMF_DATAVENCIMENTO '+
    ' ,SEE_TOTALFRETECTR OMF_TOTALFRETECTR '+
    ' ,SEE_TOTALICMSFRETECTR OMF_TOTALICMSFRETECTR '+
    ' ,SEE_TOTALRBCICMSFRETECTR OMF_TOTALBCICMSFRETECTR '+
    ' ,SEE_PERCENTUALICMSFRETECTR OMF_PERCENTUALICMSFRETECTR '+
    ' ,NULL OMF_CHAVEACESSOCTR '+
    ' ,SEE_DATAALTERACAO OMF_DATAALTERACAO '+
    ' ,''SEE'' + CAST(SEE_ID AS VARCHAR) OMF_INTEGRACAOERP '+
    ' ,OMF_ID_OLD = 0 '+
    ' FROM SEE_00_03 '+
    ' WHERE SEE_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_05', ' SELECT OMF_05_ID = SEE_02_ID, '+
    ' COM_CODIGO = FIL_CODIGO, '+
    ' SEE_ID OMF_ID, '+
    ' OMF_DIA = SEE_DIA, '+
    ' BCO_CODIGO, '+
    ' FPG_CODIGO, '+
    ' OMF_DATAVENCTO = SEE_DATAVENCTO, '+
    ' OMF_NUMERODOCTO = SEE_NUMERODOCTO, '+
    ' FPG_TIPOPAGAMENTO, '+
    ' OMF_NUMEROPARCELA = SEE_NUMEROPARCELA, '+
    ' OMF_VALORPARCELA = SEE_VALORPARCELA, '+
    ' OMF_DATAALTERACAO = SEE_DATAALTERACAO, '+
    ' CTA_CODIGO = NULL, '+
    ' OMF_INTEGRACAOERP = ' + QuotedStr('SEE') + ' + CAST(SEE_ID AS VARCHAR), '+
    ' OMF_AUTORIZACAOCARTAO = NULL, '+
    ' OMF_PERCENTUALFINANCEIRO = NULL, '+
    ' CRT_CODIGO = NULL, '+
    ' OMF_VENCTOCARTAO = NULL, '+
    ' OMF_05_ID_OLD, '+
    ' OMF_ID_OLD '+
    ' FROM SEE_00_02 '+
    ' WHERE SEE_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    '  '+
    ' UNION ALL '+
    '  '+
    ' SELECT OMF_05_ID = SSE_02_ID, '+
    ' COM_CODIGO = FIL_CODIGO, '+
    ' OMF_ID = SSE_ID, '+
    ' OMF_DIA = SSE_DIA, '+
    ' BCO_CODIGO, '+
    ' FPG_CODIGO, '+
    ' OMF_DATAVENCTO = SSE_DATAVENCIMENTO, '+
    ' OMF_NUMERODOCTO = SSE_NUMERODOCTO, '+
    ' FPG_TIPOPAGAMENTO, '+
    ' OMF_NUMEROPARCELA = SSE_NUMEROPARCELA, '+
    ' OMF_VALORPARCELA = SSE_VALORPARCELA, '+
    ' OMF_DATAALTERACAO = SSE_DATAALTERACAO, '+
    ' CTA_CODIGO, '+
    ' OMF_INTEGRACAOERP = '+ QuotedStr('SSE') + ' + CAST(SSE_ID AS VARCHAR), '+
    ' OMF_AUTORIZACAOCARTAO = SSE_AUTORIZACAOCARTAO, '+
    ' OMF_PERCENTUALFINANCEIRO = SSE_PERCENTUALFINANCEIRO, '+
    ' CRT_CODIGO, '+
    ' SSE_VENCTOCARTAO, '+
    ' OMF_05_ID_OLD, '+
    ' OMF_ID_OLD '+
    ' FROM SSE_00_02 '+
    ' WHERE SSE_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_06', 'SELECT OMF_06_ID = ONE_03_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = ONE_ID '+
    ' ,OMF_DC = ONE_DC '+
    ' ,PLC_CODIGO '+
    ' ,OMF_VALORRATEIO = ONE_VALORRATEIO '+
    ' ,OMF_PERCENTUALRATEIO = ONE_PERCENTUALRATEIO '+
    ' ,OMF_CENTROCUSTORATEIO = ONE_CENTROCUSTORATEIO '+
    ' ,OMF_DATAALTERACAO = ONE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ''ONE'' + CAST(ONE_ID AS VARCHAR) '+
    ' ,OMF_06_ID_OLD '+
    ' ,OMF_ID_OLD '+
    ' FROM ONE_00_03 '+
    ' WHERE ONE_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT OMF_06_ID = SEE_04_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = SEE_ID '+
    ' ,OMF_DC = SEE_DC '+
    ' ,PLC_CODIGO '+
    ' ,OMF_VALORRATEIO = SEE_VALORRATEIO '+
    ' ,OMF_PERCENTUALRATEIO = SEE_PERCENTUALRATEIO  '+
    ' ,OMF_CENTROCUSTORATEIO = SEE_CENTROCUSTORATEIO '+
    ' ,OMF_DATAALTERACAO = SEE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ''SEE'' + CAST(SEE_ID AS VARCHAR) '+
    ' ,OMF_06_ID_OLD '+
    ' ,OMF_ID_OLD '+
    ' FROM SEE_00_04 '+
    ' WHERE SEE_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_06_01', 'SELECT OMF_06_01_ID = ONE_03_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = ONE_ID '+
    ' ,OMF_06_ID = ONE_03_ID '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,OMF_VALORRATEIO = ONE_VALORRATEIO '+
    ' ,OMF_PERCENTUALRATEIO = ONE_PERCENTUALRATEIO '+
    ' ,OMF_DATAALTERACAO = ONE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ' + QuotedStr('ONE') + ' + CAST(ONE_ID AS VARCHAR) '+
    ' ,OMF_06_01_ID_OLD '+
    ' ,OMF_06_ID_OLD '+
    ' ,OMF_ID_OLD '+
    ' FROM ONE_00_03_01 '+
    ' WHERE ONE_00_03_01.FIL_CODIGO IN (' + FiliaisWhere + ') '+
    ' '+
    ' UNION ALL '+
    ' '+
    ' SELECT OMF_06_01_ID = SEE_04_01_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_ID = SEE_ID '+
    ' ,OMF_06_ID = SEE_04_ID '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' ,OMF_VALORRATEIO = SEE_VALORRATEIO '+
    ' ,OMF_PERCENTUALRATEIO = SEE_PERCENTUALRATEIO '+
    ' ,OMF_DATAALTERACAO = SEE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ' + QuotedStr('SEE') + ' + CAST(SEE_ID AS VARCHAR) '+
    ' ,OMF_06_01_ID_OLD '+
    ' ,OMF_06_ID_OLD '+
    ' ,OMF_ID_OLD '+
    ' FROM SEE_00_04_01 '+
    ' WHERE SEE_00_04_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_08', 'SELECT OMF_ID = SEE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_DECLARACAOEXPORTACAO = SEE_DECLARACAOEXPORTACAO '+
    ' ,OMF_DATADECLARACAOEXPORTACAO = SEE_DATADECLARACAOEXPORTACAO '+
    ' ,OMF_NATUREZAOPERACAO = SEE_NATUREZAOPERACAO '+
    ' ,OMF_REGISTROEXPORTACAO = SEE_REGISTROEXPORTACAO '+
    ' ,OMF_DATAREGISTROEXPORTACAO = SEE_DATAREGISTROEXPORTACAO '+
    ' ,OMF_CONHECIMENTOEMBARQUE = SEE_CONHECIMENTOEMBARQUE '+
    ' ,OMF_DATACONHECIMENTOEMBARQUE = SEE_DATACONHECIMENTOEMBARQUE '+
    ' ,OMF_TIPOCONHECIMENTO = SEE_TIPOCONHECIMENTO '+
    ' ,OMF_CODIGOPAIS = SEE_CODIGOPAIS '+
    ' ,OMF_COMPROVANTEEXPORTACAO = SEE_COMPROVANTEEXPORTACAO '+
    ' ,OMF_DATACOMPROVANTEEXPORTACAO = SEE_DATACOMPROVANTEEXPORTACAO '+
    ' ,OMF_DATAALTERACAO = SEE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ''SEE'' + CAST(SEE_ID AS VARCHAR) '+
    ' FROM SEE_00_05 '+
    ' WHERE SEE_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_09', 'SELECT OMF_ID = SEE_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,OMF_TIPOMERCADORIA = SEE_TIPOMERCADORIA '+
    ' ,PRI_CODIGO '+
    ' ,OMF_NIVELCONTA = SEE_NIVELCONTA '+
    ' ,OMF_TIPOCONTA = SEE_TIPOCONTA '+
    ' ,OMF_CODIGOCONTA = SEE_CODIGOCONTA '+
    ' ,OMF_NOMECONTA = SEE_NOMECONTA '+
    ' ,OMF_TOTALNUMEROPARCELAS = SEE_TOTALNUMEROPARCELAS '+
    ' ,OMF_CODIGONATUREZACONTA = SEE_CODIGONATUREZACONTA '+
    ' ,OMF_CODIGOCENTROCUSTO = SEE_CODIGOCENTROCUSTO '+
    ' ,OMF_NOMECENTROCUSTO = SEE_NOMECENTROCUSTO '+
    ' ,OMF_TIPOEMITENTE = SEE_TIPOEMITENTE '+
    ' ,OMF_DATAALTERACAO = SEE_DATAALTERACAO '+
    ' ,OMF_INTEGRACAOERP = ''SEE'' + CAST(SEE_ID AS VARCHAR) '+
    ' ,OMF_ID_OLD = 0'+
    ' FROM SEE_00_06 '+
    ' WHERE SEE_00_06.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TOMF_00_10', 'SELECT OMF_10_ID = DEV_02_ID, '+
    ' COM_CODIGO = FIL_CODIGO, '+
    ' OMF_ID = DEV_ID, '+
    ' CRE_ID, '+
    ' OMF_GERARCREDITO = DEV_GERARCREDITO, '+
    ' OMF_DESCTODEVOLUCAO = DEV_DESCTODEVOLUCAO, '+
    ' OMF_TOTALVALORORIGINALCRE = DEV_TOTALVALORORIGINALCRE, '+
    ' OMF_DESATIVAR = DEV_DESATIVAR, '+
    ' OMF_DATAALTERACAO = DEV_DATAALTERACAO '+
    ' FROM DEV_00_02 '+
    ' WHERE DEV_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00', ' SELECT ORS_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,ORS_NUMEROOS '+
    ' ,ORS_SEQUENCIAL '+
    ' ,ORS_DATAEMISSAO '+
    ' ,VEI_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,VND_CODIGO '+
    ' ,FPG_CODIGO '+
    ' ,PRZ_CODIGO '+
    ' ,ORS_NUMERODOCTO '+
    ' ,ORS_NOTAFISCAL '+
    ' ,ORS_NOTAFISCALSERVICO '+
    ' ,ORS_TIPODOCUMENTO '+
    ' ,ORS_TOTALQTDPEDIDA '+
    ' ,ORS_TOTALQTDHORAS '+
    ' ,ORS_TOTALLIQUIDO '+
    ' ,ORS_TOTALSERVICOS '+
    ' ,ORS_TOTALPRODUTOS '+
    ' ,ORS_TOTALPRODUTOSLIQUIDO '+
    ' ,ORS_TOTALDESCTOITEM '+
    ' ,ORS_TOTALDESCTOAVULSO '+
    ' ,ORS_TOTALACRESCIMOITEM '+
    ' ,ORS_TOTALDESCTOSERVICOS '+
    ' ,ORS_TOTALBASECALCULOISS '+
    ' ,ORS_TOTALBASEDESCONTOCOMISSAO '+
    ' ,ORS_TOTALACRESCIMOAVULSO '+
    ' ,ORS_PERCENTUALDESCTOAVULSO '+
    ' ,ORS_PERCENTUALACRESCIMOAVULSO '+
    ' ,ORS_PERCENTUALCOMISSAO '+
    ' ,ORS_TOTALCOMISSAO '+
    ' ,LIB_NUMEROLIBERACAO '+
    ' ,ORS_TOTALKMVEICULO '+
    ' ,ORS_DIASRETORNO '+
    ' ,ORS_COMISSAONEGOCIADA '+
    ' ,ORS_TOTALISS '+
    ' ,ORS_IDFATURAMENTOPRODUTOS '+
    ' ,ORS_IDFATURAMENTOSERVICOS '+
    ' ,ORS_SOLICITACOES '+
    ' ,ORS_OBSERVACAO '+
    ' ,ORS_OBSERVACAOENTRADA '+
    ' ,ORS_OBSERVACAOVEICULO '+
    ' ,ORS_ENTREGUEPOR = NULL '+
    ' ,ORS_RETIRADOPOR = NULL '+
    ' ,ORS_BLOQUEADO '+
    ' ,ORS_INTEGRACAO '+
    ' ,ORS_IMPRESSO '+
    ' ,ORS_MESCLADO '+
    ' ,ORS_LOG '+
    ' ,ORS_HORAEMISSAO '+
    ' ,ORS_FECHADO '+
    ' ,ORS_DATAFECHAMENTO '+
    ' ,ORS_HORAFECHAMENTO = SUBSTRING(ORS_HORAFECHAMENTO, 1, 8) '+
    ' ,ORS_DIASVALIDADEORCAMENTO '+
    ' ,ORS_STATUSFECHAMENTO '+
    ' ,ORS_OBSERVACAOFECHAMENTO '+
    ' ,ORS_DATAPREVISAOTERMINO '+
    ' ,ORS_HORAPREVISAOTERMINO '+
    ' ,ORS_CANCELADA '+
    ' ,ORS_DATACANCELAMENTO '+
    ' ,ORS_OBSERVACAOCANCELAMENTO '+
    ' ,ORS_DATAALTERACAO '+
    ' ,MDV_ID '+
    ' ,LIB_ID '+
    ' ,ORS_NUMEROOC '+
    ' ,ORS_NOMECLIENTE '+
    ' ,ORS_TIPOFRETE '+
    ' ,CON_CODIGO = 0 '+
    ' ,BOX_CODIGO = NULL '+
    ' ,ORS_ID_OLD = 0 '+
    ' ,ORS_INTEGRACAO_OLD = NULL '+
    ' ,LIB_ID_OLD = 0 '+
    'FROM ORS_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00_01', 'SELECT COM_CODIGO = FIL_CODIGO ' +
    ' ,ORS_01_ID '+
    ' ,ORS_ID '+
    ' ,TAB_CODIGO '+
    ' ,PRO_CODIGO '+
    ' ,ORS_QTDPEDIDA '+
    ' ,GRD_CODIGO '+
    ' ,ORS_HASHKEY '+
    ' ,ORS_COD_TOT_PARC '+
    ' ,ORS_VALORITEM '+
    ' ,ORS_VALORLIQUIDOITEM '+
    ' ,ORS_PRECOVENDA '+
    ' ,ORS_PRECOCUSTO '+
    ' ,ORS_PRECOTABELA '+
    ' ,ORS_PRECOLIQUIDO '+
    ' ,ORS_PRECODIGITADO '+
    ' ,ORS_PRECOBASEDESCTO '+
    ' ,ORS_TOTALPRECOVENDA '+
    ' ,ORS_TOTALPRECOCUSTO '+
    ' ,ORS_TOTALPRECOTABELA '+
    ' ,ORS_TOTALPRECOLIQUIDO '+
    ' ,ORS_TOTALPRECODIGITADO '+
    ' ,ORS_TOTALPRECOBASEDESCTO '+
    ' ,ORS_VALORDESCTOITEM '+
    ' ,ORS_VALORACRESCIMOITEM '+
    ' ,ORS_VALORCOMISSAOITEM '+
    ' ,ORS_VALORDESCTOAVULSOITEM '+
    ' ,ORS_VALORACRESCIMOAVULSOITEM '+
    ' ,ORS_TOTALDESCTOITEM '+
    ' ,ORS_TOTALDESCTOAVULSOITEM '+
    ' ,ORS_TOTALCOMISSAOITEM '+
    ' ,ORS_TOTALACRESCIMOITEM '+
    ' ,ORS_TOTALACRESCIMOAVULSOITEM '+
    ' ,ORS_PERCENTUALDESCTOITEM '+
    ' ,ORS_PERCENTUALACRESCIMOITEM '+
    ' ,ORS_PERCENTUALCOMISSAOITEM '+
    ' ,ORS_DATAALTERACAO '+
    ' ,PRO_DESCRICAO '+
    ' ,ORS_01_ID_OLD '+
    ' ,ORS_ID_OLD '+
    ' FROM ORS_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00_01_01', 'SELECT COM_CODIGO = FIL_CODIGO, * FROM ORS_00_01_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00_02', 'SELECT COM_CODIGO = FIL_CODIGO, * FROM ORS_00_02');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00_02_01', 'SELECT COM_CODIGO = FIL_CODIGO, * FROM ORS_00_02_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00_03', 'SELECT COM_CODIGO = FIL_CODIGO, * FROM ORS_00_03');
    //----------------------------------------------------------------------------
    QueryList.Add('TORS_00_04', 'SELECT ORS_04_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,ORS_ID '+
    ' ,ORS_DIA '+
    ' ,FPG_CODIGO '+
    ' ,BCO_CODIGO '+
    ' ,CID_IBGE '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,ORS_DATAVENCIMENTO '+
    ' ,ORS_DOCTOEMITENTE '+
    ' ,ORS_NUMERODOCTO '+
    ' ,ORS_EMITENTE '+
    ' ,ORS_CONTA '+
    ' ,ORS_AGENCIA '+
    ' ,ORS_CIDADE '+
    ' ,ORS_VALORPARCELA '+
    ' ,ORS_VENCTOCARTAO '+
    ' ,ORS_NUMEROPARCELA '+
    ' ,ORS_AUTORIZACAOCARTAO '+
    ' ,ORS_PERCENTUALFINANCEIRO '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,FPG_TIPOPAGTOCOMISSAO '+
    ' ,ORS_DATAALTERACAO '+
    ' ,ORS_04_ID_OLD '+
    ' ,ORS_ID_OLD '+
    ' FROM ORS_00_04 '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = ORS_00_04.CID_CODIGO ');
    //----------------------------------------------------------------------------
    QueryList.Add('TFAT_01_LOGS', 'SELECT FAT_ID_LOG = ORS_ID_LOG '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,FAT_DATALOG = ORS_DATALOG '+
    ' ,FAT_HORALOG = ORS_HORALOG '+
    ' ,FAT_LOG = ORS_LOG '+
    ' ,FAT_ID = ORS_ID '+
    ' ,FAT_NUMEROOS = ORS_NUMEROOS '+
    ' ,PRO_CODIGO = PRO_CODIGO '+
    ' ,FAT_QTDPEDIDA = ORS_QTDPEDIDA '+
    ' ,USERS_LOGIN '+
    ' ,FAT_TIPOLOG = ORS_TIPOLOG '+
    ' ,FAT_TIPODOCUMENTO = ORS_TIPODOCUMENTO '+
    ' ,FAT_TIPOPRODUTO = ORS_TIPOPRODUTO '+
    ' FROM ORS_01_LOGS '+
    ' WHERE ORS_01_LOGS.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
//    QueryList.Add('TPAI_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM PAI_00 '+
//    ' WHERE PAI_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPALM_CLI_00', 'SELECT COM_CODIGO = 0 ' +
    ' ,CLI_CODIGO '+
    ' ,CLI_NOME '+
    ' ,CLI_FANTASIA_OU_APELIDO '+
    ' ,CLI_ENDERECO '+
    ' ,CLI_NUMEROENDERECO '+
    ' ,CLI_BAIRRO '+
    ' ,CID_IBGE '+
    ' ,CEP_CODIGO '+
    ' ,CLI_OBSERVACAO '+
    ' ,CLI_DDD_TELEFONE_1 '+
    ' ,CLI_COMPLEMENTO_1 '+
    ' ,CLI_DDD_TELEFONE_2 '+
    ' ,CLI_COMPLEMENTO_2 '+
    ' ,CLI_DDD_FAX '+
    ' ,CLI_EMAIL '+
    ' ,CLI_HTTP '+
    ' ,CLI_CONTATO '+
    ' ,CLI_TIPOCLIENTE '+
    ' ,CLI_TIPOPESSOA '+
    ' ,CLI_CNPJ_CPF '+
    ' ,CLI_IE '+
    ' ,CLI_IE_MUNICIPAL '+
    ' ,CLI_IE_RURAL '+
    ' ,CLI_DDD_REFERENCIAS_TELEFONE_1 '+
    ' ,CLI_REFERENCIAS_1 '+
    ' ,CLI_DDD_REFERENCIAS_TELEFONE_2 '+
    ' ,CLI_REFERENCIAS_2 '+
    ' ,CLI_CODIGORCA '+
    ' ,CLI_DATACADASTRO '+
    ' ,CLI_IMPORTADO '+
    ' ,CLI_CODIGOPRECADASTRO '+
    ' ,CLI_EXPORTADO '+
    ' FROM PALM_CLI_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TPALM_MSE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PALM_MSE_00 '+
    ' WHERE PALM_MSE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPALM_MSE_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PALM_MSE_00_01 '+
    ' WHERE PALM_MSE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPALM_MSR_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PALM_MSR_00 '+
    ' WHERE PALM_MSR_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPALM_PDA_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PALM_PDA_00 '+
    ' WHERE PALM_PDA_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPALM_PDA_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PALM_PDA_00_01 '+
    ' WHERE PALM_PDA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPCH_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PCH_00 '+
    ' WHERE PCH_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPCH_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PCH_00_01 '+
    ' WHERE PCH_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    {QueryList.Add('TPDA_00', ' SELECT PDA_ID, COM_CODIGO = FIL_CODIGO, CGA_ID, FPG_CODIGO, PES_CODIGO, '+
    ' VND_CODIGO, PRZ_CODIGO, TDC_CODIGO, NTO_CODIGO, CCU_CODIGO, CTB_CODIGO, CFOP_CODIGO, '+
    ' PDA_SERIE, MNF_CODIGO, PDA_NOTAFISCAL, LIB_NUMEROLIBERACAO, PDA_NUMERODOCTO, PDA_DATAENTREGA, '+
    ' PDA_DATALANCAMENTO, PDA_DATACANCELAMENTO, PDA_COMISSAONEGOCIADA, PDA_NUMEROORDEMCOMPRA, '+
    ' PDA_NUMERODOCTOREPRESENTANTE, PDA_CODIGOLIBERACAOVENDA, PDA_TOTALQTDPEDIDA, PDA_TOTALPESOLIQUIDO, '+
    ' PDA_TOTALPRODUTOS, PDA_TOTALPRODUTOSLIQUIDO, PDA_TOTALLIQUIDO, PDA_TOTALPESOBRUTO, PDA_TIPOFRETE, '+
    ' PDA_TOTALIPI, PDA_TOTALPIS, PDA_TOTALICMS, PDA_TOTALFRETE, PDA_TOTALICMSR, PDA_TOTALCOFINS, '+
    ' PDA_TOTALSEGURO, PDA_TOTALADICIONAL, PDA_TOTALSUBSTRIBUTARIA, PDA_TOTALDESPACESSORIA, '+
    ' PDA_TOTALBASEISENTOICMS, PDA_TOTALBASECALCULOMVA, PDA_TOTALBASECALCULOICMS, '+
    ' PDA_TOTALBASECALCULOCOFINS PDA_TOTALBCALCULOPISCOFINS, PDA_TOTALFINANCEIROPRAZO, '+
    ' PDA_TOTALCOMPLEMENTONFICMS, PDA_TOTALDESCTOITEM, PDA_TOTALDESCTOPRAZO, PDA_TOTALDESCTOAVULSO, '+
    ' PDA_TOTALCOMISSAO, PDA_PERCENTUALCOMISSAO, PDA_PERCENTUALDESCTOAVULSO, PDA_PERCENTUALDESCONTOPRAZO, '+
    ' PDA_PERCENTUALFINANCEIROPRAZO, PDA_MARCAVOLUMES, PDA_ESPECIEVOLUMES, PDA_NUMERACAOVOLUMES, '+
    ' PDA_TOTALNUMEROVOLUMES, PES_CODIGOENTREGA, PES_CODIGORETIRADA, PDA_DATADIGITACAOPALM, '+
    ' PDA_HORADIGITACAOPALM, PDA_TOTALAPROXIMADOIMPOSTO, PDA_TOTALIBPTMUNICIPAL, PDA_TOTALIBPTESTADUAL, '+
    ' PDA_TOTALIBPTNACIONAL, PDA_TOTALIBPTIMPORTADO, PDA_PERCENTUALIBPT, PDA_PERCENTUALIBPTMUNICIPAL, '+
    ' PDA_PERCENTUALIBPTESTADUAL, PDA_PERCENTUALIBPTNACIONAL, PDA_PERCENTUALIBPTIMPORTADO, '+
    ' PDA_TOTALBASECALCULOFCP, PDA_TOTALFCP, PDA_TOTALBASECALCULOFCPST, PDA_TOTALFCPST, '+
    ' PDA_TOTALBASECALCULOFCPRET, PDA_TOTALFCPRET, PDA_OBSERVACAO, PDA_OBSERVACAOCANCELAMENTO, '+
    ' PDA_CANCELADA, PDA_BLOQUEADO, PDA_DESATIVADO, PDA_FATURADO, PDA_INTEGRACAO, USERS_LOGIN, '+
    ' PDA_DATAALTERACAO, PDA_TIPODOCUMENTO, LIB_ID FROM PDA_00 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPDA_00_01', ' SELECT PDA_01_ID, COM_CODIGO = FIL_CODIGO, PDA_ID, TAB_CODIGO, CST_CODIGO, PRO_CODIGO, '+
    ' LEE_CODIGO, LEF_CODIGO, NCM_CODIGO, GAI_CODIGO, CFOP_CODIGO, CSTP_CODIGO CSTPC_CODIGO, '+
    ' GRD_CODIGO, PDA_LEFSTATUS, PDA_DESTAQUE_NF, PDA_QTDPEDIDA, PDA_NUMEROVOLUMES, PDA_PRECOTABELA, '+
    ' PDA_PRECOCUSTO, PDA_PRECOVENDA, PDA_PRECOLIQUIDO, PDA_PRECODIGITADO, PDA_PRECOBASEDESCTO, '+
    ' PDA_VALORCOMISSAOITEM, PDA_VALORIPIITEM, PDA_VALORPISITEM, PDA_VALORICMSITEM, PDA_VALORICMSRITEM, '+
    ' PDA_VALORFRETEITEM, PDA_VALORCOFINSITEM, PDA_VALORDESCTOITEM, PDA_VALORSEGUROITEM, '+
    ' PDA_VALORBASEOUTROSITEM, PDA_VALORDESCTOPRAZOITEM, PDA_VALORDESCTOAVULSOITEM, PDA_VALORDESPACESSORIAITEM, '+
    ' PDA_VALORSUBSTRIBUTARIAITEM, PDA_VALORBASEISENTOICMSITEM, PDA_VALORBASECALCULOMVAITEM, '+
    ' PDA_VALORBASECALCULOICMSITEM, PDA_VALORFINANCEIROPRAZOITEM, PDA_VALORCOMPLEMENTONFICMSITEM, '+
    ' PDA_VALORBASECALCULOPISITEM PDA_VALORBCALCULOPISCOFINSITEM, PDA_PERCENTUALIPIITEM, '+
    ' PDA_PERCENTUALPISITEM, PDA_PERCENTUALMVAITEM, PDA_PERCENTUALICMSITEM, PDA_PERCENTUALCOFINSITEM, '+
    ' PDA_PERCENTUALFRETEITEM, PDA_PERCENTUALDESCTOITEM, PDA_PERCENTUALSEGUROITEM, PDA_PERCENTUALREDUCAOBCITEM, '+
    ' PDA_PERCENTUALICMSDESTINOITEM, PDA_PERCENTUALDESPACESSORIAITEM, PDA_PERCENTUALCOMISSAOITEM, '+
    ' PDA_TOTALCOMISSAOITEM, PDA_TOTALIPIITEM, PDA_TOTALPISITEM, PDA_TOTALICMSITEM, PDA_TOTALICMSRITEM, '+
    ' PDA_TOTALFRETEITEM, PDA_TOTALCOFINSITEM, PDA_TOTALDESCTOITEM, PDA_TOTALSEGUROITEM, '+
    ' PDA_TOTALBASEOUTROSITEM, PDA_TOTALDESCTOPRAZOITEM, PDA_TOTALDESCTOAVULSOITEM, PDA_TOTALDESPACESSORIAITEM, '+
    ' PDA_TOTALSUBSTRIBUTARIAITEM, PDA_TOTALBASEISENTOICMSITEM, PDA_TOTALBASECALCULOMVAITEM, '+
    ' PDA_TOTALBASECALCULOICMSITEM, PDA_TOTALFINANCEIROPRAZOITEM, PDA_TOTALCOMPLEMENTONFICMSITEM, '+
    ' PDA_TOTALBASECALCULOPISITEM PDA_TOTALBCALCULOPISCOFINSITEM, PDA_TOTALPRECOLIQUIDO, '+
    ' PDA_TOTALPRECOVENDA, PDA_TOTALPRECOCUSTO, PDA_TOTALPRECOTABELA, PDA_TOTALPRECODIGITADO, '+
    ' PDA_TOTALPRECOBASEDESCTO, PDA_PESOBRUTOITEM, PDA_PESOLIQUIDOITEM, PDA_ORDEMITEM, '+
    ' PDA_ORDEMXMLITEM, PDA_PERCENTUALIBPTITEM, PDA_TOTALAPROXIMADOIMPOSTOITEM, '+
    ' PDA_PERCENTUALIBPTMUNICIPALITEM, PDA_PERCENTUALIBPTESTADUALITEM, PDA_PERCENTUALIBPTNACIONALITEM, '+
    ' PDA_PERCENTUALIBPTIMPORTADOITEM, PDA_TOTALIBPTMUNICIPALITEM, PDA_TOTALIBPTESTADUALITEM, '+
    ' PDA_TOTALIBPTNACIONALITEM, PDA_TOTALIBPTIMPORTADOITEM, PDA_PERCENTUALFCPITEM, '+
    ' PDA_TOTALBASECALCULOFCPITEM, PDA_TOTALFCPITEM, PDA_TOTALBASECALCULOFCPSTITEM, '+
    ' PDA_TOTALFCPSTITEM, PDA_TOTALBASECALCULOFCPRETITEM, PDA_TOTALFCPRETITEM, PDA_TOTALREDUCAOBCSTITEM, '+
    ' PDA_VALORREDUCAOBCSTITEM, PDA_PERCENTUALREDUCAOBCSTITEM, PDA_DATAALTERACAO '+
    ' FROM PDA_00_01 ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPDA_00_02', ' SELECT PDA_02_ID, '+
    ' COM_CODIGO = FIL_CODIGO, '+
    ' PDA_ID, '+
    ' PDA_DIA, '+
    ' FPG_CODIGO, '+
    ' BCO_CODIGO, '+
    ' CID_IBGE, '+
    ' CRT_CODIGO, '+
    ' CTA_CODIGO, '+
    ' PDA_DATAVENCIMENTO, '+
    ' PDA_DOCTOEMITENTE, '+
    ' PDA_NUMERODOCTO, '+
    ' PDA_EMITENTE, '+
    ' PDA_CONTA, '+
    ' PDA_AGENCIA, '+
    ' PDA_CIDADE, '+
    ' PDA_VALORPARCELA, '+
    ' PDA_VENCTOCARTAO, '+
    ' PDA_NUMEROPARCELA, '+
    ' PDA_AUTORIZACAOCARTAO, '+
    ' PDA_PERCENTUALFINANCEIRO, '+
    ' FPG_TIPOPAGAMENTO, '+
    ' FPG_TIPOPAGTOCOMISSAO, '+
    ' PDA_DATAALTERACAO, '+
    ' PDA_02_ID_OLD, '+
    ' PDA_ID_OLD '+
    ' FROM PDA_00_02 '+
    ' LEFT JOIN CID_00 ON CID_00.CID_CODIGO = PDA_00_02.CID_CODIGO ');}
    //----------------------------------------------------------------------------
    QueryList.Add('TPDC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PDC_00 '+
    ' WHERE PDC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPDC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PDC_00_01 '+
    ' WHERE PDC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPDC_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PDC_00_02 '+
    ' WHERE PDC_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPDC_00_02_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PDC_00_02_01 '+
    ' WHERE PDC_00_02_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPDC_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PDC_00_03 '+
    ' WHERE PDC_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //============================================================================
    // CADASTRO DE PESSOA
    //============================================================================
    QueryList.Add('TPES_00', 'SELECT DISTINCT COM_CODIGO = 0 '+
    ' ,PES_00.PES_CODIGO '+
    ' ,PES_00.PES_TIPOPESSOA '+
    ' ,PES_SQL_00.PES_CNPJ_CPF '+
    ' ,PES_IE_CI '+
    ' ,PES_00.PES_IE_MUNICIPAL '+
    ' ,PES_00.PES_NOME '+
    ' ,PES_00.PES_ENDERECO '+
    ' ,PES_00.PES_NUMEROENDERECO '+
    ' ,PES_00.CEP_CODIGO '+
    ' ,PES_00.PES_BAIRRO '+
    ' ,CID_00.CID_IBGE '+
    ' ,PES_00.TAB_CODIGO '+
    ' ,FPG_CODIGO '+
    ' ,PES_00.PES_FANTASIA_OU_APELIDO '+
    ' ,PES_00.PES_PONTOREFERENCIA '+
    ' ,PES_00.PES_DDD_TELEFONE_1 '+
    ' ,PES_DDD_TELEFONE_2 '+
    ' ,PES_DDD_TELEFONE_3 '+
    ' ,PES_DDD_CELULAR_1 = PES_00.PES_DDD_CELULAR '+
    ' ,PES_DDD_CELULAR_2 = PES_00.PES_DDD_FAX '+
    ' ,PES_CAIXAPOSTAL '+
    ' ,PES_HTTP '+
    ' ,PES_00.PES_CLIENTE '+
    ' ,PES_00.PES_CONTATO '+
    ' ,PES_00.PES_CONVENIO '+
    ' ,PES_00.PES_CONTADOR '+
    ' ,PES_00.PES_PORTADOR '+
    ' ,PES_00.PES_VENDEDOR '+
    ' ,PES_00.PES_FABRICANTE '+
    ' ,PES_00.PES_FUNCIONARIO '+
    ' ,PES_00.PES_FORNECEDOR '+
    ' ,PES_00.PES_TRANSPORTADOR '+
    ' ,PES_MONTANTEABERTO '+
    ' ,PES_MONTANTEFECHADO '+
    ' ,PES_NUMEROCRC '+
    ' ,PES_00.PES_CONTROLAESTOQUEPRODUTOR '+
    ' ,PES_00.PES_RNTRC '+
    ' ,PES_00.PES_BLOQUEADO '+
    ' ,PES_OBSERVACAOBLOQUEIO '+
    ' ,PES_00.PES_EMAIL '+
    ' ,PES_00.PES_EMAILXML '+
    ' ,PES_CONSUMIDORFINAL '+
    ' ,PES_ESTADOCIVIL = CASE '+
    '    WHEN PES_00.PES_TIPOPESSOA = ''F'' THEN PES_00_02.PES_ESTADOCIVIL '+
    '    WHEN PES_00.PES_TIPOPESSOA = ''P'' THEN PES_00_13.PES_ESTADOCIVIL '+
    '  END '+
    ' ,PES_00_02.PES_CI_ORGAOEMISSOR '+
    ' ,PES_CTPS '+
    ' ,PES_SEXO = CASE '+
    '    WHEN PES_00.PES_TIPOPESSOA = ''F'' THEN PES_00_02.PES_SEXO '+
    '    WHEN PES_00.PES_TIPOPESSOA = ''P'' THEN PES_00_13.PES_SEXO '+
    '  END '+
    ' ,PES_NACIONALIDADE '+
    ' ,PES_NATURALIDADE '+
    ' ,PES_CNPJ_CONTABILIDADE = NULL '+
    ' ,PES_NOMEPAI = PES_PAI '+
    ' ,PES_NOMEMAE = PES_MAE '+
    ' ,PES_00_20.TRP_CODIGO '+
    ' ,PES_00_17.SEG_CODIGO '+
    ' ,PES_00_21.VND_CODIGO '+
    ' ,PES_00_15.PRZ_CODIGO '+
    ' ,PES_00_04.ROT_CODIGO '+
    ' ,PES_ORDEMENTREGA '+
    ' ,PES_HISTORICOSPC = ''Consulta: '' + CAST(PES_00_07.PES_DATACONSULTA AS VARCHAR) + '' '' + '+
    ' ''Negativado: '' + PES_00_07.PES_NEGATIVADO + '' '' + '+
    ' ''Obs.: '' + PES_00_07.PES_REFERENCIA_1 + '','' + PES_00_07.PES_REFERENCIA_2 + '','' + PES_00_07.PES_REFERENCIA_3 '+
    ' ,PES_INFORMACAOBANCARIA = NULL '+
    ' ,PES_INFORMACAOAUTORIZADOS = (REPLACE(REPLACE((SELECT '+
    '      PES_NOME '+
    '    FROM PES_00_19 '+
    '    WHERE PES_00_19.PES_CODIGO = PES_00.PES_CODIGO '+
    '    FOR XML PATH ('''')) '+
    '  , ''</PES_NOME>'', '',''), ''<PES_NOME>'', '''')) '+
    ' ,PES_NOMECONJUGE = PES_00_14.PES_NOME '+
    ' ,PES_CPF_CONJUGE = PES_00_14.PES_CPF '+
    ' ,PES_CI_CONJUGE = PES_00_14.PES_CI '+
    ' ,PES_TIPOCLIENTE = CASE '+
    '    WHEN PES_00_04.PES_TIPOCLIENTE = ''SNNNNNN'' THEN ''1'' '+
    '    WHEN PES_00_04.PES_TIPOCLIENTE = ''NSNNNNN'' THEN ''2'' '+
    '    WHEN PES_00_04.PES_TIPOCLIENTE = ''NNSNNNN'' THEN ''3'' '+
    '    WHEN PES_00_04.PES_TIPOCLIENTE = ''NNNSNNN'' THEN ''4'' '+
    '  END  '+
    ' ,PES_TIPOFORNECEDOR '+
    ' ,PES_PERCENTUALLIMITEDESCONTO = PES_00_04.PES_PERCENTUALDESCONTO '+
    ' ,PES_PERCENTUALDESCTOBOLETO = PES_00_04.PES_PERCENTUALDESCTOBOLETO '+
    ' ,PES_00_04.PES_LIMITECREDITO '+
    ' ,PES_00_04.PES_LIMITECOMPRA '+
    ' ,PES_PARAMETROS = SUBSTRING(PES_00_04.PES_STATUSCLIENTES, 11, 1) '+
    ' ,PES_OBSERVACAO '+
    ' ,PES_00.PES_DESATIVADO '+
    ' ,PES_DATANASCIMENTO = CASE '+
    '    WHEN PES_00.PES_TIPOPESSOA = ''F'' THEN PES_00_02.PES_DATANASCIMENTO '+
    '    WHEN PES_00.PES_TIPOPESSOA = ''P'' THEN PES_00_13.PES_DATANASCIMENTO '+
    '  END '+
    ' ,PES_00.PES_DATACADASTRO '+
    ' ,PES_00.PES_DATAALTERACAO '+
    ' ,PES_CIDADE = CID_00.CID_NOME '+
    ' ,PES_UF = PES_SQL_00.UFS_SIGLA '+
    ' ,PES_CODIGOPAIS = PAI_00.PAI_CODIGOPAIS '+
    ' ,PES_PAIS = PAI_00.PAI_NOME '+
    ' ,PES_GUID = NULL '+
    ' ,TAB_CODIGOVENDEDOR = PES_00_18.TAB_CODIGO '+
    ' ,PES_STATUS '+
    ' ,PLC_CODIGO '+
    ' ,CCU_CODIGO '+
    ' FROM PES_00 '+
    ' LEFT JOIN PES_SQL_00 '+
    '   ON PES_SQL_00.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_01 '+
    '   ON PES_00_01.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_02 '+
    '   ON PES_00_02.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_03 '+
    '   ON PES_00_03.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_04 '+
    '   ON PES_00_04.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_07 '+
    '   ON PES_00_07.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_13 '+
    '   ON PES_00_13.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_14 '+
    '   ON PES_00_14.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_15 '+
    '   ON PES_00_15.PES_CODIGO = PES_00.PES_CODIGO '+
    '     AND PES_00_15.PRZ_DEFAULT = ''S'' '+
    ' LEFT JOIN PES_00_17 '+
    '   ON PES_00_17.PES_CODIGO = PES_00.PES_CODIGO '+
    '     AND PES_00_17.SEG_DEFAULT = ''S'' '+
    ' LEFT JOIN PES_00_18 '+
    '   ON PES_00_18.PES_CODIGO = PES_00.PES_CODIGO '+
    '     AND PES_00_18.TAB_DEFAULT = ''S'' '+
    ' LEFT JOIN PES_00_19 '+
    '   ON PES_00_19.PES_CODIGO = PES_00.PES_CODIGO '+
    ' LEFT JOIN PES_00_20 '+
    '   ON PES_00_20.PES_CODIGO = PES_00.PES_CODIGO '+
    '     AND PES_00_20.TRP_DEFAULT = ''S'' '+
    ' LEFT JOIN PES_00_21 '+
    '   ON PES_00_21.PES_CODIGO = PES_00.PES_CODIGO '+
    '     AND PES_00_21.VND_DEFAULT = ''S'' '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = PES_00.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '   ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO '+
    ' LEFT JOIN PAI_00 '+
    '   ON PAI_00.PAI_CODIGO = UFS_00.PAI_CODIGO');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_01', 'SELECT COM_CODIGO = 0 '+
    ' ,PES_00_05.PES_CODIGO '+
    ' ,CID_IBGE '+
    ' ,PES_00_05.CEP_CODIGO '+
    ' ,PES_00_05.PES_ENDERECO '+
    ' ,PES_00_05.PES_NUMEROENDERECO '+
    ' ,PES_00_05.PES_BAIRRO '+
    ' ,PES_00_05.PES_CAIXAPOSTAL '+
    ' ,PES_EMAILCOBRANCA '+
    ' ,PES_00_05.PES_DATAALTERACAO '+
    ' ,CID_NOME PES_CIDADE '+
    ' ,UFS_SIGLA PES_UF '+
    ' FROM PES_00_05 '+
    ' LEFT JOIN PES_00 '+
    '   ON PES_00.PES_CODIGO = PES_00_05.PES_CODIGO '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = PES_00_05.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '  ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_02', 'SELECT COM_CODIGO = 0 '+
    ' ,PES_00_12.PES_CODIGO '+
    ' ,PES_TIPOCOMISSAO '+
    ' ,PES_PERCENTUALCOMISSAO '+
    ' ,PES_PERCENTUALDESCTOPERMITIDO = PES_PERCENTUALDESCONTO '+
    ' ,PES_PERCENTUALAJUDACUSTO '+
    ' ,PES_PERCENTUALCOMISSAOTECNICO '+
    ' ,PES_ENVIAPALMVND = PES_ENVIAPALM '+
    ' ,PES_VALORSALARIO = PES_SALARIO '+
    ' ,PES_FUNCAO '+
    ' ,PES_DATAADMISSAO '+
    ' ,PES_DATADEMISSAO '+
    ' ,PES_DATAULTIMOEXAME '+
    ' ,PES_ULTIMOEXAME '+
    ' ,PES_TAMANHOUNIFORME '+
    ' ,PES_DATAENTREGAUNIFORME '+
    ' ,PES_00_02.PES_USUARIOVINCULADO '+
    ' ,PES_00_12.PES_DATAALTERACAO '+
    ' FROM PES_00_12 '+
    ' LEFT JOIN PES_00_08 '+
    '   ON PES_00_08.PES_CODIGO = PES_00_12.PES_CODIGO '+
    ' LEFT JOIN PES_00 '+
    '   ON PES_00.PES_CODIGO = PES_00_12.PES_CODIGO '+
    ' LEFT JOIN PES_00_02 '+
    '   ON PES_00_02.PES_CODIGO = PES_00_12.PES_CODIGO');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_03', 'SELECT COM_CODIGO = 0 '+
    ' ,PES_CODIGO '+
    ' ,VEI_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,PES_INSCRICAOINSS '+
    ' ,PES_HABILITACAO '+
    ' ,PES_UFHABILITACAO = UFS_SIGLAHABILITACAO '+
    ' ,PES_REGISTROHABILITACAO '+
    ' ,PES_CATEGORIAHABILITACAO '+
    ' ,PES_DATAEMISSAOHABILITACAO '+
    ' ,PES_DATAVENCTOHABILITACAO '+
    ' ,PES_RASTREADOR '+
    ' ,PES_USUARIORASTREADOR '+
    ' ,PES_SENHARASTREADOR '+
    ' ,PES_SITUACAOFUNCIONAL '+
    ' ,PES_NUMEROMOPP '+
    ' ,PES_DATAEMISSAOMOPP '+
    ' ,PES_DATAVENCTOMOPP '+
    ' ,PES_DATAALTERACAO '+
    ' FROM PES_00_09');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_04', 'SELECT COM_CODIGO = 0 '+
    ' ,PES_04_ID = PES_16_ID '+
    ' ,PES_CODIGO '+
    ' ,CNV_CODIGO '+
    ' ,CNV_DEFAULT '+
    ' ,CNV_MATRICULA '+
    ' ,PES_DATAALTERACAO '+
    ' FROM PES_00_16');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_05', 'SELECT COM_CODIGO = 0 '+
    ' ,PES_05_ID = PES_06_ID '+
    ' ,PES_CODIGO '+
    ' ,PES_NOMECONTATO = PES_NOME '+
    ' ,PES_EMAILCONTATO = PES_EMAIL '+
    ' ,PES_DDD_TELEFONECONTATO = PES_DDD_TELEFONE '+
    ' ,PES_DATAALTERACAO '+
    ' FROM PES_00_06');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_06', 'SELECT COM_CODIGO = 0 '+
    ' ,PES_06_ID =PES_26_ID '+
    ' ,PES_CODIGO '+
    ' ,HSP_CODIGO '+
    ' ,HSP_QUANTIDADECULTURA = HSP_QUANTIDADE '+
    ' ,HSP_ESPECIECULTURA = HSP_ESPECIE '+
    ' ,HSP_DEFAULT '+
    ' ,PES_DATAALTERACAO '+
    ' FROM PES_00_26');
    //----------------------------------------------------------------------------
    QueryList.Add('TPES_00_07', 'SELECT PES_07_ID = PES_28_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,PES_VALORMOVIMENTO '+
    ' ,PES_DATALANCAMENTO '+
    ' ,USERS_LOGIN '+
    ' ,PES_INTEGRACAO '+
    ' ,PES_DATAALTERACAO '+
    ' FROM PES_00_28');
    //============================================================================
    QueryList.Add('TPLC_00', 'SELECT COM_CODIGO = 0, * FROM PLC_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TPLC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PLC_00_01 '+
    ' WHERE PLC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPMC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PMC_00 '+
    ' WHERE PMC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPMC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PMC_00_01 '+
    ' WHERE PMC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPPC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PPC_00 '+
    ' WHERE PPC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPPC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PPC_00_01 '+
    ' WHERE PPC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPPD_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PPD_00 '+
    ' WHERE PPD_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPPD_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PPD_00_01 '+
    ' WHERE PPD_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPPD_00_01_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PPD_00_01_01 '+
    ' WHERE PPD_00_01_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPPD_00_01_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PPD_00_01_02 '+
    ' WHERE PPD_00_01_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00', 'SELECT COM_CODIGO = 0 '+
    ' ,PRO_00.PRO_CODIGO '+
    ' ,PRO_DESCRICAO '+
    ' ,PRO_NOMEAPELIDO '+
    ' ,PRO_DESCRICAOADICIONAL '+
    ' ,GRP_CODIGO '+
    ' ,SGP_CODIGO '+
    ' ,SGM_CODIGO '+
    ' ,CLF_CODIGO '+
    ' ,NCM_CODIGO '+
    ' ,LEF_CODIGO '+
    ' ,FAB_CODIGO = PRO_00_02.PES_CODIGO '+
    ' ,PRO_00_10.MAR_CODIGO '+
    ' ,PRO_APLICACAO '+
    ' ,PRO_DATACADASTRO '+
    ' ,PRO_NUMEROVOLUMES '+
    ' ,PRO_QUANTIDADEUNCAIXA = PRO_00.PRO_QUANTIDADEUNIDADE '+
    ' ,PRO_REFERENCIAINTERNA '+
    ' ,PRO_CFNBM '+
    ' ,PRO_EMBALAGEM '+
    ' ,PRO_PESOBRUTO '+
    ' ,PRO_PESOLIQUIDO '+
    ' ,PRO_PARAMETROS = SUBSTRING(PRO_PARAMETROS, 1, 10) '+
    ' ,PRO_PROCEDENCIA '+
    ' ,PRO_PERCENTUALRCFDC '+
    ' ,PRO_PERCENTUALLUCROMKP '+
    ' ,PRO_PERCENTUALCOMISSAO '+
    ' ,PRO_PRODUTOFINAL '+
    ' ,PRO_PRODUTOCONSUMO '+
    ' ,PRO_PRODUTOIMOBILIZADO '+
    ' ,PRO_PRODUTOPECAPRONTA '+
    ' ,PRO_PRODUTOMATERIAPRIMA '+
    ' ,PRO_VALIDADEBALANCA '+
    ' ,PRO_PERIODOGARANTIA '+
    ' ,PRO_QTDADEMINIMAATACADO '+
    ' ,PRO_PERCENTUALDESCTOATACADO '+
    ' ,PRO_CODIGOANP '+
    ' ,PRO_CEST '+
    ' ,PRO_VALORCUSTOMERCADO '+
    ' ,PRO_DESCRICAOANP '+
    ' ,PRO_PERCENTUALGASGLP '+
    ' ,PRO_PERCENTUALGASGNN '+
    ' ,PRO_PERCENTUALGASGNI '+
    ' ,PRO_QTDMETROCUBICO '+
    ' ,PRO_CODIGOBARRA1 = BARR1.PRO_CODIGOBARRA '+
    ' ,PRO_CODIGOBARRA2 = BARR2.PRO_CODIGOBARRA '+
    ' ,PRO_CODIGOBARRA3 = NULL '+
    ' ,PRO_CODIGOBARRACAIXA = CX.PRO_CODIGOBARRACAIXA '+
    ' ,PRO_QTDUNCAIXACODIGOBARRA = CX.PRO_QUANTIDADEUNIDADECAIXA '+
    ' ,PRO_OBSERVACAO '+
    ' ,PRO_DESATIVADO '+
    ' ,PRO_00.PRO_DATAALTERACAO '+
    ' ,SGM_CODIGOTRIBUTAVEL '+
    ' ,PRO_QUANTIDADETRIBUTAVEL '+
    ' FROM PRO_00 '+
    ' LEFT JOIN PRO_00_02 '+
    '   ON PRO_00_02.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '     AND PRO_00_02.PRO_DEFAULT = ''S'' '+
    ' LEFT JOIN PRO_00_10 '+
    '   ON PRO_00_10.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '     AND PRO_00_10.PRO_DEFAULT = ''S'' '+
    ' LEFT JOIN PRO_00_05 BARR1 '+
    '   ON BARR1.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '     AND BARR1.PRO_05_ID = (SELECT TOP 1 '+
    '         PRO_05_ID '+
    '       FROM PRO_00_05 '+
    '       WHERE PRO_00_05.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '       ORDER BY PRO_05_ID) '+
    ' LEFT JOIN PRO_00_05 BARR2 '+
    '   ON BARR2.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '     AND BARR2.PRO_05_ID = (SELECT TOP 1 '+
    '         PRO_05_ID '+
    '       FROM PRO_00_05 '+
    '       WHERE PRO_00_05.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '       ORDER BY PRO_05_ID DESC) '+
    ' LEFT JOIN PRO_00_05 CX '+
    '   ON CX.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '     AND CX.PRO_05_ID = (SELECT TOP 1 '+
    '         PRO_05_ID '+
    '       FROM PRO_00_05 '+
    '       WHERE PRO_00_05.PRO_CODIGO = PRO_00.PRO_CODIGO '+
    '       AND PRO_00_05.PRO_CODIGOBARRACAIXA IS NOT NULL)');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PRO_00_01 '+
    ' WHERE PRO_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_02', 'SELECT COM_CODIGO = 0 '+
    ' ,PRO_16_ID PRO_02_ID '+
    ' ,PRO_CODIGO '+
    ' ,GRD_CODIGO '+
    ' ,PRO_DATAALTERACAO '+
    ' FROM PRO_00_16');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_03', 'SELECT COM_CODIGO = 0 '+
    ' ,PRO_03_ID = PRO_06_ID '+
    ' ,PRO_CODIGO '+
    ' ,PES_CODIGO '+
    ' ,PRO_NOTAFISCAL = NULL '+
    ' ,PRO_DATANOTAFISCAL = NULL '+
    ' ,PRO_CODIGOFORNECEDOR '+
    ' ,PRO_FATORCONVERSAO '+
    ' ,PRO_DEFAULT = ''N'' '+
    ' ,PRO_DATAALTERACAO '+
    ' FROM PRO_00_06');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_04', 'SELECT COM_CODIGO = 0, * FROM PRO_00_04');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_05', 'SELECT COM_CODIGO = 0 '+
    ' ,PRO_05_ID = PRO_09_ID '+
    ' ,PRO_CODIGO '+
    ' ,TAB_CODIGO '+
    ' ,PRO_QTDMINIMA '+
    ' ,PRO_ULTIMOPRECO '+
    ' ,PRO_PRECOPEDIDO '+
    ' ,PRO_PRECOTABELA '+
    ' ,PRO_PRECOANTERIOR '+
    ' ,PRO_PRECOFATURAMENTO '+
    ' ,PRO_VENDASUGESTAO '+
    ' ,PRO_VENDALUCROZERO '+
    ' ,PRO_VENDALUCROMINIMO '+
    ' ,PRO_VENDALUCROMAXIMO '+
    ' ,PRO_PERCENTUALACRESCIMO '+
    ' ,PRO_PRODUTONATABELA '+
    ' ,PRO_DATAALTERACAO '+
    'FROM PRO_00_09');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_06','SELECT PRO_CODIGO '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PRO_TIPOMERCADORIA '+
    ' ,PRI_CODIGO '+
    ' ,PRO_NIVELCONTA '+
    ' ,PRO_TIPOCONTA '+
    ' ,PRO_CODIGOCONTA '+
    ' ,PRO_NOMECONTA '+
    ' ,PRO_TOTALNUMEROPARCELAS '+
    ' ,PRO_CODIGONATUREZACONTA '+
    ' ,PRO_CODIGOCENTROCUSTO '+
    ' ,PRO_NOMECENTROCUSTO '+
    ' ,PRO_VIDAUTILBEM '+
    ' ,PRO_FUNCAOBEM '+
    ' ,PRO_TIPOEMITENTE '+
    ' ,PES_CODIGO '+
    ' ,MNF_CODIGO '+
    ' ,PRO_SERIE '+
    ' ,PRO_NOTAFISCAL '+
    ' ,PRO_CHAVEACESSONF '+
    ' ,PRO_DATAEMISSAONF '+
    ' ,PRO_DATAINCLUSAOCONTA '+
    ' ,PRO_DATAALTERACAO '+
    ' FROM PRO_00_14 '+
    ' WHERE PRO_00_14.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRO_00_07','SELECT PRO_15_ID PRO_07_ID '+
    ' ,PRO_CODIGO '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,PRO_DATAMOVTO '+
    ' ,PRO_TIPOMOVTO '+
    ' ,PRO_VALORICMSOPEPROPRIA '+
    ' ,PRO_VALORICMSOPESUBTRIBUTARIA '+
    ' ,PRO_VALORICMSFRETE '+
    ' ,PRO_VALORICMSDIFALIQUOTA '+
    ' ,PRO_NUMEROPARCELA '+
    ' ,PRO_VALORPARCELAICMSAPROPRIACAO '+
    ' ,PRO_DATAALTERACAO '+
    ' ,PRO_COMPETENCIA '+
    ' ,PRO_NOTAFISCAL '+
    ' FROM PRO_00_15 '+
    ' WHERE PRO_00_15.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRT_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PRT_00 '+
    ' WHERE PRT_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRT_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PRT_00_01 '+
    ' WHERE PRT_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRZ_00', 'SELECT COM_CODIGO = 0, * FROM PRZ_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRZ_00_01', 'SELECT COM_CODIGO = 0, * FROM PRZ_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TPRZ_00_02', 'SELECT COM_CODIGO = 0, * FROM PRZ_00_02');
    //----------------------------------------------------------------------------
    QueryList.Add('TPSQ_XX', 'SELECT * FROM PSQ_XX');
    //----------------------------------------------------------------------------
    QueryList.Add('TPSQ_XX_01', 'SELECT * FROM PSQ_XX_01');
    //----------------------------------------------------------------------------
//    QueryList.Add('TPVA_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM PVA_00 '+
//    ' WHERE PVA_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TPVA_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM PVA_00_01 '+
//    ' WHERE PVA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TPVA_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM PVA_00_02 '+
//    ' WHERE PVA_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TPVA_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM PVA_00_03 '+
//    ' WHERE PVA_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TPVD_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM PVD_00 '+
    ' WHERE PVD_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRBC_00', 'SELECT COM_CODIGO = 0, * FROM RBC_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TRCC_00', 'SELECT COM_CODIGO = 0, * FROM RCC_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TRCC_00_01', 'SELECT COM_CODIGO = 0, * FROM RCC_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TREG_00', 'SELECT COM_CODIGO = 0, * FROM REG_00');
    //----------------------------------------------------------------------------
//    QueryList.Add('TREL_XX', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM REL_XX '+
//    ' WHERE REL_XX.FIL_CODIGO IN (' + FiliaisWhere + ') ');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TREL_XX_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM REL_XX_01 '+
//    ' WHERE REL_XX_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TREQ_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM REQ_00 '+
    ' WHERE REQ_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TREQ_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM REQ_00_01 '+
    ' WHERE REQ_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TREQ_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM REQ_00_02 '+
    ' WHERE REQ_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TREQ_00_02_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    'FROM REQ_00_02_01 '+
    ' WHERE REQ_00_02_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRETQ_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RETQ_00 '+
    ' WHERE RETQ_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRFC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RFC_00 '+
    ' WHERE RFC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRFC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RFC_00_01 '+
    ' WHERE RFC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRFC_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RFC_00_02 '+
    ' WHERE RFC_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRFC_00_03', ' SELECT RFC_03_ID, '+
    ' COM_CODIGO = FIL_CODIGO, '+
    ' RFC_ID, '+
    ' FAT_ID, '+
    ' RFC_DIA, '+
    ' FPG_CODIGO, '+
    ' FPG_TIPOPAGAMENTO, '+
    ' FPG_TIPOPAGTOCOMISSAO, '+
    ' CRT_CODIGO, '+
    ' CTA_CODIGO, '+
    ' CID_IBGE, '+
    ' RFC_CIDADE, '+
    ' BCO_CODIGO,'+
    ' RFC_CONTA, '+
    ' RFC_AGENCIA, '+
    ' RFC_EMITENTE, '+
    ' RFC_NUMEROPARCELA, '+
    ' RFC_DATAVENCIMENTO, '+
    ' RFC_VALORPARCELA, '+
    ' RFC_NUMERODOCTO, '+
    ' RFC_VENCTOCARTAO, '+
    ' RFC_DOCTOEMITENTE, '+
    ' RFC_NUMEROCHEQUE, '+
    ' RFC_AUTORIZACAOCARTAO, '+
    ' RFC_PERCENTUALFINANCEIRO, '+
    ' RFC_DATAALTERACAO, '+
    ' RFC_03_ID_OLD, '+
    ' RFC_ID_OLD, '+
    ' FAT_ID_OLD '+
    ' FROM RFC_00_03 '+
    ' LEFT JOIN CID_00 ON CID_00.CID_CODIGO = RFC_00_03.CID_CODIGO '+
    ' WHERE RFC_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRFC_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RFC_00_04 '+
    ' WHERE RFC_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRFE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RFE_00 '+
    ' WHERE RFE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TROT_00', 'SELECT COM_CODIGO = 0, * FROM ROT_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TROT_00_01', 'SELECT COM_CODIGO = 0 '+
    ' ,ROT_01_ID '+
    ' ,ROT_CODIGO '+
    ' ,CID_IBGE '+
    ' ,CID_NOME ROT_CIDADE '+
    ' ,UFS_SIGLA ROT_UF '+
    ' ,ROT_BAIRRO '+
    ' ,ROT_DATAALTERACAO '+
    ' FROM ROT_00_01 '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = ROT_00_01.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '   ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRPA_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RPA_00 '+
    ' WHERE RPA_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRPA_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RPA_00_01 '+
    ' WHERE RPA_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRPA_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RPA_00_02 '+
    ' WHERE RPA_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TRPA_00_02_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM RPA_00_02_01 '+
    ' WHERE RPA_00_02_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCP_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCP_00 '+
    ' WHERE SCP_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCP_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCP_00_01 '+
    ' WHERE SCP_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCP_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCP_00_02 '+
    ' WHERE SCP_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCP_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCP_00_03 '+
    ' WHERE SCP_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCP_00_03_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCP_00_03_01 '+
    ' WHERE SCP_00_03_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00 '+
    ' WHERE SCR_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00_01 '+
    ' WHERE SCR_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00_02 '+
    ' WHERE SCR_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00_03 '+
    ' WHERE SCR_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00_04', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00_04 '+
    ' WHERE SCR_00_04.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00_04_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00_04_01 '+
    ' WHERE SCR_00_04_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCR_00_05', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCR_00_05 '+
    ' WHERE SCR_00_05.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
//    QueryList.Add('TSCRIPTS', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM SCRIPTS '+
//    ' WHERE SCRIPTS.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCT_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCT_00 '+
    ' WHERE SCT_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCT_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCT_00_01 '+
    ' WHERE SCT_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSCT_00_02', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM SCT_00_02 '+
    ' WHERE SCT_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSEG_00', 'SELECT COM_CODIGO = 0, * FROM SEG_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TSFH_00', 'SELECT SFH_CODIGO, '+
    ' CEP_CODIGO, '+
    ' c.CID_IBGE, '+
    ' SFH_CNPJ, '+
    ' SFH_IE, '+
    ' SFH_UF = UFS_SIGLA, '+
    ' SFH_RAZAO, '+
    ' SFH_FANTASIA_OU_APELIDO, '+
    ' SFH_ENDERECO, '+
    ' SFH_NUMEROENDERECO, '+
    ' SFH_BAIRRO, '+
    ' SFH_PONTOREFERENCIA, '+
    ' SFH_DDD_TELEFONE, '+
    ' SFH_DDD_CELULAR, '+
    ' SFH_DDD_FAX, '+
    ' SFH_EMAIL, '+
    ' SFH_HTTP, '+
    ' SFH_CAIXAPOSTAL, '+
    ' SFH_IE_MUNICIPAL, '+
    ' SFH_CONTATO, '+
    ' SFH_OBSERVACAO, '+
    ' SFH_NUMEROLAUDO, '+
    ' SFH_DESATIVADO, '+
    ' SFH_DATAALTERACAO, '+
    ' SFH_VERSAOER, '+
    ' SFH_IDCSTR, '+
    ' SFH_CIDADE = c.CID_NOME, '+
    ' SFH_CSTR FROM SFH_00 '+
    ' LEFT JOIN CID_00 c ON SFH_00.CID_CODIGO = c.CID_CODIGO');
    //----------------------------------------------------------------------------
    QueryList.Add('TSGM_00', 'SELECT COM_CODIGO = 0, * FROM SGM_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TSGP_00', 'SELECT COM_CODIGO = 0, * FROM SGP_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TTAB_00', 'SELECT COM_CODIGO = 0, TAB_CODIGO '+
    ' ,TAB_DESCRICAO '+
    ' ,TAB_DESATIVADO '+
    ' ,TAB_DATAALTERACAO '+
    ' ,UFS_SIGLA TAB_UF '+
    ' ,TAB_PERCENTUALACRESCIMO '+
    ' ,TAB_PERCENTUALDESCONTO '+
    ' ,TAB_PERCENTUALCOMISSAO '+
    ' FROM TAB_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TTAB_00_01', 'SELECT COM_CODIGO = 0, * FROM TAB_00_01');
    //----------------------------------------------------------------------------
    QueryList.Add('TTDC_00', 'SELECT COM_CODIGO = 0, * FROM TDC_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TTLN_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM TLN_00 '+
    ' WHERE TLN_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TTPO_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM TPO_00 '+
    ' WHERE TPO_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TTPO_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM TPO_00_01 '+
    ' WHERE TPO_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TTRC_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM TRC_00 '+
    ' WHERE TRC_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TTRC_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM TRC_00_01 '+
    ' WHERE TRC_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TTXS_00', 'SELECT COM_CODIGO = 0 '+
    ' ,TXS_CODIGO '+
    ' ,TXS_DESCRICAO '+
    ' ,UFS_SIGLA TXS_UF '+
    ' ,TXS_DESATIVADO '+
    ' ,TXS_DATAALTERACAO '+
    ' FROM TXS_00');
    //----------------------------------------------------------------------------
    QueryList.Add('TTXS_00_01', 'SELECT COM_CODIGO = 0 '+
    ' ,TXS_01_ID '+
    ' ,TXS_CODIGO '+
    ' ,UFS_SIGLA TXS_UF '+
    ' ,TXS_PERCENTUALSEGURO '+
    ' ,TXS_DATAALTERACAO '+
    ' FROM TXS_00_01');
    //----------------------------------------------------------------------------
//    QueryList.Add('TUFS_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM UFS_00 '+
//    ' WHERE UFS_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TUSERS', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM USERS '+
//    ' WHERE USERS.FIL_CODIGO IN (' + FiliaisWhere + ') ');
//    //----------------------------------------------------------------------------
//    QueryList.Add('TUSERS_SHORTCUTS', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM USERS_SHORTCUTS '+
//    ' WHERE USERS_SHORTCUTS.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEF_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM VEF_00 '+
    ' WHERE VEF_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEF_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM VEF_00_01 '+
    ' WHERE VEF_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEF_00_02', 'SELECT VEF_02_ID '+
    ' ,COM_CODIGO = FIL_CODIGO '+
    ' ,VEF_ID '+
    ' ,VEF_DIA '+
    ' ,FPG_TIPOPAGAMENTO '+
    ' ,FPG_CODIGO '+
    ' ,BCO_CODIGO '+
    ' ,CID_IBGE '+
    ' ,CRT_CODIGO '+
    ' ,CTA_CODIGO '+
    ' ,VEF_DATAVENCIMENTO '+
    ' ,VEF_DOCTOEMITENTE '+
    ' ,VEF_NUMERODOCTO '+
    ' ,VEF_NUMEROCHEQUE '+
    ' ,VEF_NUMEROPARCELA '+
    ' ,VEF_VALORPARCELA '+
    ' ,VEF_EMITENTE '+
    ' ,VEF_CONTA '+
    ' ,VEF_AGENCIA '+
    ' ,VEF_CIDADE '+
    ' ,VEF_VENCTOCARTAO '+
    ' ,VEF_AUTORIZACAOCARTAO '+
    ' ,VEF_PERCENTUALFINANCEIRO '+
    ' ,FPG_TIPOPAGTOCOMISSAO '+
    ' ,VEF_DATAALTERACAO '+
    ' ,VEF_02_ID_OLD '+
    ' ,VEF_ID_OLD '+
    ' FROM VEF_00_02 '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = VEF_00_02.CID_CODIGO '+
    ' WHERE VEF_00_02.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEF_00_03', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM VEF_00_03 '+
    ' WHERE VEF_00_03.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEI_00', 'SELECT COM_CODIGO = 0 '+
    ' ,VEI_CODIGO '+
    ' ,VEI_COR '+
    ' ,VEI_PLACA '+
    ' ,PES_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,MAR_CODIGO '+
    ' ,CID_IBGE = SUBSTRING(RTRIM(LTRIM(CID_IBGE)), 1, 7) '+
    ' ,VEI_DESCRICAO '+
    ' ,VEI_ANO_MODELO '+
    ' ,VEI_TIPOCOMBUSTIVEL '+
    ' ,VEI_NUMEROCHASSI '+
    ' ,VEI_NUMERORENAVAM '+
    ' ,VEI_DATAVENCTODER '+
    ' ,VEI_DATAVENCTOSEGURO '+
    ' ,VEI_REGISTRORENAVAM '+
    ' ,VEI_NUMEROREFERENCIA '+
    ' ,VEI_NUMEROCAPACITACAO '+
    ' ,VEI_DATAVENCTOCAPACITACAO '+
    ' ,VEI_DESATIVADO '+
    ' ,VEI_OBSERVACAO '+
    ' ,VEI_DATAALTERACAO '+
    ' ,VEI_RNTRC '+
    ' ,VEI_CAPACIDADEM3 '+
    ' ,VEI_CAPACIDADEKG '+
    ' ,VEI_TARAKG '+
    ' ,VEI_TIPORODADO '+
    ' ,VEI_TIPOCARROCERIA '+
    ' ,VEI_TIPODOCUMENTO '+
    ' ,VEI_CIDADE = CID_NOME '+
    ' ,VEI_UF = UFS_SIGLA '+
    ' ,VEI_DATAVENCTODETRAN '+
    'FROM VEI_00 '+
    'LEFT JOIN CID_00 '+
    '  ON CID_00.CID_CODIGO = VEI_00.CID_CODIGO '+
    'LEFT JOIN UFS_00 '+
    '  ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEI_00_01', 'SELECT COM_CODIGO = 0 '+
    ' ,VEI_CODIGO '+
    ' ,VEI_PLACA '+
    ' ,PES_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,MAR_CODIGO '+
    ' ,CID_IBGE = SUBSTRING(CID_IBGE, 1, 7) '+
    ' ,VEI_DESCRICAO '+
    ' ,VEI_ANO_MODELO '+
    ' ,VEI_NUMEROCHASSI '+
    ' ,VEI_NUMERORENAVAM '+
    ' ,VEI_REGISTRORENAVAM '+
    ' ,VEI_DATAALTERACAO '+
    ' ,VEI_CAPACIDADEM3 '+
    ' ,VEI_CAPACIDADEKG '+
    ' ,VEI_TARAKG '+
    ' ,VEI_RNTRC '+
    ' ,VEI_CIDADE = CID_NOME '+
    ' ,VEI_UF = UFS_SIGLA '+
    ' FROM VEI_00_01 '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = VEI_00_01.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '   ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEI_00_02', 'SELECT COM_CODIGO = 0 '+
    ' ,VEI_CODIGO '+
    ' ,VEI_PLACA '+
    ' ,PES_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,MAR_CODIGO '+
    ' ,CID_IBGE = SUBSTRING(CID_IBGE, 1, 7) '+
    ' ,VEI_DESCRICAO '+
    ' ,VEI_ANO_MODELO '+
    ' ,VEI_NUMEROCHASSI '+
    ' ,VEI_NUMERORENAVAM '+
    ' ,VEI_REGISTRORENAVAM '+
    ' ,VEI_DATAALTERACAO '+
    ' ,VEI_CAPACIDADEM3 '+
    ' ,VEI_CAPACIDADEKG '+
    ' ,VEI_TARAKG '+
    ' ,VEI_RNTRC '+
    ' ,VEI_CIDADE = CID_NOME '+
    ' ,VEI_UF = UFS_SIGLA '+
    ' FROM VEI_00_02 '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = VEI_00_02.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '   ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO ');
    //----------------------------------------------------------------------------
    QueryList.Add('TVEI_00_03', 'SELECT COM_CODIGO = 0 '+
    ' ,VEI_CODIGO '+
    ' ,VEI_PLACA '+
    ' ,PES_CODIGO '+
    ' ,FOR_CODIGO '+
    ' ,MAR_CODIGO '+
    ' ,CID_IBGE = SUBSTRING(CID_IBGE, 1, 7) '+
    ' ,VEI_DESCRICAO '+
    ' ,VEI_ANO_MODELO '+
    ' ,VEI_NUMEROCHASSI '+
    ' ,VEI_NUMERORENAVAM '+
    ' ,VEI_REGISTRORENAVAM '+
    ' ,VEI_DATAALTERACAO '+
    ' ,VEI_CAPACIDADEM3 '+
    ' ,VEI_CAPACIDADEKG '+
    ' ,VEI_TARAKG '+
    ' ,VEI_RNTRC '+
    ' ,VEI_CIDADE = CID_NOME '+
    ' ,VEI_UF = UFS_SIGLA '+
    ' FROM VEI_00_03 '+
    ' LEFT JOIN CID_00 '+
    '   ON CID_00.CID_CODIGO = VEI_00_03.CID_CODIGO '+
    ' LEFT JOIN UFS_00 '+
    '   ON UFS_00.UFS_CODIGO = CID_00.UFS_CODIGO ');
    //----------------------------------------------------------------------------
//    QueryList.Add('TVRS_XX', 'SELECT COM_CODIGO = FIL_CODIGO '+
//    ' ,* '+
//    ' FROM VRS_XX '+
//    ' WHERE VRS_XX.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_CTE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_CTE_00 '+
    ' WHERE XML_CTE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_CTE_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_CTE_00_01 '+
    ' WHERE XML_CTE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_MDFE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_MDFE_00 '+
    ' WHERE XML_MDFE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_MDFE_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_MDFE_00_01 '+
    ' WHERE XML_MDFE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_NFE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_NFE_00 '+
    ' WHERE XML_NFE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_NFE_00_01', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_NFE_00_01 '+
    ' WHERE XML_NFE_00_01.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TXML_NFSE_00', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,* '+
    ' FROM XML_NFSE_00 '+
    ' WHERE XML_NFSE_00.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
     QueryList.Add('TSPEDF_E110', 'SELECT COM_CODIGO = FIL_CODIGO '+
    ' ,COD_E110 '+
    ' ,FIL_CODIGO '+
    ' ,DT_E110 '+
    ' ,VL_TOT_DEBITOS '+
    ' ,VL_AJ_DEBITOS '+
    ' ,VL_TOT_AJ_DEBITOS '+
    ' ,VL_ESTORNOS_CRED '+
    ' ,VL_TOT_CREDITOS '+
    ' ,VL_AJ_CREDITOS '+
    ' ,VL_TOT_AJ_CREDITOS '+
    ' ,VL_ESTORNOS_DEB '+
    ' ,VL_SLD_CREDOR_ANT '+
    ' ,VL_SLD_APURADO '+
    ' ,VL_TOT_DED '+
    ' ,VL_ICMS_RECOLHER '+
    ' ,VL_SLD_CREDOR_TRANSPORTAR '+
    ' ,DEB_ESP '+
    ' ,TIPO '+
    ' FROM SPEDF_E110 '+
    ' WHERE SPEDF_E110.FIL_CODIGO IN (' + FiliaisWhere + ') ');
    //----------------------------------------------------------------------------
    QueryList.Add('TSPEDF_AJUSTE', 'SELECT * FROM SPEDF_AJUSTE');
  end;

end;

class constructor TCoreQuery.Create;
begin
  QueryList := TDictionary<String, String>.Create;
end;

class destructor TCoreQuery.Destroy;
begin
  FreeAndNil(QueryList);
end;

end.
