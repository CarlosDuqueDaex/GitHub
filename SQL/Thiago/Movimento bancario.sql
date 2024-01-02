
 select TBempresa.DFcod_empresa
      , TBempresa.DFrazao_social
      , TBtitulo_receber.DFcod_cliente as cod_client_receb
      , TBtitulo_receber.DFcod_fornecedor as cod_forn_receber
      , TBtitulo_receber.DFnumero_titulo as receber
      , TBtitulo_receber.DFcomplemento as compl
      , TBtitulo_receber.DFserie_nf as serie
      , TBtitulo_pagar.dfcod_cliente
      , TBtitulo_pagar.DFcod_fornecedor
      , TBtitulo_pagar.DFnumero_titulo
      , TBtitulo_pagar.DFcomplemento
      , TBtitulo_pagar.DFserie_nf
      , tbmovimento_bancario.DFnumero_documento
      , tbmovimento_bancario.DFvalor
      , tbmovimento_bancario.DFdata_emissao
      , tbmovimento_bancario.DFdata_vencimento
      , tbmovimento_bancario.DFdata_conciliacao
      , TBtipo_documento.DFcod_tipo_documento
      , TBtipo_documento.DFdescricao
      , TBhistorico_padrao_movto_bancario.DFcod_historico_movto_bancario
      , TBhistorico_padrao_movto_bancario.DFdescricao as hist_padrao
      , TBconta.DFnumero
      , TBconta.DFdescricao as Conta
      , tbmovimento_bancario.DFcomplemento_historico
   from tbmovimento_bancario
  inner join TBconta
     on tbmovimento_bancario.DFid_conta = TBconta.DFid_conta
  inner join TBtipo_documento
     on tbmovimento_bancario.DFcod_tipo_documento = TBtipo_documento.DFcod_tipo_documento
  inner join TBhistorico_padrao_movto_bancario
     on tbmovimento_bancario.DFcod_historico_movto_bancario = TBhistorico_padrao_movto_bancario.DFcod_historico_movto_bancario
  inner join TBempresa
     on tbmovimento_bancario.DFcod_empresa = TBempresa.DFcod_empresa  
   left join TBbaixado_pagar_movto_bancario
     on tbmovimento_bancario.DFid_movimento_bancario = TBbaixado_pagar_movto_bancario.DFid_movimento_bancario
   left join TBbaixado_receber_movto_bancario
     on tbmovimento_bancario.DFid_movimento_bancario = TBbaixado_receber_movto_bancario.DFid_movimento_bancario  
   left join TBtitulo_baixado_pagar
     on TBbaixado_pagar_movto_bancario.DFid_titulo_baixado_pagar = TBtitulo_baixado_pagar.DFid_titulo_baixado_pagar 
   left join TBtitulo_baixado_receber
     on TBbaixado_receber_movto_bancario.DFid_titulo_baixado_receber = TBtitulo_baixado_receber.DFid_titulo_baixado_receber
   left join TBtitulo_pagar
     on TBtitulo_baixado_pagar.DFid_titulo_pagar = TBtitulo_pagar.DFid_titulo_pagar
   left join TBtitulo_receber
     on TBtitulo_baixado_receber.DFid_titulo_receber = TBtitulo_receber.DFid_titulo_receber
  where tbmovimento_bancario.DFdata_emissao > '2023-01-01' 
    
   

