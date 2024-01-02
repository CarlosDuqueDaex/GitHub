

select TBnota_fiscal_saida.DFnumero
     , TBnota_fiscal_saida.DFserie
     , TBnota_fiscal_saida.DFvalor_total
     , TBnota_fiscal_saida_atacado_varejo.DFcod_parametro_nota_fiscal_saida
     , TBparametro_nota_fiscal_saida.DFdescricao as PARAMETRO
     , TBparametro_nota_fiscal_saida.DFestoque_operacao
     , TBcodigo_fiscal_operacao.DFcodigo_cfo
     , TBcodigo_fiscal_operacao.DFdescricao as CFOP
     , TBnatureza_operacao.DFdescricao as NATUREZA
     , TBnota_fiscal_saida.DFdata_emissao
     , TBnota_fiscal_saida.DFdata_saida
     , TBplano_pagamento.DFcod_plano_pagamento
     , TBplano_pagamento.DFdescricao as PLANO
     , TBnota_fiscal_saida.DFcod_fornecedor_destinatario
     , TBfornecedor.DFnome
     , TBnota_fiscal_saida.DFcod_cliente_destinatario
     , TBcliente.DFnome as cliente
     , TBnota_fiscal_saida.DFcod_empresa_destinatario
     , TBempresa.DFrazao_social
     , TBitem_estoque.DFcod_item_estoque
     , TBitem_estoque.DFdescricao as item
     , TBitem_nota_fiscal_saida.DFpreco_unitario
     , TBitem_nota_fiscal_saida.DFqtde
     , TBitem_nota_fiscal_saida.DFvalor_desconto
     , TBitem_nota_fiscal_saida.DFvalor_total
     , TBitem_nota_fiscal_saida.DFcod_tributacao_st
     , TBitem_nota_fiscal_saida.DFaliquota_ipi
     , TBitem_nota_fiscal_saida.DFvalor_ipi
     , TBitem_nota_fiscal_saida.DFaliquota_icms
     , TBitem_nota_fiscal_saida.DFvalor_icms
     , TBitem_nota_fiscal_saida.DFpercentual_calculo_st
     , TBitem_nota_fiscal_saida.DFbase_st
     , TBitem_nota_fiscal_saida.DFvalor_imposto_retido
  from TBnota_fiscal_saida
 inner join TBitem_nota_fiscal_saida
    on TBnota_fiscal_saida.DFid_nota_fiscal_saida = TBitem_nota_fiscal_saida.DFid_nota_fiscal_saida
 inner join TBnota_fiscal_saida_atacado_varejo
    on TBnota_fiscal_saida.DFid_nota_fiscal_saida =  TBnota_fiscal_saida_atacado_varejo.DFid_nota_fiscal_saida 
 left join TBfornecedor
    on TBnota_fiscal_saida.DFcod_fornecedor_destinatario =  TBfornecedor.DFcod_fornecedor
 left join TBcliente
    on TBnota_fiscal_saida.DFcod_cliente_destinatario = TBcliente.DFcod_cliente
 left join TBempresa
    on TBnota_fiscal_saida.DFcod_empresa_destinatario = TBempresa.DFcod_empresa
 inner join TBcodigo_fiscal_operacao
    on TBnota_fiscal_saida.DFid_codigo_cfo = TBcodigo_fiscal_operacao.DFid_codigo_cfo
 inner join TBnatureza_operacao
    on TBcodigo_fiscal_operacao.DFcod_natureza_operacao = TBnatureza_operacao.DFcod_natureza_operacao
 inner join TBplano_pagamento
    on TBnota_fiscal_saida_atacado_varejo.DFcod_plano_pagamento = TBplano_pagamento.DFcod_plano_pagamento 
 inner join TBunidade_item_estoque
    on TBitem_nota_fiscal_saida.DFid_unidade_item_estoque = TBunidade_item_estoque.DFid_unidade_item_estoque
 inner join TBitem_estoque
    on TBunidade_item_estoque.DFcod_item_estoque = TBitem_estoque.DFcod_item_estoque  
 inner join TBunidade
    on TBunidade_item_estoque.DFcod_unidade = TBunidade.DFcod_unidade
 inner join TBparametro_nota_fiscal_saida
    ON TBnota_fiscal_saida_atacado_varejo.DFcod_parametro_nota_fiscal_saida = TBparametro_nota_fiscal_saida.DFcod_parametro_nota_fiscal_saida