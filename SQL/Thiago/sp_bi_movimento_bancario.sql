USE DBDirector;

IF OBJECT_ID('[dbo].[sp_bi_movimento_bancario]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_bi_movimento_bancario]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_movimento_bancario] 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: MOVIMENTO BANCÁRIO
    DATA/HORA..: 20/12/2023          
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
	    '''cod_client_receb'','+
	    '''cod_forn_receber'','+
	    '''receber'','+
	    '''compl'','+
  	    '''serie'','+
        '''dfcod_cliente'','+
        '''DFcod_fornecedor'','+
        '''DFnumero_titulo'','+
        '''DFcomplemento'','+
        '''DFserie_nf'','+
	    '''DFnumero_documento'','+
	    '''DFvalor'','+
	    '''DFdata_emissao'','+
	    '''DFdata_vencimento'','+
	    '''DFdata_conciliacao'','+
  	    '''DFcod_tipo_documento'','+
        '''DFdescricao'','+
        '''DFcod_historico_movto_bancario'','+
        '''hist_padrao'','+
        '''DFnumero'','+
        '''Conta'','+
        '''DFcomplemento_historico'' ' +         
        '''DFcod_classe_financeira'' ' +
        '''CLASSE'' ' + 'union ' 
  SET @query =  @query +
     'Select ''1'','+
  '     convert(varchar(200),tb1.DFcod_empresa) as DFcod_empresa' +
  '   , convert(varchar(200),tb5.DFrazao_social)  as DFrazao_social' +
  '   , convert(varchar(200),tb11.DFcod_cliente) as cod_client_receb' +
  '   , convert(varchar(200),tb11.DFcod_fornecedor) as cod_forn_receber' +
  '   , convert(varchar(200),tb11.DFnumero_titulo) as receber' +
  '   , convert(varchar(200),tb11.DFcomplemento) as compl' +
  '   , convert(varchar(200),tb11.DFserie_nf) as serie' +
  '   , convert(varchar(200),tb10.DFcod_cliente) as DFcod_cliente' +
  '   , convert(varchar(200),tb10.DFcod_fornecedor) as DFcod_fornecedor' +   
  '   , convert(varchar(200),tb10.DFnumero_titulo) as DFnumero_titulo' +
  '   , convert(varchar(200),tb10.DFcomplemento) as DFcomplemento' +
  '   , convert(varchar(200),tb10.DFserie_nf) as DFserie_nf' +
  '   , convert(varchar(200),tb1.DFnumero_documento) as DFnumero_documento ' +  
  '   , convert(varchar(200),tb1.DFvalor) as DFvalor' +
  '   , convert(varchar(200),tb1.DFdata_emissao) as DFdata_emissao' +
  '   , convert(varchar(200),tb1.DFdata_vencimento) as DFdata_vencimento' +
  '   , convert(varchar(200),tb1.DFdata_conciliacao) as DFdata_conciliacao ' +
  '   , convert(varchar(200),tb3.DFcod_tipo_documento) as DFcod_tipo_documento ' +
  '   , convert(varchar(200),tb3.DFdescricao) as DFdescricao ' +
  '   , convert(varchar(200),tb4.DFcod_historico_movto_bancario) as DFcod_historico_movto_bancario ' +
  '   , convert(varchar(200),tb4.DFdescricao) as hist_padrao ' +
  '   , convert(varchar(200),tb2.DFnumero) as DFnumero ' +
  '   , convert(varchar(200),tb2.DFdescricao) as Conta ' +
  '   , convert(varchar(200),tb1.DFcomplemento_historico) as DFcomplemento_historico' +  
  '   , convert(varchar(200),tb13.DFcod_classe_financeira' +
  '   , convert(varchar(200),tb13.DFdescricao as CLASSE' +
  ' from [DBDirector].[dbo].[tbmovimento_bancario] as tb1 ' +
  'inner join [DBDirector].[dbo].[TBconta] as tb2  ' +
  '   on tb1.DFid_conta = tb2.DFid_conta ' +
  'inner join [DBDirector].[dbo].[TBtipo_documento] as tb3  ' +
  '   on tb1.DFcod_tipo_documento = tb3.DFcod_tipo_documento ' +
  'inner join [DBDirector].[dbo].[TBhistorico_padrao_movto_bancario] as tb4  ' +
  '   on tb1.DFcod_historico_movto_bancario = tb4.DFcod_historico_movto_bancario ' +
  ' left join [DBDirector].[dbo].[TBempresa] as tb5  ' +
  '   on tb1.DFcod_empresa = tb5.DFcod_empresa ' +
  ' left join [DBDirector].[dbo].[TBbaixado_pagar_movto_bancario] as tb6  ' +
  '   on tb1.DFid_movimento_bancario = tb6.DFid_movimento_bancario ' +
  ' left join [DBDirector].[dbo].[TBbaixado_receber_movto_bancario] as tb7  ' +
  '   on tb1.DFid_movimento_bancario = tb7.DFid_movimento_bancario  ' +
  ' left join [DBDirector].[dbo].[TBtitulo_baixado_pagar] as tb8  ' +
  '   on tb6.DFid_titulo_baixado_pagar = tb8.DFid_titulo_baixado_pagar   ' +
  ' left join [DBDirector].[dbo].[TBtitulo_baixado_receber] as tb9  ' +
  '   on tb7.DFid_titulo_baixado_receber = tb9.DFid_titulo_baixado_receber ' +
  ' left join [DBDirector].[dbo].[TBtitulo_pagar] as tb10  ' +
  '   on tb8.DFid_titulo_pagar = tb10.DFid_titulo_pagar ' +
  ' left join [DBDirector].[dbo].[TBtitulo_receber] as tb11  ' +
  '   on tb9.DFid_titulo_receber = tb11.DFid_titulo_receber ' +
  ' inner join [DBDirector].[dbo].[TBrateio_ccusto_cfinanceira_movto_bancario] as tb12  ' +
  '   on tb1.DFid_movimento_bancario = tb12.DFid_movimento_bancario ' +
  ' inner join [DBDirector].[dbo].[TBclasse_financeira] as tb13  ' +
  '   on tb13.DFcod_classe_financeira = TBclasse_financeira.DFcod_classe_financeira ' + 
  'where tb1.DFdata_emissao > ''2023-01-01'''


    --print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\movimento_bancario.csv" -c -t, -T -S -C ACP';
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