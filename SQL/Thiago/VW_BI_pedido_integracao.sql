CREATE view VW_BI_pedido_integracao as    
select TBpedido_integracao.DFdata_cadastro    
     , TBpedido_integracao.DFcnpj_origem    
     , TBcliente.DFcod_cliente    
     , tbcliente.DFnome_fantasia    
     , TBitem_pedido_integracao.*    
     , (TBitem_pedido_integracao.DFfator_conversao * TBitem_pedido_integracao.DFqtde_pedida) DFquant_total    
  from TBpedido_integracao    
 inner join TBitem_pedido_integracao    
    on TBpedido_integracao.DFid_pedido_integracao = TBitem_pedido_integracao.DFid_pedido_integracao    
 inner join TBcliente    
    on TBpedido_integracao.DFcnpj_origem = TBcliente.DFcnpj_cpf      
 where TBpedido_integracao.DFstatus in ( 'A','S')    
   and TBcliente.DFcod_cliente < 100 