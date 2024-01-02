

select TBtitulo_receber.DFcod_empresa
     , TBempresa.DFrazao_social
     , TBtitulo_receber.DFnumero_titulo
     , TBtitulo_receber.DFcomplemento
     , TBtitulo_receber.DFserie_nf
     , TBtitulo_receber.DFdata_emissao
     , '' as data_entrada
     , TBtitulo_receber.DFdata_vencimento
     , '' as pagamento
     , TBtitulo_baixado_receber.DFdata_pagto
     , TBtitulo_baixado_receber.DFdata_baixa   
     , TBmovimento_bancario.DFdata_conciliacao
     , TBtitulo_receber.DFvalor
     , TBtitulo_baixado_receber.DFvalor_baixa
     , TBmovimento_bancario.DFvalor as valor_conciliado  
     , TBtitulo_receber.DFcod_fornecedor
     , TBfornecedor.DFnome
     , TBtitulo_receber.DFcod_cliente
     , TBcliente.DFnome as CLIENTE
     , TBtitulo_receber.DFcod_historico_padrao_receber
     , TBhistorico_padrao_receber.DFdescricao as HIST_PADRAO
     , TBtitulo_receber.dfcod_tipo_documento
     , TBtipo_documento.DFdescricao as TIPO_DOC
     , TBrateio_ccusto_cfinanceira_receber.DFid_centro_custo
     , TBcentro_custo.DFdescricao as CENTRO_CUSTO
     , TBrateio_ccusto_cfinanceira_receber.DFcod_classe_financeira
     , TBclasse_financeira.DFdescricao AS CLASSE_FINANCEIRA
     , TBconta.DFnumero AS NUM_CONTA
     , tbconta.DFdigito_verificador
     , TBconta.DFdescricao AS CONTA
  from TBtitulo_receber
 inner join TBrateio_ccusto_cfinanceira_receber
    on TBtitulo_receber.DFid_titulo_receber = TBrateio_ccusto_cfinanceira_receber.DFid_titulo_receber
 inner join TBcentro_custo
    on TBrateio_ccusto_cfinanceira_receber.DFid_centro_custo = TBcentro_custo.DFid_centro_custo
 inner join TBclasse_financeira
    on TBrateio_ccusto_cfinanceira_receber.DFcod_classe_financeira = TBclasse_financeira.DFcod_classe_financeira
  left join TBempresa
    on TBtitulo_receber.DFcod_empresa = TBempresa.DFcod_empresa
  left join TBcliente
    on TBtitulo_receber.DFcod_cliente = TBcliente.DFcod_cliente
  left join TBfornecedor
    on TBtitulo_receber.DFcod_fornecedor = TBfornecedor.DFcod_fornecedor  
  left join TBtitulo_baixado_receber
    on TBtitulo_receber.DFid_titulo_receber =  TBtitulo_baixado_receber.DFid_titulo_receber  
  left join TBbaixado_receber_movto_bancario
    on TBtitulo_baixado_receber.DFid_titulo_baixado_receber = TBbaixado_receber_movto_bancario.DFid_titulo_baixado_receber
  left join TBmovimento_bancario
    on TBbaixado_receber_movto_bancario.DFid_movimento_bancario =  TBmovimento_bancario.DFid_movimento_bancario
  left join TBconta
    on TBmovimento_bancario.DFid_conta = TBconta.DFid_conta
 inner join TBhistorico_padrao_receber
    on TBtitulo_receber.DFcod_historico_padrao_receber = TBhistorico_padrao_receber.DFcod_historico_padrao_receber
 inner join TBtipo_documento
    on TBtitulo_receber.DFcod_tipo_documento = TBtipo_documento.DFcod_tipo_documento   
    