

select TBnota_fiscal_entrada.DFnumero
     , TBnota_fiscal_entrada.DFserie
     , TBnota_fiscal_entrada.DFvalor_total
     , TBnota_fiscal_entrada.DFcod_parametro_nota_fiscal_entrada
     , TBparametro_nota_fiscal_entrada.DFdescricao as PARAMETRO
     , TBparametro_nota_fiscal_entrada.DFestoque_operacao
     , TBcodigo_fiscal_operacao.DFcodigo_cfo
     , TBcodigo_fiscal_operacao.DFdescricao as CFOP
     , TBnatureza_operacao.DFdescricao as NATUREZA
     , TBnota_fiscal_entrada.DFdata_emissao
     , TBnota_fiscal_entrada.DFdata_entrada
     , TBnota_fiscal_entrada.DFdata_lancamento
     , TBplano_pagamento.DFcod_plano_pagamento
     , TBplano_pagamento.DFdescricao as PLANO
     , TBnota_fiscal_entrada.DFcod_fornecedor_emitente
     , TBfornecedor.DFnome
     , TBnota_fiscal_entrada.DFcod_cliente_emitente
     , TBcliente.DFnome as cliente
     , TBnota_fiscal_entrada.DFcod_empresa_emitente
     , TBempresa.DFrazao_social
     , TBitem_estoque.DFcod_item_estoque
     , TBitem_estoque.DFdescricao as item
     , TBitem_nota_fiscal_entrada.DFvalor_unitario
     , TBitem_nota_fiscal_entrada.DFqtde
     , TBitem_nota_fiscal_entrada.DFvalor_desconto
     , TBitem_nota_fiscal_entrada.DFvalor_total
     , TBitem_nota_fiscal_entrada.DFcod_tributacao_st
     , TBitem_nota_fiscal_entrada.DFaliquota_ipi
     , TBitem_nota_fiscal_entrada.DFvalor_ipi
     , TBitem_nota_fiscal_entrada.DFaliquota_icms
     , TBitem_nota_fiscal_entrada.DFvalor_icms
     , TBitem_nota_fiscal_entrada.DFpercentual_calculo_st
     , TBitem_nota_fiscal_entrada.DFbase_st
     , TBitem_nota_fiscal_entrada.DFvalor_imposto_retido
  from TBnota_fiscal_entrada
 inner join TBitem_nota_fiscal_entrada
    on TBnota_fiscal_entrada.DFid_nota_fiscal_entrada = TBitem_nota_fiscal_entrada.DFid_nota_fiscal_entrada
 left join TBfornecedor
    on TBnota_fiscal_entrada.DFcod_fornecedor_emitente =  TBfornecedor.DFcod_fornecedor
 left join TBcliente
    on TBnota_fiscal_entrada.DFcod_cliente_emitente = TBcliente.DFcod_cliente
 left join TBempresa
    on TBnota_fiscal_entrada.DFcod_empresa_emitente = TBempresa.DFcod_empresa
 inner join TBcodigo_fiscal_operacao
    on TBnota_fiscal_entrada.DFid_codigo_cfo = TBcodigo_fiscal_operacao.DFid_codigo_cfo
 inner join TBnatureza_operacao
    on TBcodigo_fiscal_operacao.DFcod_natureza_operacao = TBnatureza_operacao.DFcod_natureza_operacao
 inner join TBplano_pagamento
    on TBnota_fiscal_entrada.DFcod_plano_pagamento = TBplano_pagamento.DFcod_plano_pagamento 
 inner join TBunidade_item_estoque
    on TBitem_nota_fiscal_entrada.DFid_unidade_item_estoque = TBunidade_item_estoque.DFid_unidade_item_estoque
 inner join TBitem_estoque
    on TBunidade_item_estoque.DFcod_item_estoque = TBitem_estoque.DFcod_item_estoque  
 inner join TBunidade
    on TBunidade_item_estoque.DFcod_unidade = TBunidade.DFcod_unidade
 inner join TBparametro_nota_fiscal_entrada
    on TBnota_fiscal_entrada.DFcod_parametro_nota_fiscal_entrada = TBparametro_nota_fiscal_entrada.DFcod_parametro_nota_fiscal_entrada
   