USE dbCTE

IF OBJECT_ID('dbo.sp_carga_TBvasilhame') IS NOT NULL
    DROP PROCEDURE dbo.sp_carga_TBvasilhame; 
GO

CREATE PROCEDURE dbo.sp_carga_TBvasilhame 

AS BEGIN

/*
    AUTOR......: Carlos Duque
    AREA.......: Vasilhame
    DATA/HORA..: 22/08/2022          
	FUNÇÃO.....: Carregar Tabela de Vasilhame
    
*/

BEGIN TRY
-------------------------------------------------------------------------------------------------------------------
                                                BEGIN TRAN
-------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#temp_TBvasilhame') IS NOT NULL
	BEGIN
		DROP TABLE tempdb..#temp_TBvasilhame; 
	END

	CREATE TABLE tempdb..#temp_TBvasilhame (
		DFcod_vasilhame			nvarchar(50) PRIMARY KEY,
		DFcod_marca				int,
		Dftipo					nvarchar(50),
		Dfmaterial				nvarchar(50),
		Dfcapacidade			int,
		DFcod_unidade			int,
		Dfvalidade				int,
		Dfpressao				int,
		DFdata_ult_teste		nvarchar(10));

	BULK INSERT tempdb..#temp_TBvasilhame from 'C:\Users\Asus\Documents\Thiago\TBvasilhame.csv' 
	WITH (
		CODEPAGE = 'ACP'
       ,FIELDTERMINATOR = ';'
       ,ROWTERMINATOR   = '\n'
       ,FIRSTROW=2
     );

	 INSERT INTO TBvasilhame
		SELECT * 
		  FROM tempdb..#temp_TBvasilhame a
		 WHERE a.DFcod_vasilhame not in (select DFcod_vasilhame from TBvasilhame)

		 
-------------------------------------------------------------------------------------------------------------------
                                                 COMMIT TRAN
-------------------------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

		IF (XACT_STATE()) = -1 

			ROLLBACK TRAN 

		ELSE IF (XACT_STATE()) = 1  

			COMMIT TRAN 

		DECLARE @ERRO VARCHAR(MAX)
		SET @ERRO = ERROR_MESSAGE()
		RAISERROR( @ERRO, 16, 1 )

END CATCH

END		


