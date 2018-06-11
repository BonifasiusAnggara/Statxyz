﻿unit uDistribusiBinomial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Memo, FMXTee.Engine, FMXTee.Series, FMXTee.Procs,
  FMXTee.Chart, FMX.ListBox, FMX.Edit, FMX.Layouts, FMX.StdCtrls, FMX.ScrollBox,
  FMX.Grid, FMX.TabControl, FMX.Controls.Presentation, Math;

type
  TfBinom = class(TForm)
    ToolBar1: TToolBar;
    btnInfo: TButton;
    btnClose: TButton;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    StringGrid1: TStringGrid;
    ToolBar2: TToolBar;
    Editp: TEdit;
    btnAnalyze: TButton;
    Label3: TLabel;
    Panel1: TPanel;
    ListBox2: TListBox;
    ListBoxItem14: TListBoxItem;
    Label2: TLabel;
    EditData: TEdit;
    ClearEditButton1: TClearEditButton;
    ToolBar3: TToolBar;
    Editn: TEdit;
    btnReset: TButton;
    Label4: TLabel;
    TabItem2: TTabItem;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    TabItem3: TTabItem;
    Chart1: TChart;
    Memo1: TMemo;
    Series1: TBarSeries;
    procedure btnCloseClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    { Private declarations }
    n : Integer;
    p, q, mean, stdev, varians : Double;
    x, nx : Array of Integer;
    prx, Fx : Array of Double;
    Function nCr(n,r:integer):real;
  public
    { Public declarations }
  end;

var
  fBinom: TfBinom;

implementation

{$R *.fmx}

uses uDMStyle;

procedure TfBinom.btnAnalyzeClick(Sender: TObject);
var i : Integer; j : Double;
begin
  if Trim(Editn.Text) = '' then
  begin
    ShowMessage('n tidak boleh kosong');
    Editn.SetFocus;
    Exit;
  end;

  if Trim(Editp.Text) = '' then
  begin
    ShowMessage('p tidak boleh kosong');
    Editp.SetFocus;
    Exit;
  end;

  n := StrToInt(Editn.Text);
  n := n+1;
  p := StrToFloat(Editp.Text);
  q := 1-p;

  SetLength(x,n);
  SetLength(nx,n);
  SetLength(prx,n);
  SetLength(Fx,n);

  //Membuat Column
  for i := 0 to 3 do
    StringGrid1.AddObject(TStringColumn.Create(Self));

  //Memberi Teks Header
  StringGrid1.RowCount := n;
  StringGrid1.Columns[0].Header := 'χ';
  StringGrid1.Columns[1].Header := 'n-χ';
  StringGrid1.Columns[2].Header := 'pᵣ(χ)';
  StringGrid1.Columns[3].Header := 'F(χ)';

  j := 0;
  for i := 0 to n-1 do
  begin
    x[i]   := i;
    nx[i]  := n-1-i;
    prx[i] := nCr(n-1,x[i])*Power(p,x[i])*Power(q,nx[i]);
    j      := j + prx[i];
    Fx[i]  := j;
    StringGrid1.Cells[0,i] := IntToStr(x[i]);
    StringGrid1.Cells[1,i] := IntToStr(nx[i]);
    StringGrid1.Cells[2,i] := FormatFloat('0.#####',prx[i]);
    StringGrid1.Cells[3,i] := FormatFloat('0.#####',Fx[i]);
  end;

  //Menampilkan Grafik
  begin
    for i := 0 to n-1 do
      Chart1.Series[0].AddXY(x[i],prx[i]);
  end;

  mean  := (n-1)*p;
  stdev := (n-1)*p*q;
  varians := Sqr(stdev);

  ListBoxItem1.Text := 'µ = ' + FloatToStr(mean);
  ListBoxItem2.Text := 'σ = ' + FloatToStr(stdev);
  ListBoxItem3.Text := 'σ² = ' + FloatToStr(varians);

  Editp.Enabled := False;
  Editn.Enabled := False;
  btnReset.Enabled  := True;
  btnAnalyze.Enabled := False;

end;

procedure TfBinom.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfBinom.FormCreate(Sender: TObject);
begin
  Editp.SetFocus;
end;

procedure TfBinom.btnInfoClick(Sender: TObject);
begin
  Memo1.Visible := not Memo1.Visible;
end;

procedure TfBinom.btnResetClick(Sender: TObject);
begin
  //Menghapus TStringGrid
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;

  //Menghapus ListBox
  ListboxItem1.Text := '';
  ListboxItem2.Text := '';
  ListboxItem3.Text := '';

  Editp.Text := '';
  Editn.Text := '';

  n := 0;
  SetLength(x,n);
  SetLength(nx,n);
  SetLength(prx,n);
  SetLength(Fx,n);

  p := 0; q := 0; mean := 0; stdev := 0; varians := 0;

  Chart1.Series[0].Clear;

  Editp.Enabled := True;
  Editn.Enabled := True;
  btnAnalyze.Enabled := True;
  btnReset.Enabled := False;
end;

Function TfBinom.nCr(n,r:integer):real;
var x,y:real; i:integer;
begin
  if r > n div 2 then r := n-r;
  x := 1; y := 1;
  for i := n-r+1 to n do x:=x*i;
  for i:=2 to r do y:=y*i;
  nCr:=x/y;
end;

end.
