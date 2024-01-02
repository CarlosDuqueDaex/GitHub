USE DBDirector;

IF OBJECT_ID('[dbo].[sp_bi_ocorrencia_estoque]') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_bi_ocorrencia_estoque]; 
GO

CREATE PROCEDURE [dbo].[sp_bi_ocorrencia_estoque] 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: OCORRENCIA ESTOQUE
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
	    '''DFdata_alteracao'','+
	    '''DFcod_item_estoque'','+
	    '''item'','+
	    '''DFdescricao'','+
	    '''DFfator_conversao'','+
	    '''Motivo'','+
  	    '''DFnome_usuario'','+
        '''DFcusto_real'','+
        '''tipo_estoque'','+
        '''quant_anterior'','+
        '''DFquantidade_movimentada'','+
        '''Dfquantidade_Atual'','+        
        '''DFcomplemento'' ' + 'union ' 
  SET @query =  @query +
     'Select ''1'','+
  '     convert(varchar(200),tb1.DFdata_alteracao) as DFdata_alteracao' +
  '   , convert(varchar(200),tb2.DFcod_item_estoque)  as DFcod_item_estoque' +
  '   , convert(varchar(200),tb3.DFdescricao)  as item' +
  '   , convert(varchar(200),tb4.DFdescricao) as DFdescricao' +
  '   , convert(varchar(200),tb2.DFfator_conversao) as DFfator_conversao' +
  '   , convert(varchar(200),tb7.DFdescricao) as Motivo' +
  '   , convert(varchar(200),tb5.DFnome_usuario) as DFnome_usuario' +
  '   , convert(varchar(200),tb1.DFcusto_real) as DFcusto_real' +
  '   , convert(varchar(200),tb6.DFdescricao) as tipo_estoque' +
  '   , convert(varchar(200),tb1.Dfquantidade_Atual + tb1.DFquantidade_movimentada) as quant_anterior' +   
  '   , convert(varchar(200),tb1.DFquantidade_movimentada) as DFquantidade_movimentada' +
  '   , convert(varchar(200),tb1.Dfquantidade_Atual) as Dfquantidade_Atual' +
  '   , convert(varchar(200),tb1.DFcomplemento) as DFcomplemento' +
  ' from [DBDirector].[dbo].[TBhistorico_estoque] as tb1 ' +
  'inner join [DBDirector].[dbo].[TBunidade_item_estoque] as tb2 ' +
  '   on tb1.DFid_unidade_item_estoque = tb2.DFid_unidade_item_estoque ' +
  'inner join [DBDirector].[dbo].[TBitem_estoque] as tb3 ' +
  '   on tb2.DFcod_item_estoque = tb3.DFcod_item_estoque ' +
  'inner join [DBDirector].[dbo].[TBunidade] as tb4 ' +
  '   on tb2.DFcod_unidade = tb4.DFcod_unidade ' +
  'inner join [DBDirector].[dbo].[TBusuario] as tb5 ' +
  '   on tb1.DFid_usuario = tb5.DFid_usuario ' +
  'inner join [DBDirector].[dbo].[TBtipo_estoque] as tb6 ' +
  '   on tb1.DFid_tipo_estoque = tb6.DFid_tipo_estoque ' +
  'inner join [DBDirector].[dbo].[TBmotivo_movto_endereco] as tb7 ' +
  '   on tb1.DFcod_motivo_movto_endereco = tb7.DFcod_motivo_movto_endereco'

     --print @query;
	SET @bcp_cmd4 = 'bcp "' + @query + '" queryout "\\192.168.0.6\bi\ocorrencia_estoque.csv" -c -t, -T -S -C ACP';
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