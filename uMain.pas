unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DialogService;

type
  TfMain = class(TForm)
    ToolBar1: TToolBar;
    btnInfo: TButton;
    btnClose: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    DistribusiFrekuensi: TListBoxItem;
    RegresiLinearSederhana: TListBoxItem;
    RegresiLinearBerganda: TListBoxItem;
    RegresiLinear3: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    Memo1: TMemo;
    DistribusiBinomial: TListBoxItem;
    DistribusiPoisson: TListBoxItem;
    DistribusiBayes: TListBoxItem;
    TrendParabola: TListBoxItem;
    TrendEksponensial: TListBoxItem;
    procedure DistribusiBinomialClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure DistribusiFrekuensiClick(Sender: TObject);
    procedure RegresiLinearSederhanaClick(Sender: TObject);
    procedure RegresiLinearBergandaClick(Sender: TObject);
    procedure RegresiLinear3Click(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

uses uDistribusiBinomial, uDistribusiFrekuensi, uRegresiLinearSederhana,
  uRegresiLinearBerganda, uRegresiLinear3X, uDMStyle;

procedure TfMain.btnCloseClick(Sender: TObject);
begin
  TDialogService.MessageDialog('Do You want to exit Now ?', System.UITypes.TMsgDlgType.mtInformation,
  [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], System.UITypes.TMsgDlgBtn.mbNo, 0,

  //Use an anonymous method to make sure the acknowledgement appears as expected.
  procedure(const AResult: TModalResult)
  begin
    case AResult of
      { Detect which button was pushed and show a different message }
      mrYes:
        Application.Terminate;
      mrNo:
    end;
  end);
end;

procedure TfMain.btnInfoClick(Sender: TObject);
begin
  Memo1.Visible := not Memo1.Visible;
end;

procedure TfMain.DistribusiBinomialClick(Sender: TObject);
begin
  if fBinom = nil then
    fBinom := TfBinom.Create(Application);
  fBinom.Show;
end;

procedure TfMain.DistribusiFrekuensiClick(Sender: TObject);
begin
  if fDF = nil then
    fDF := TfDF.Create(Application);
  fDF.Show;
end;

procedure TfMain.RegresiLinear3Click(Sender: TObject);
begin
  if fRL3X = nil then
    fRL3X := TfRL3X.Create(Application);
  fRL3X.Show;
end;

procedure TfMain.RegresiLinearBergandaClick(Sender: TObject);
begin
  if fRLB = nil then
    fRLB := TfRLB.Create(Application);
  fRLB.Show;
end;

procedure TfMain.RegresiLinearSederhanaClick(Sender: TObject);
begin
  if fRLS = nil then
    fRLS := TfRLS.Create(Application);
  fRLS.Show;
end;

end.
