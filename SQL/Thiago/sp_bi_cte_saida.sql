USE DBDirector;

IF OBJECT_ID('[dbo].[sp_bi_cte_saida]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_bi_cte_saida]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_cte_saida] 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: CTE_SAIDA
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
	    '''DFid_conhecimento_transporte'','+
	    '''DFexpedidor'','+
	    '''serie_cte'','+
	    '''DFvalor_receber'','+        
	    '''DFnumero'','+
	    '''ID_CTE'','+
	    '''DFserie'','+
  	    '''DFvalor_total'','+
        '''DFdata_emissao'','+
        '''DFdata_saida'','+
        '''DFcod_cliente'','+
        '''DFnome'' ' + 'union ' 
  SET @query =  @query +
     'Select ''1'','+
  '     convert(varchar(200),tb1.DFid_conhecimento_transporte) as DFid_conhecimento_transporte' +
  '   , convert(varchar(200),tb1.DFexpedidor)  as DFexpedidor' +
  '   , '''' as serie_cte' +
  '   , convert(varchar(200),tb1.DFvalor_receber) as DFvalor_receber' +
  '   , convert(varchar(200),tb2.DFnumero) as DFnumero' +
  '   , '''' as ID_CTE' +
  '   , convert(varchar(200),tb2.DFserie) as DFserie' +
  '   , convert(varchar(200),tb2.DFvalor_total) as DFvalor_total' +
  '   , convert(varchar(200),tb2.DFdata_emissao) as DFdata_emissao' +
  '   , convert(varchar(200),tb2.DFdata_saida) as DFdata_saida' +   
  '   , convert(varchar(200),tb3.DFcod_cliente) as DFcod_cliente' +
  '   , convert(varchar(200),tb3.DFnome) as DFnome' +
  ' from [DBDirector].[dbo].[TBconhecimento_transporte] as tb1 ' +
  'inner join [DBDirector].[dbo].[TBnota_fiscal_saida] as tb2  ' +
  '   on tb1.DFid_nota_fiscal_saida = tb2.DFid_nota_fiscal_saida ' +
  'inner join [DBDirector].[dbo].[TBcliente] as tb3  ' +
  '   on tb2.DFcod_cliente_destinatario = tb3.DFcod_cliente ' +
  'where tb2.DFdata_emissao > ''2023-01-01'''

    --print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\cte_saida.csv" -c -t, -T -S -C ACP';
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