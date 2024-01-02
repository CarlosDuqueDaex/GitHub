USE DBDirector;

IF OBJECT_ID('[dbo].[sp_bi_pedido_integracao]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_bi_pedido_integracao]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_pedido_integracao] 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: PEDIDO INTEGRACAO
    DATA/HORA..: 19/12/2023          
	  FUNÇÃO.....: Criar CSV a partir de view
    
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
	    '''DFdata_cadastro'','+
	    '''DFcnpj_origem'','+
	    '''DFcod_cliente'','+
	    '''DFnome_fantasia'','+
	    '''DFid_item_pedido_integracao'','+
	    '''DFid_pedido_integracao'','+
  	  '''DFcod_item_estoque'','+
      '''ITEM'','+
      '''DFpartnumber'','+
      '''UND'','+
      '''DFqtde_pedida'','+
      '''DFfator_conversao'','+    
      '''DFid_unidade_item_estoque'','+               
      '''DFquant_total'' ' + 'union ' 
  SET @query =  @query +
     'Select ''1'','+
  '     convert(varchar(200),tb1.DFdata_cadastro) as DFdata_cadastro' +
  '   , convert(varchar(200),tb1.DFcnpj_origem)  as DFcnpj_origem' +
  '   , convert(varchar(200),tb3.DFcod_cliente)  as DFcod_cliente' +
  '   , convert(varchar(200),tb3.DFnome_fantasia) as DFnome_fantasia' +
  '   , convert(varchar(200),tb2.DFid_item_pedido_integracao) as DFid_item_pedido_integracao' +
  '   , convert(varchar(200),tb1.DFid_pedido_integracao) as DFid_pedido_integracao' +
  '   , convert(varchar(200),tb5.DFcod_item_estoque) as DFcod_item_estoque' +
  '   , convert(varchar(200),tb5.DFdescricao) as ITEM' +
  '   , convert(varchar(200),tb2.DFpartnumber) as DFpartnumber' +
  '   , convert(varchar(200),tb6.DFdescricao) as UND' +
  '   , convert(varchar(200),tb2.DFqtde_pedida) as DFqtde_pedida' +   
  '   , convert(varchar(200),tb4.DFfator_conversao) as DFfator_conversao' +
  '   , convert(varchar(200),tb4.DFid_unidade_item_estoque) as DFid_unidade_item_estoque' +
  '   , convert(varchar(200),tb2.DFfator_conversao * tb2.DFqtde_pedida) as DFquant_total' +
  ' from [DBDirector].[dbo].[TBpedido_integracao] as tb1 ' +    
  'inner join [DBDirector].[dbo].[TBitem_pedido_integracao] as tb2 ' +   
  '   on tb2.DFid_pedido_integracao = tb1.DFid_pedido_integracao ' +    
  'inner join [DBDirector].[dbo].[TBcliente] as tb3 ' +    
  '   on tb1.DFcnpj_origem = tb3.DFcnpj_cpf ' +      
  'inner join [DBDirector].[dbo].[TBunidade_item_estoque] as tb4 ' + 
  '   on tb2.DFid_unidade_item_estoque = tb4.DFid_unidade_item_estoque ' +
  'inner join [DBDirector].[dbo].[TBitem_estoque] as tb5 ' + 
  '   on tb4.DFcod_item_estoque = tb5.DFcod_item_estoque ' +  
  'inner join [DBDirector].[dbo].[TBunidade] as tb6 ' + 
  '   on tb4.DFcod_unidade = tb6.DFcod_unidade ' +
  'where tb1.DFstatus in ( ''A'',''S'') ' +    
  '  and tb3.DFcod_cliente < 100'

     --print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\pedido_integracao.csv" -c -t, -T -S -C ACP';
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