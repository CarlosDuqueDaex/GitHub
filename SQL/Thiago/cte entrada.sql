WITH nf as (
select TBnota_fiscal_entrada.DFnumero as NOTA
     , TBnota_fiscal_entrada_relacionada.DFid_nota_fiscal_entrada
     , TBnota_fiscal_entrada.DFserie
	 , TBnota_fiscal_entrada.DFvalor_total
	 , TBnota_fiscal_entrada.DFdata_emissao
	 , TBnota_fiscal_entrada.DFdata_entrada
	 , TBfornecedor.DFcod_fornecedor
	 , TBfornecedor.DFnome
  from TBnota_fiscal_entrada
 inner join TBfornecedor
    on TBnota_fiscal_entrada.DFcod_fornecedor_emitente = TBfornecedor.DFcod_fornecedor
 inner join TBnota_fiscal_entrada_relacionada
    on TBnota_fiscal_entrada.DFid_nota_fiscal_entrada = TBnota_fiscal_entrada_relacionada.DFid_nota_fiscal_entrada_original
)
select  nfe.DFnumero as CTE, nfe.DFcod_fornecedor_emitente as FORC_CTE, nfe.DFserie, nfe.DFvalor_total as Valor_frete,nf.* 
  from  TBnota_fiscal_entrada as nfe
  inner join nf
     on nf.DFid_nota_fiscal_entrada = nfe.DFid_nota_fiscal_entrada
 where  nfe.DFid_nota_fiscal_entrada in (select nf.DFid_nota_fiscal_entrada from nf)
   and nfe.DFdata_emissao > '2023-01-01'
 
 

 
 



  
 