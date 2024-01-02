
select TBhistorico_estoque.DFdata_alteracao
     , TBitem_estoque.DFcod_item_estoque
     , TBitem_estoque.DFdescricao as item
     , TBunidade.DFdescricao
     , TBunidade_item_estoque.DFfator_conversao
     , TBmotivo_movto_endereco.DFdescricao as Motivo
     , TBusuario.DFnome_usuario
     , TBhistorico_estoque.DFcusto_real
     , TBtipo_estoque.DFdescricao as tipo_estoque
     , TBhistorico_estoque.Dfquantidade_Atual + TBhistorico_estoque.DFquantidade_movimentada as quant_anterior
     , TBhistorico_estoque.DFquantidade_movimentada
     , TBhistorico_estoque.Dfquantidade_Atual
     , TBhistorico_estoque.DFcomplemento
  from TBhistorico_estoque
 inner join TBunidade_item_estoque
    on TBhistorico_estoque.DFid_unidade_item_estoque = TBunidade_item_estoque.DFid_unidade_item_estoque
 inner join TBitem_estoque
    on TBunidade_item_estoque.DFcod_item_estoque = TBitem_estoque.DFcod_item_estoque
 inner join TBunidade
    on TBunidade_item_estoque.DFcod_unidade = TBunidade.DFcod_unidade
 inner join TBusuario
    on TBhistorico_estoque.DFid_usuario = TBusuario.DFid_usuario
 inner join TBtipo_estoque
    on TBhistorico_estoque.DFid_tipo_estoque = TBtipo_estoque.DFid_tipo_estoque
 inner join TBmotivo_movto_endereco
    on TBhistorico_estoque.DFcod_motivo_movto_endereco = TBmotivo_movto_endereco.DFcod_motivo_movto_endereco
 
 
 