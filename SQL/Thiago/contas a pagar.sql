select TBtitulo_pagar.DFcod_empresa
     , TBempresa.DFrazao_social
     , TBtitulo_pagar.DFnumero_titulo
     , TBtitulo_pagar.DFcomplemento
     , TBtitulo_pagar.DFserie_nf
     , TBtitulo_pagar.DFdata_emissao
     , TBtitulo_pagar.DFdata_entrada
     , TBtitulo_pagar.DFdata_vencimento
     , TBtitulo_baixado_pagar.DFdata_pagto
     , TBtitulo_baixado_pagar.DFdata_baixa   
     , TBmovimento_bancario.DFdata_conciliacao
     , TBtitulo_pagar.DFvalor
     , TBtitulo_baixado_pagar.DFvalor_baixa
     , TBmovimento_bancario.DFvalor as valor_conciliado  
     , TBtitulo_pagar.DFcod_fornecedor
     , TBfornecedor.DFnome
     , TBtitulo_pagar.DFcod_cliente
     , TBcliente.DFnome as CLIENTE
     , TBtitulo_pagar.DFcod_historico_padrao_pagar
     , TBhistorico_padrao_pagar.DFdescricao as HIST_PADRAO
     , TBtitulo_pagar.dfcod_tipo_documento
     , TBtipo_documento.DFdescricao as TIPO_DOC
     , TBrateio_ccusto_cfinanceira_pagar.DFid_centro_custo
     , TBcentro_custo.DFdescricao as CENTRO_CUSTO
     , TBrateio_ccusto_cfinanceira_pagar.DFcod_classe_financeira
     , TBclasse_financeira.DFdescricao AS CLASSE_FINANCEIRA
     , TBconta.DFnumero AS NUM_CONTA
     , tbconta.DFdigito_verificador
     , TBconta.DFdescricao AS CONTA
  from TBtitulo_pagar
 inner join TBrateio_ccusto_cfinanceira_pagar
    on TBtitulo_pagar.DFid_titulo_pagar = TBrateio_ccusto_cfinanceira_pagar.DFid_titulo_pagar
 inner join TBcentro_custo
    on TBrateio_ccusto_cfinanceira_pagar.DFid_centro_custo = TBcentro_custo.DFid_centro_custo
 inner join TBclasse_financeira
    on TBrateio_ccusto_cfinanceira_pagar.DFcod_classe_financeira = TBclasse_financeira.DFcod_classe_financeira
  left join TBempresa
    on TBtitulo_pagar.DFcod_empresa = TBempresa.DFcod_empresa
  left join TBcliente
    on TBtitulo_pagar.DFcod_cliente = TBcliente.DFcod_cliente
  left join TBfornecedor
    on TBtitulo_pagar.DFcod_fornecedor = TBfornecedor.DFcod_fornecedor  
  left join TBtitulo_baixado_pagar
    on TBtitulo_pagar.DFid_titulo_pagar =  TBtitulo_baixado_pagar.DFid_titulo_pagar  
  left join TBbaixado_pagar_movto_bancario
    on TBtitulo_baixado_pagar.DFid_titulo_baixado_pagar = TBbaixado_pagar_movto_bancario.DFid_titulo_baixado_pagar
  left join TBmovimento_bancario
    on TBbaixado_pagar_movto_bancario.DFid_movimento_bancario =  TBmovimento_bancario.DFid_movimento_bancario
  left join TBconta
    on TBmovimento_bancario.DFid_conta = TBconta.DFid_conta
 inner join TBhistorico_padrao_pagar
    on TBtitulo_pagar.DFcod_historico_padrao_pagar = TBhistorico_padrao_pagar.DFcod_historico_padrao_pagar
 inner join TBtipo_documento
    on TBtitulo_pagar.DFcod_tipo_documento = TBtipo_documento.DFcod_tipo_documento   
    

    