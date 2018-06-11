program Statxyz;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {fMain},
  uDistribusiBinomial in 'uDistribusiBinomial.pas' {fBinom},
  uDistribusiFrekuensi in 'uDistribusiFrekuensi.pas' {fDF},
  uRegresiLinearSederhana in 'uRegresiLinearSederhana.pas' {fRLS},
  uRegresiLinearBerganda in 'uRegresiLinearBerganda.pas' {fRLB},
  uRegresiLinear3X in 'uRegresiLinear3X.pas' {fRL3X},
  uDMStyle in 'uDMStyle.pas' {DMStyle: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMStyle, DMStyle);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
