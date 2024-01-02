USE DBDirector;

IF OBJECT_ID('[dbo].[sp_bi_contas_pagar]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_bi_contas_pagar]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_contas_pagar] 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: CONTAS A PAGAR
    DATA/HORA..: 19/12/2023          
	FUNÇÃO.....: Criar CSV a partir de query
    
*/

BEGIN TRY
-------------------------------------------------------------------------------------------------------------------
                                                BEGIN TRAN
-------------------------------------------------------------------------------------------------------------------
  DECLARE @bcp_cmd4 VARCHAR(8000);
  DECLARE @query VARCHAR(8000);

  SET @query =  '';
  SET @query= @query +
	    'Select ''0'','+
	    '''DFcod_empresa'','+
	    '''DFrazao_social'','+
	    '''DFnumero_titulo'','+
	    '''DFcomplemento'','+
	    '''DFserie_nf'','+
	    '''DFdata_emissao'','+
  	    '''DFdata_entrada'','+
        '''DFdata_vencimento'','+
        '''DFdata_pagto'','+
        '''DFdata_baixa'','+
        '''DFdata_conciliacao'','+
        '''DFvalor'','+
	    '''DFvalor_baixa'','+
	    '''valor_conciliado'','+
	    '''DFcod_fornecedor'','+
	    '''DFnome'','+
	    '''DFcod_cliente'','+
  	    '''CLIENTE'','+
        '''DFcod_historico_padrao_pagar'','+
        '''HIST_PADRAO'','+
        '''dfcod_tipo_documento'','+
        '''TIPO_DOC'','+
        '''DFid_centro_custo'','+
	    '''CENTRO_CUSTO'','+
  	    '''DFcod_classe_financeira'','+
        '''CLASSE_FINANCEIRA'','+
        '''NUM_CONTA'','+
        '''DFdigito_verificador'','+
        '''CONTA'' ' + 'union ' 
  SET @query =  @query +
     'Select ''1'','+
  '     convert(varchar(200),tb1.DFcod_empresa) as DFcod_empresa' +
  '   , convert(varchar(200),tb5.DFrazao_social)  as DFrazao_social' +
  '   , convert(varchar(200),tb1.DFnumero_titulo) as DFnumero_titulo' +
  '   , convert(varchar(200),tb1.DFcomplemento) as DFcomplemento' +
  '   , convert(varchar(200),tb1.DFserie_nf) as DFserie_nf' +
  '   , convert(varchar(200),tb1.DFdata_emissao) as DFdata_emissao' +
  '   , convert(varchar(200),tb1.DFdata_entrada) as DFdata_entrada' +
  '   , convert(varchar(200),tb1.DFdata_vencimento) as DFdata_vencimento' +
  '   , convert(varchar(200),tb8.DFdata_pagto) as DFdata_pagto' +
  '   , convert(varchar(200),tb8.DFdata_baixa) as DFdata_baixa' +   
  '   , convert(varchar(200),tb10.DFdata_conciliacao) as DFdata_conciliacao' +
  '   , convert(varchar(200),tb1.DFvalor) as DFvalor' +
  '   , convert(varchar(200),tb8.DFvalor_baixa) as DFvalor_baixa' +
  '   , convert(varchar(200),tb10.DFvalor) as valor_conciliado ' +  
  '   , convert(varchar(200),tb1.DFcod_fornecedor) as DFcod_fornecedor' +
  '   , convert(varchar(200),tb7.DFnome) as DFnome' +
  '   , convert(varchar(200),tb6.DFcod_cliente) as DFcod_cliente' +
  '   , convert(varchar(200),tb6.DFnome) as CLIENTE ' +
  '   , convert(varchar(200),tb1.DFcod_historico_padrao_pagar) as DFcod_historico_padrao_pagar ' +
  '   , convert(varchar(200),tb12.DFdescricao) as HIST_PADRAO ' +
  '   , convert(varchar(200),tb1.dfcod_tipo_documento) as dfcod_tipo_documento ' +
  '   , convert(varchar(200),tb13.DFdescricao) as TIPO_DOC ' +
  '   , convert(varchar(200),tb2.DFid_centro_custo) as DFid_centro_custo ' +
  '   , convert(varchar(200),tb3.DFdescricao) as CENTRO_CUSTO ' +
  '   , convert(varchar(200),tb2.DFcod_classe_financeira) as DFcod_classe_financeira' +
  '   , convert(varchar(200),tb4.DFdescricao) AS CLASSE_FINANCEIRA ' +
  '   , convert(varchar(200),tb11.DFnumero) AS NUM_CONTA ' +
  '   , convert(varchar(200),tb11.DFdigito_verificador) as DFdigito_verificador ' +
  '   , convert(varchar(200),tb11.DFdescricao) AS CONTA ' +
  ' from [DBDirector].[dbo].[TBtitulo_pagar] as tb1 ' +
  'inner join [DBDirector].[dbo].[TBrateio_ccusto_cfinanceira_pagar] as tb2  ' +
  '   on tb1.DFid_titulo_pagar = tb2.DFid_titulo_pagar ' +
  'inner join [DBDirector].[dbo].[TBcentro_custo] as tb3  ' +
  '   on tb2.DFid_centro_custo = tb3.DFid_centro_custo ' +
  'inner join [DBDirector].[dbo].[TBclasse_financeira] as tb4  ' +
  '   on tb2.DFcod_classe_financeira = tb4.DFcod_classe_financeira ' +
  ' left join [DBDirector].[dbo].[TBempresa] as tb5  ' +
  '   on tb1.DFcod_empresa = tb5.DFcod_empresa ' +
  ' left join [DBDirector].[dbo].[TBcliente] as tb6  ' +
  '   on tb1.DFcod_cliente = tb6.DFcod_cliente ' +
  ' left join [DBDirector].[dbo].[TBfornecedor] as tb7  ' +
  '   on tb1.DFcod_fornecedor = tb7.DFcod_fornecedor  ' +
  ' left join [DBDirector].[dbo].[TBtitulo_baixado_pagar] as tb8  ' +
  '   on tb1.DFid_titulo_pagar =  tb8.DFid_titulo_pagar   ' +
  ' left join [DBDirector].[dbo].[TBbaixado_pagar_movto_bancario] as tb9  ' +
  '   on tb8.DFid_titulo_baixado_pagar = tb9.DFid_titulo_baixado_pagar ' +
  ' left join [DBDirector].[dbo].[TBmovimento_bancario] as tb10  ' +
  '   on tb9.DFid_movimento_bancario =  tb10.DFid_movimento_bancario ' +
  ' left join [DBDirector].[dbo].[TBconta] as tb11  ' +
  '   on tb10.DFid_conta = tb11.DFid_conta ' +
  'inner join [DBDirector].[dbo].[TBhistorico_padrao_pagar] as tb12  ' +
  '   on tb1.DFcod_historico_padrao_pagar = tb12.DFcod_historico_padrao_pagar ' +
  'inner join [DBDirector].[dbo].[TBtipo_documento] as tb13  ' +
  '   on tb1.DFcod_tipo_documento = tb13.DFcod_tipo_documento'

    --print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\contas_pagar.csv" -c -t, -T -S -C ACP';
	EXEC master..xp_cmdshell @bcp_cmd4; 

 
-------------------------------------------------------------------------------------------------------------------
                                                 COMMIT TRAN
-------------------------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

		IF (XACT_STATE()) = -1 

			ROLLBACK TRAN 

		ELSE IF (XACT_STATE()) = 1  

			COMMIT TRAN 

		DECLARE @ERRO VARCHAR(MAX)
		SET @ERRO = ERROR_MESSAGE()
		RAISERROR( @ERRO, 16, 1 )

END CATCH

END	