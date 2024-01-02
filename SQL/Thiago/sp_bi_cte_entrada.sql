USE DBDirector;

IF OBJECT_ID('[dbo].[sp_BI_cte_entrada]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_BI_cte_entrada]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_cte_entrada] 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: NOTA FISCAL
    DATA/HORA..: 14/12/2023          
	FUNÇÃO.....: Criar CSV a partir de query
    
*/

BEGIN TRY
-------------------------------------------------------------------------------------------------------------------
                                                BEGIN TRAN
-------------------------------------------------------------------------------------------------------------------
  DECLARE @bcp_cmd4 VARCHAR(4000);
  DECLARE @query VARCHAR(4000);

  SET @query =  '';
  SET @query =  @query +
      'WITH nf as ( ' +
      ' select tfe.DFnumero as NOTA ' + 
      '     , tfe.DFid_nota_fiscal_entrada ' +
      '     , tfe.DFserie ' +
      '     , tfe.DFvalor_total ' +
      '     , tfe.DFdata_emissao ' +
      '     , tfe.DFdata_entrada ' +
      '     , tbf.DFcod_fornecedor ' +
      '     , tbf.DFnome ' +
      ' from [DBDirector].[dbo].[TBnota_fiscal_entrada] as tfe ' +
      ' inner join [DBDirector].[dbo].[TBfornecedor] as tbf ' +
      '    on tfe.DFcod_fornecedor_emitente = tbf.DFcod_fornecedor ' +
      ' inner join [DBDirector].[dbo].[TBnota_fiscal_entrada_relacionada] as tfer ' +
      '    on tfe.DFid_nota_fiscal_entrada = tfer.DFid_nota_fiscal_entrada_original ' +
      ' ) ' 
      SET @query = @query +
			     ' Select ''0'','+
			     '''CTE'','+
			     '''FORC_CTE'','+
			     '''DFserie'','+
			     '''DFvalor_total'','+
	             '''NOTA'','+
	             '''DFid_nota_fiscal_entrada'','+
  		         '''DFserie'','+
                 '''DFvalor_total'','+
                 '''DFdata_emissao'','+
                 '''DFdata_entrada'','+
                 '''DFcod_fornecedor'','+
		         '''DFnome'' ' + 'union ' +
                 'Select ''1'','+
			     'convert(varchar(20),nfe.DFNumero) as CTE,'+
			     'convert(varchar(20),nfe.DFcod_fornecedor_emitente) as FORC_CTE,'+
			     'convert(varchar(20),nfe.DFserie) as DFserie,'+
			     'convert(varchar(20),nfe.DFvalor_total) as DFvalor_total,'+
	             'convert(varchar(20),nf.NOTA) as NOTA,'+
	             'convert(varchar(20),nf.DFid_nota_fiscal_entrada) as DFid_nota_fiscal_entrada,'+
  		         'convert(varchar(20),nf.DFserie) as DFserie,'+
                 'convert(varchar(20),nf.DFvalor_total) as DFvalor_total,'+
                 'convert(varchar(20),nf.DFdata_emissao) as DFdata_emissao,'+
                 'convert(varchar(20),nf.DFdata_entrada) as DFdata_entrada,'+
                 'convert(varchar(20),nf.DFcod_fornecedor) as DFcod_fornecedor,'+				 				 
                 'nf.DFnome'+	
				 ' from   [DBDirector].[dbo].[TBnota_fiscal_entrada] as nfe ' +
                 'inner  join nf ' +
                  '   on nf.DFid_nota_fiscal_entrada = nfe.DFid_nota_fiscal_entrada ' +
                  'Where nfe.DFid_nota_fiscal_entrada in (select nf.DFid_nota_fiscal_entrada from nf) ' +
                  'and nfe.DFdata_emissao > ''2023-01-01'''

	--print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\cte_entrada.csv" -c -t, -T -S -C ACP';
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