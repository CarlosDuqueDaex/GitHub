     
select TBpedido_integracao.DFdata_cadastro      
     , TBpedido_integracao.DFcnpj_origem      
     , TBcliente.DFcod_cliente      
     , tbcliente.DFnome_fantasia  
     , TBitem_pedido_integracao.DFid_item_pedido_integracao
     , TBpedido_integracao.DFid_pedido_integracao    
     , TBitem_estoque.DFcod_item_estoque
     , TBitem_estoque.DFdescricao as ITEM
     , TBitem_pedido_integracao.DFpartnumber
     , TBunidade.DFdescricao as UND
     , TBitem_pedido_integracao.DFqtde_pedida
     , TBunidade_item_estoque.DFfator_conversao
     , TBunidade_item_estoque.DFid_unidade_item_estoque
     , (TBitem_pedido_integracao.DFfator_conversao * TBitem_pedido_integracao.DFqtde_pedida) DFquant_total      
  from TBpedido_integracao      
 inner join TBitem_pedido_integracao      
    on TBpedido_integracao.DFid_pedido_integracao = TBitem_pedido_integracao.DFid_pedido_integracao      
 inner join TBcliente      
    on TBpedido_integracao.DFcnpj_origem = TBcliente.DFcnpj_cpf   
 inner join TBunidade_item_estoque
    on TBitem_pedido_integracao.DFid_unidade_item_estoque = TBunidade_item_estoque.DFid_unidade_item_estoque
 inner join TBitem_estoque
    on TBunidade_item_estoque.DFcod_item_estoque = TBitem_estoque.DFcod_item_estoque   
 inner join TBunidade
    on TBunidade_item_estoque.DFcod_unidade = TBunidade.DFcod_unidade
 where TBpedido_integracao.DFstatus in ( 'A', 'S')      
   and TBcliente.DFcod_cliente < 100