USE DBDirector;

IF OBJECT_ID('[dbo].[sp_bi_nf_item_saida]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_bi_nf_item_saida]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_nf_item_saida] 

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
	    '''DFnumero'','+
	    '''DFserie'','+
	    '''DFvalor_total'','+
	    '''DFcod_parametro_nota_fiscal_saida'','+
	    '''PARAMETRO'','+
	    '''DFestoque_operacao'','+
  	    '''DFcodigo_cfo'','+
        '''CFOP'','+
        '''NATUREZA'','+
        '''DFdata_emissao'','+
        '''DFdata_saida'','+
	    '''DFcod_plano_pagamento'','+
	    '''PLANO'','+
	    '''DFcod_fornecedor_destinatario'','+
	    '''DFnome'','+
	    '''DFcod_cliente_destinatario'','+
  	    '''cliente'','+
        '''DFcod_empresa_destinatario'','+
        '''DFrazao_social'','+
        '''DFcod_item_estoque'','+
        '''item'','+
        '''DFvalor_unitario'','+
        '''DFqtde'','+
        '''DFvalor_desconto'','+
        '''DFvalor_total'','+
        '''DFcod_tributacao_st'','+
        '''DFaliquota_ipi'','+
        '''DFvalor_ipi'','+
        '''DFaliquota_icms'','+
        '''DFvalor_icms'','+
        '''DFpercentual_calculo_st'','+
        '''DFbase_st'','+
        '''DFvalor_imposto_retido'' ' + 'union ' 
  SET @query =  @query +
     'Select ''1'','+
  '     convert(varchar(200),COALESCE(tb1.DFnumero, '''')) as DFnumero' +
  '   , convert(varchar(200),COALESCE(tb1.DFserie, ''''))  as DFserie' +
  '   , convert(varchar(200),COALESCE(tb1.DFvalor_total, '''')) as DFvalor_total' +
  '   , convert(varchar(200),COALESCE(tb13.DFcod_parametro_nota_fiscal_saida, '''')) as DFcod_parametro_nota_fiscal_saida' +
  '   , convert(varchar(200),COALESCE(tb12.DFdescricao, '''')) as PARAMETRO' +
  '   , convert(varchar(200),COALESCE(tb12.DFestoque_operacao, '''')) as DFestoque_operacao' +
  '   , convert(varchar(200),COALESCE(tb6.DFcodigo_cfo, '''')) as DFcodigo_cfo' +
  '   , convert(varchar(200),COALESCE(tb6.DFdescricao, '''')) as CFOP' +
  '   , convert(varchar(200),COALESCE(tb7.DFdescricao, '''')) as NATUREZA' +   
  '   , convert(varchar(200),COALESCE(tb1.DFdata_emissao, '''')) as DFdata_emissao' +
  '   , convert(varchar(200),COALESCE(tb1.DFdata_saida, '''')) as DFdata_saida' +
  '   , convert(varchar(200),COALESCE(tb8.DFcod_plano_pagamento, '''')) as DFcod_plano_pagamento ' +  
  '   , convert(varchar(200),COALESCE(tb8.DFdescricao, '''')) as PLANO' +
  '   , convert(varchar(200),COALESCE(tb1.DFcod_fornecedor_destinatario, '''')) as DFcod_fornecedor_destinatario' +
  '   , convert(varchar(200),COALESCE(tb3.DFnome, '''')) as DFnome' +
  '   , convert(varchar(200),COALESCE(tb1.DFcod_cliente_destinatario, '''')) as DFcod_cliente_destinatario ' +
  '   , convert(varchar(200),COALESCE(tb4.DFnome, '''')) as cliente ' +
  '   , convert(varchar(200),COALESCE(tb1.DFcod_empresa_destinatario, '''')) as DFcod_empresa_destinatario ' +
  '   , convert(varchar(200),COALESCE(tb5.DFrazao_social, '''')) as DFrazao_social ' +
  '   , convert(varchar(200),COALESCE(tb10.DFcod_item_estoque, '''')) as DFcod_item_estoque ' +
  '   , convert(varchar(200),COALESCE(tb10.DFdescricao, '''')) as item ' +
  '   , convert(varchar(200),COALESCE(tb2.DFpreco_unitario, '''')) as DFpreco_unitario ' +
  '   , convert(varchar(200),COALESCE(tb2.DFqtde, '''')) as DFqtde' +
  '   , convert(varchar(200),COALESCE(tb2.DFvalor_desconto, '''')) as DFvalor_desconto' +
  '   , convert(varchar(200),COALESCE(tb2.DFvalor_total, '''')) as DFvalor_total' +
  '   , convert(varchar(200),COALESCE(tb2.DFcod_tributacao_st, '''')) as DFcod_tributacao_st' +
  '   , convert(varchar(200),COALESCE(tb2.DFaliquota_ipi, '''')) as DFaliquota_ipi' +
  '   , convert(varchar(200),COALESCE(tb2.DFvalor_ipi, '''')) as DFvalor_ipi' +
  '   , convert(varchar(200),COALESCE(tb2.DFaliquota_icms, '''')) as DFaliquota_icms' +
  '   , convert(varchar(200),COALESCE(tb2.DFvalor_icms, '''')) as DFvalor_icms' +
  '   , convert(varchar(200),COALESCE(tb2.DFpercentual_calculo_st, '''')) as DFpercentual_calculo_st' +
  '   , convert(varchar(200),COALESCE(tb2.DFbase_st, '''')) as DFbase_st' +
  '   , convert(varchar(200),COALESCE(tb2.DFvalor_imposto_retido, '''')) as DFvalor_imposto_retido' +
  ' from [DBDirector].[dbo].[TBnota_fiscal_saida] as tb1 ' +
  'inner join [DBDirector].[dbo].[TBitem_nota_fiscal_saida] as tb2 ' +
  '  on tb1.DFid_nota_fiscal_saida = tb2.DFid_nota_fiscal_saida ' +
  'inner join  [DBDirector].[dbo].[TBnota_fiscal_saida_atacado_varejo] as tb13 ' +
  '  on tb1.DFid_nota_fiscal_saida =  tb13.DFid_nota_fiscal_saida ' +   
  'left join [DBDirector].[dbo].[TBfornecedor] as tb3 ' +
  '  on tb1.DFcod_fornecedor_destinatario =  tb3.DFcod_fornecedor ' +
  ' left join [DBDirector].[dbo].[TBcliente] as tb4 ' +
  '  on tb1.DFcod_cliente_destinatario = tb4.DFcod_cliente ' +
  ' left join [DBDirector].[dbo].[TBempresa] as tb5 ' +
  '  on tb1.DFcod_empresa_destinatario = tb5.DFcod_empresa ' +
  'inner join [DBDirector].[dbo].[TBcodigo_fiscal_operacao] as tb6 ' +
  '  on tb1.DFid_codigo_cfo = tb6.DFid_codigo_cfo ' +
  'inner join [DBDirector].[dbo].[TBnatureza_operacao] as tb7 ' +
  '  on tb6.DFcod_natureza_operacao = tb7.DFcod_natureza_operacao ' +
  'inner join [DBDirector].[dbo].[TBplano_pagamento] as tb8 ' +
  '  on tb13.DFcod_plano_pagamento = tb8.DFcod_plano_pagamento ' + 
  'inner join [DBDirector].[dbo].[TBunidade_item_estoque] as tb9 ' +
  '  on tb2.DFid_unidade_item_estoque = tb9.DFid_unidade_item_estoque ' +
  'inner join [DBDirector].[dbo].[TBitem_estoque] as tb10 ' +
  '  on tb9.DFcod_item_estoque = tb10.DFcod_item_estoque ' +  
  'inner join [DBDirector].[dbo].[TBunidade] as tb11 ' +
  '  on tb9.DFcod_unidade = tb11.DFcod_unidade ' +
  'inner join [DBDirector].[dbo].[TBparametro_nota_fiscal_saida] as tb12 ' +
  '  on tb13.DFcod_parametro_nota_fiscal_saida = tb12.DFcod_parametro_nota_fiscal_saida' +    
  'where tb1.DFdata_emissao > ''2023-01-01''' 

    --print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\nf_item_saida.csv" -c -t, -T -S -C ACP';
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