
select TBconhecimento_transporte.DFid_conhecimento_transporte
     , TBconhecimento_transporte.DFexpedidor
     , '' as serie_cte
	 , TBconhecimento_transporte.DFvalor_receber
	 , TBnota_fiscal_saida.DFnumero
	 , '' as ID_CTE
	 , TBnota_fiscal_saida.DFserie
	 , TBnota_fiscal_saida.DFvalor_total
	 , TBnota_fiscal_saida.DFdata_emissao
	 , TBnota_fiscal_saida.DFdata_saida
	 , TBcliente.DFcod_cliente
	 , TBcliente.DFnome
  from TBconhecimento_transporte
 inner join TBnota_fiscal_saida
    on TBconhecimento_transporte.DFid_nota_fiscal_saida = TBnota_fiscal_saida.DFid_nota_fiscal_saida
 Inner join TBcliente
    on TBnota_fiscal_saida.DFcod_cliente_destinatario = TBcliente.DFcod_cliente
  where TBnota_fiscal_saida.DFdata_emissao > '2023-01-01'  
