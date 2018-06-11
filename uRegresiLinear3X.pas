﻿unit uRegresiLinear3X;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Memo, FMXTee.Engine, FMXTee.Series, FMXTee.Procs,
  FMXTee.Chart, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.ScrollBox,
  FMX.Grid, FMX.TabControl, FMX.Controls.Presentation, Math;

type
  TfRL3X = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnClose: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    ToolBar2: TToolBar;
    EditSetN: TEdit;
    btnSetN: TButton;
    btnAnalyze: TButton;
    btnReset: TButton;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    ListBox2: TListBox;
    ListBoxItem26: TListBoxItem;
    Label2: TLabel;
    EditY: TEdit;
    ClearEditButton1: TClearEditButton;
    ListBoxItem27: TListBoxItem;
    Label3: TLabel;
    EditX1: TEdit;
    ClearEditButton2: TClearEditButton;
    ListBoxItem28: TListBoxItem;
    Label4: TLabel;
    EditX2: TEdit;
    ClearEditButton3: TClearEditButton;
    ListBoxItem29: TListBoxItem;
    Label8: TLabel;
    EditX3: TEdit;
    ClearEditButton6: TClearEditButton;
    TabItem2: TTabItem;
    ToolBar4: TToolBar;
    LabelEquation: TLabel;
    ToolBar5: TToolBar;
    EditForX2: TEdit;
    ClearEditButton5: TClearEditButton;
    Label6: TLabel;
    EditForX1: TEdit;
    ClearEditButton4: TClearEditButton;
    Label5: TLabel;
    ToolBar6: TToolBar;
    Label9: TLabel;
    EditForX3: TEdit;
    ClearEditButton7: TClearEditButton;
    Label7: TLabel;
    EditForY: TEdit;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    ListBoxItem13: TListBoxItem;
    ListBoxItem14: TListBoxItem;
    ListBoxItem15: TListBoxItem;
    ListBoxItem16: TListBoxItem;
    ListBoxItem17: TListBoxItem;
    ListBoxItem18: TListBoxItem;
    ListBoxItem19: TListBoxItem;
    ListBoxItem20: TListBoxItem;
    ListBoxItem21: TListBoxItem;
    ListBoxItem22: TListBoxItem;
    ListBoxItem23: TListBoxItem;
    ListBoxItem24: TListBoxItem;
    ListBoxItem25: TListBoxItem;
    ListBoxItem30: TListBoxItem;
    ListBoxItem31: TListBoxItem;
    ListBoxItem32: TListBoxItem;
    ListBoxItem33: TListBoxItem;
    ListBoxItem34: TListBoxItem;
    ListBoxItem35: TListBoxItem;
    ListBoxItem36: TListBoxItem;
    ListBoxItem37: TListBoxItem;
    ListBoxItem38: TListBoxItem;
    ListBoxItem39: TListBoxItem;
    ToolBar3: TToolBar;
    btnForecast: TButton;
    TabItem3: TTabItem;
    Chart1: TChart;
    Series1: TPointSeries;
    Series2: TPointSeries;
    Series3: TPointSeries;
    Memo1: TMemo;
    btnInfo: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSetNClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnForecastClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
  private
    { Private declarations }
    N : Integer;
    Y       : array of Double;
    X1      : array of Double;
    X2      : array of Double;
    X3      : array of Double;
    X1Y     : array of Double;
    X2Y     : array of Double;
    X3Y     : array of Double;
    X1X2    : array of Double;
    X1X3    : array of Double;
    X2X3    : array of Double;
    Ykuad   : array of Double;
    X1kuad  : array of Double;
    X2kuad  : array of Double;
    X3kuad  : array of Double;
    Ybarkuad: array of Double;
    X1barkuad: array of Double;
    X2barkuad: array of Double;
    X3barkuad: array of Double;
    Ycap    : array of Double;
    eKuad   : array of Double;
    SigmaY, SigmaX1, SigmaX2, SigmaX3 : Double;
    SigmaX1Y, SigmaX2Y, SigmaX3Y, SigmaX1X2, SigmaX1X3, SigmaX2X3 : Double;
    SigmaYkuad, SigmaX1kuad, SigmaX2kuad, SigmaX3kuad : Double;
    meanY, meanX1, meanX2, MeanX3, StDevY, StDevX1, StDevX2, StDevX3 : Double;
    Sigmax1iyi, Sigmax2iyi, Sigmax3iyi, Sigmax1ix2i, Sigmax1ix3i, Sigmax2ix3i,
    Sigmayikuad, Sigmax1ikuad, Sigmax2ikuad, Sigmax3ikuad : Double;
    d1A, d2A, d3A, d1A1, d2A1, d3A1, d1A2, d2A2, d3A2,
    d1A3, d2A3, d3A3, d1A4, d2A4, d3A4 : Double;
    detA, detA1, detA2, detA3, detA4, b0, b1, b2, b3 : Double;
    rx1y, rx2y, rx3y, rx1x2, rx1x3, rx2x3, ry123,
    rx1x2kuad, rx1x3kuad, rx2x3kuad, ry123kuad : Double;
    Se, Seb0, Seb1, Seb2, Seb3, tb0, tb1, tb2, tb3 : Double;
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
  public
    { Public declarations }
  end;

var
  fRL3X: TfRL3X;

implementation

{$R *.fmx}

uses uDMStyle;

procedure TfRL3X.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfRL3X.FormCreate(Sender: TObject);
begin
  EditSetN.SetFocus;
end;

procedure TfRL3X.btnInfoClick(Sender: TObject);
begin
  Memo1.Visible := not Memo1.Visible;
end;

procedure TfRL3X.btnSetNClick(Sender: TObject);
begin
  if Trim(EditSetN.Text) = '' then
  begin
    ShowMessage('Field ini tidak boleh kosong');
    EditSetN.SetFocus;
    Exit;
  end;

  Try
    N := StrToInt(EditSetN.Text);
  except
  on EConvertError do
    begin
      ShowMessage('Data yang anda masukkan bukan angka');
      EditSetN.SetFocus;
      Exit;
    end;
  End;

  N := StrToInt(EditSetN.Text);

  EditSetN.Enabled  := False;
  btnSetN.Enabled   := False;
  Panel1.Visible  := True;
  btnAnalyze.Enabled := True;
  EditY.SetFocus;
end;

// procedure untuk split string
procedure TfRL3X.Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

procedure TfRL3X.btnAnalyzeClick(Sender: TObject);
var i : Integer; InputY, InputX1, InputX2,InputX3 : TStringList;
begin
  //Memastikan TEdit tidak kosong
  if Trim(EditY.Text) = '' then
    ShowMessage('Field ini tidak boleh kosong');

  if Trim(EditX1.Text) = '' then
    ShowMessage('Field ini tidak boleh kosong');

  if Trim(EditX2.Text) = '' then
    ShowMessage('Field ini tidak boleh kosong');

  //Membuat Column
  for i := 0 to 14 do
    StringGrid1.AddObject(TStringColumn.Create(Self));

  //Memberi Teks Header
  StringGrid1.RowCount := N+1;
  StringGrid1.Columns[0].Header := '#';
  StringGrid1.Columns[1].Header := 'Y';
  StringGrid1.Columns[2].Header := 'X₁';
  StringGrid1.Columns[3].Header := 'X₂';
  StringGrid1.Columns[4].Header := 'X₃';
  StringGrid1.Columns[5].Header := 'X₁.Y';
  StringGrid1.Columns[6].Header := 'X₂.Y';
  StringGrid1.Columns[7].Header := 'X₃.Y';
  StringGrid1.Columns[8].Header := 'X₁.X₂';
  StringGrid1.Columns[9].Header := 'X₁.X₃';
  StringGrid1.Columns[10].Header := 'X₂.X₃';
  StringGrid1.Columns[11].Header := 'Y²';
  StringGrid1.Columns[12].Header := 'X₁²';
  StringGrid1.Columns[13].Header := 'X₂²';
  StringGrid1.Columns[14].Header := 'X₃²';

  //Memasukkan dan memecah inputan TEdit menjadi Array
  InputY  := TStringList.Create;
  InputX1 := TStringList.Create;
  InputX2 := TStringList.Create;
  InputX3 := TStringList.Create;
  Split(' ',EditY.Text,InputY);
  Split(' ',EditX1.Text,InputX1);
  Split(' ',EditX2.Text,InputX2);
  Split(' ',EditX3.Text,InputX3);

  //Menentukan Length Array sesuai N
  SetLength(Y,N);
  SetLength(X1,N);
  SetLength(X2,N);
  SetLength(X3,N);
  SetLength(X1Y,N);
  SetLength(X2Y,N);
  SetLength(X3Y,N);
  SetLength(X1X2,N);
  SetLength(X1X3,N);
  SetLength(X2X3,N);
  SetLength(Ykuad,N);
  SetLength(X1kuad,N);
  SetLength(X2kuad,N);
  SetLength(X3kuad,N);
  SetLength(Ycap,N);
  SetLength(Ybarkuad,N);
  SetLength(X1barkuad,N);
  SetLength(X2barkuad,N);
  SetLength(X3barkuad,N);
  SetLength(eKuad, N);

  for i := 0 to N-1 do
    begin
      //Memasukkan nilai-nilai kedalam Array
      Y[i]  := StrToFloat(InputY[i]);
      X1[i] := StrToFloat(InputX1[i]);
      X2[i] := StrToFloat(InputX2[i]);
      X3[i] := StrToFloat(InputX3[i]);
      X1Y[i] := X1[i]*Y[i];
      X2Y[i] := X2[i]*Y[i];
      X3Y[i] := X3[i]*Y[i];
      X1X2[i] := X1[i]*X2[i];
      X1X3[i] := X1[i]*X3[i];
      X2X3[i] := X2[i]*X3[i];
      Ykuad[i]  := Sqr(Y[i]);
      X1kuad[i] := Sqr(X1[i]);
      X2kuad[i] := Sqr(X2[i]);
      X3kuad[i] := Sqr(X3[i]);

      //Menampilkan nilai-nilai kedalam StringGrid
      StringGrid1.Cells[0,i] := IntToStr(i+1);
      StringGrid1.Cells[1,i] := FloatToStr(Y[i]);
      StringGrid1.Cells[2,i] := FloatToStr(X1[i]);
      StringGrid1.Cells[3,i] := FloatToStr(X2[i]);
      StringGrid1.Cells[4,i] := FloatToStr(X3[i]);
      StringGrid1.Cells[5,i] := FloatToStr(X1Y[i]);
      StringGrid1.Cells[6,i] := FloatToStr(X2Y[i]);
      StringGrid1.Cells[7,i] := FloatToStr(X3Y[i]);
      StringGrid1.Cells[8,i] := FloatToStr(X1X2[i]);
      StringGrid1.Cells[9,i] := FloatToStr(X1X3[i]);
      StringGrid1.Cells[10,i] := FloatToStr(X2X3[i]);
      StringGrid1.Cells[11,i] := FloatToStr(Ykuad[i]);
      StringGrid1.Cells[12,i] := FloatToStr(X1kuad[i]);
      StringGrid1.Cells[13,i] := FloatToStr(X2kuad[i]);
      StringGrid1.Cells[14,i] := FloatToStr(X3kuad[i]);
    end;

  //Menghitung Sigma-sigma
  StringGrid1.Cells[0,N] := '∑ =';
  SigmaY  := Sum(Y);
  SigmaX1 := Sum(X1);
  SigmaX2 := Sum(X2);
  SigmaX3 := Sum(X3);
  SigmaX1Y  := Sum(X1Y);
  SigmaX2Y  := Sum(X2Y);
  SigmaX3Y  := Sum(X3Y);
  SigmaX1X2 := Sum(X1X2);
  SigmaX1X3 := Sum(X1X3);
  SigmaX2X3 := Sum(X2X3);
  SigmaYkuad  := Sum(Ykuad);
  SigmaX1kuad := Sum(X1kuad);
  SigmaX2kuad := Sum(X2kuad);
  SigmaX3kuad := Sum(X3kuad);

  //Menampilkan Sigma-sigma
  StringGrid1.Cells[1,N] := FormatFloat(',0.##',SigmaY);
  StringGrid1.Cells[2,N] := FormatFloat(',0.##',SigmaX1);
  StringGrid1.Cells[3,N] := FormatFloat(',0.##',SigmaX2);
  StringGrid1.Cells[4,N] := FormatFloat(',0.##',SigmaX3);
  StringGrid1.Cells[5,N] := FormatFloat(',0.##',SigmaX1Y);
  StringGrid1.Cells[6,N] := FormatFloat(',0.##',SigmaX2Y);
  StringGrid1.Cells[7,N] := FormatFloat(',0.##',SigmaX3Y);
  StringGrid1.Cells[8,N] := FormatFloat(',0.##',SigmaX1X2);
  StringGrid1.Cells[9,N] := FormatFloat(',0.##',SigmaX1X3);
  StringGrid1.Cells[10,N] := FormatFloat(',0.##',SigmaX2X3);
  StringGrid1.Cells[11,N] := FormatFloat(',0.##',SigmaYkuad);
  StringGrid1.Cells[12,N] := FormatFloat(',0.##',SigmaX1kuad);
  StringGrid1.Cells[13,N] := FormatFloat(',0.##',SigmaX2kuad);
  StringGrid1.Cells[14,N] := FormatFloat(',0.##',SigmaX3kuad);

  //Menghitung ukuran Pemusatan
  meanY := Mean(Y);
  meanX1 := Mean(X1);
  meanX2 := Mean(X2);
  meanX3 := Mean(X3);

  for i := 0 to N-1 do
    begin
      Ybarkuad[i]  := Sqr(Y[i]-meanY);
      X1barkuad[i] := Sqr(X1[i]-meanX1);
      X2barkuad[i] := Sqr(X2[i]-meanX2);
      X3barkuad[i] := Sqr(X3[i]-meanX3);
    end;

  //Menghitung ukuran Penyebaran
  StDevY := Sqrt(Sum(Ybarkuad)/N);
  StDevX1 := Sqrt(Sum(X1barkuad)/N);
  StDevX2 := Sqrt(Sum(X2barkuad)/N);
  StDevX3 := Sqrt(Sum(X3barkuad)/N);

  //Menampilkan ukuran Pemusatan&Penyebaran
  ListBoxItem1.Text := 'Mean Y = ' + FormatFloat('0.#####',meanY);
  ListBoxItem2.Text := 'Mean X₁ = ' + FormatFloat('0.#####',meanX1);
  ListBoxItem3.Text := 'Mean X₂ = ' + FormatFloat('0.#####',meanX2);
  ListBoxItem4.Text := 'Mean X₃ = ' + FormatFloat('0.#####',meanX3);
  ListBoxItem5.Text := 'StDev Y = ' + FormatFloat('0.#####',StDevY);
  ListBoxItem6.Text := 'StDev X₁ = ' + FormatFloat('0.#####',StDevX1);
  ListBoxItem7.Text := 'StDev X₂ = ' + FormatFloat('0.#####',StDevX2);
  ListBoxItem8.Text := 'StDev X₃ = ' + FormatFloat('0.#####',StDevX3);

  //Menghitung Regresi
  d1A   :=  (N*SigmaX1kuad*SigmaX2kuad*SigmaX3kuad)-(SigmaX1*SigmaX1X2*SigmaX2X3*SigmaX3)+
            (Sqr(SigmaX2)*Sqr(SigmaX1X3))-(SigmaX3*SigmaX1*SigmaX1X2*SigmaX2X3)+
            (Sqr(SigmaX3)*Sqr(SigmaX1X2))-(Sqr(SigmaX1X3)*SigmaX2kuad*N)+
            (Sqr(SigmaX2X3)*Sqr(SigmaX1))-(SigmaX3kuad*Sqr(SigmaX2)*SigmaX1kuad);
  d2A   := -(N*SigmaX1kuad*Sqr(SigmaX2X3))+(SigmaX1*SigmaX1X2*SigmaX2*SigmaX3kuad)-
            (SigmaX2*SigmaX1X3*SigmaX1X2*SigmaX3)+(SigmaX3*SigmaX1*SigmaX2kuad*SigmaX1X3)+
            (N*SigmaX1X3*SigmaX1X2*SigmaX2X3)-(Sqr(SigmaX1)*SigmaX2kuad*SigmaX3kuad)+
            (SigmaX2*SigmaX1kuad*SigmaX2X3*SigmaX3)-(SigmaX3*SigmaX1X2*SigmaX2*SigmaX1X3);
  d3A   :=  (N*SigmaX1X2*SigmaX2X3*SigmaX1X3)-(SigmaX1*SigmaX1X3*SigmaX2*SigmaX2X3)+
            (SigmaX2*SigmaX1*SigmaX1X2*SigmaX3kuad)-(Sqr(SigmaX3)*SigmaX1kuad*SigmaX2kuad)-
            (N*Sqr(SigmaX1X2)*SigmaX3kuad)+(SigmaX1*SigmaX1X3*SigmaX2kuad*SigmaX3)-
            (SigmaX2*SigmaX1*SigmaX2X3*SigmaX1X3)+(SigmaX3*SigmaX1kuad*SigmaX2*SigmaX2X3);
  detA  :=  d1A+d2A+d3A;
  d1A1  :=  (SigmaY*SigmaX1kuad*SigmaX2kuad*SigmaX3kuad)-(SigmaX1*SigmaX1X2*SigmaX2X3*SigmaX3Y)+
            (SigmaX2*Sqr(SigmaX1X3)*SigmaX2Y)-(SigmaX3*SigmaX1Y*SigmaX1X2*SigmaX2X3)+
            (SigmaX3Y*Sqr(SigmaX1X2)*SigmaX3)-(Sqr(SigmaX1X3)*SigmaX2kuad*SigmaY)+
            (Sqr(SigmaX2X3)*SigmaX1Y*SigmaX1)-(SigmaX3kuad*SigmaX2Y*SigmaX1kuad*SigmaX2);
  d2A1  := -(SigmaY*SigmaX1kuad*Sqr(SigmaX2X3))+(SigmaX1*SigmaX1X2*SigmaX2Y*SigmaX3kuad)-
            (SigmaX2*SigmaX1X3*SigmaX1X2*SigmaX3Y)+(SigmaX3*SigmaX1Y*SigmaX2kuad*SigmaX1X3)+
            (SigmaY*SigmaX1X3*SigmaX1X2*SigmaX2X3)-(SigmaX1*SigmaX1Y*SigmaX2kuad*SigmaX3kuad)+
            (SigmaX2*SigmaX1kuad*SigmaX2X3*SigmaX3Y)-(SigmaX3*SigmaX1X2*SigmaX2Y*SigmaX1X3);
  d3A1   := (SigmaY*SigmaX1X2*SigmaX2X3*SigmaX1X3)-(SigmaX1*SigmaX1X3*SigmaX2Y*SigmaX2X3)+
            (SigmaX2*SigmaX1Y*SigmaX1X2*SigmaX3kuad)-(SigmaX3*SigmaX1kuad*SigmaX2kuad*SigmaX3Y)-
            (SigmaY*Sqr(SigmaX1X2)*SigmaX3kuad)+(SigmaX1*SigmaX1X3*SigmaX2kuad*SigmaX3Y)-
            (SigmaX2*SigmaX1Y*SigmaX2X3*SigmaX1X3)+(SigmaX3*SigmaX1kuad*SigmaX2Y*SigmaX2X3);
  detA1  := d1A1+d2A1+d3A1;
  d1A2   := (N*SigmaX1Y*SigmaX2kuad*SigmaX3kuad)-(SigmaY*SigmaX1X2*SigmaX2X3*SigmaX3)+
            (Sqr(SigmaX2)*SigmaX1X3*SigmaX3Y)-(SigmaX3*SigmaX1*SigmaX2Y*SigmaX2X3)+
            (Sqr(SigmaX3)*SigmaX1X2*SigmaX2Y)-(SigmaX3Y*SigmaX1X3*SigmaX2kuad*N)+
            (Sqr(SigmaX2X3)*SigmaX1*SigmaY)-(SigmaX3kuad*Sqr(SigmaX2)*SigmaX1Y);
  d2A2   := -(N*SigmaX1Y*Sqr(SigmaX2X3))+(SigmaY*SigmaX1X2*SigmaX2*SigmaX3kuad)-
            (SigmaX2*SigmaX1X3*SigmaX2Y*SigmaX3)+(SigmaX3*SigmaX1*SigmaX2kuad*SigmaX3Y)+
            (N*SigmaX1X3*SigmaX2Y*SigmaX2X3)-(SigmaY*SigmaX1*SigmaX2kuad*SigmaX3kuad)+
            (SigmaX2*SigmaX1Y*SigmaX2X3*SigmaX3)-(SigmaX3*SigmaX1X2*SigmaX2*SigmaX3Y);
  d3A2   := (N*SigmaX1X2*SigmaX2X3*SigmaX3Y)-(SigmaY*SigmaX1X3*SigmaX2*SigmaX2X3)+
            (SigmaX2*SigmaX1*SigmaX2Y*SigmaX3kuad)-(Sqr(SigmaX3)*SigmaX1Y*SigmaX2kuad)-
            (N*SigmaX1X2*SigmaX2Y*SigmaX3kuad)+(SigmaY*SigmaX1X3*SigmaX2kuad*SigmaX3)-
            (SigmaX2*SigmaX1*SigmaX2X3*SigmaX3Y)+(SigmaX3*SigmaX1Y*SigmaX2*SigmaX2X3);
  detA2  := d1A2+d2A2+d3A2;
  d1A3   := (N*SigmaX1kuad*SigmaX2Y*SigmaX3kuad)-(SigmaX1*SigmaX1Y*SigmaX2X3*SigmaX3)+
            (SigmaY*SigmaX2*Sqr(SigmaX1X3))-(SigmaX3*SigmaX1*SigmaX1X2*SigmaX3Y)+
            (Sqr(SigmaX3)*SigmaX1X2*SigmaX1Y)-(Sqr(SigmaX1X3)*SigmaX2Y*N)+
            (SigmaX3Y*SigmaX2X3*Sqr(SigmaX1))-(SigmaX3kuad*SigmaX2*SigmaX1kuad*SigmaY);
  d2A3   := -(N*SigmaX1kuad*SigmaX2X3*SigmaX3Y)+(SigmaX1*SigmaX1Y*SigmaX2*SigmaX3kuad)-
            (SigmaY*SigmaX1X3*SigmaX1X2*SigmaX3)+(SigmaX3*SigmaX1*SigmaX2Y*SigmaX1X3)+
            (N*SigmaX1X3*SigmaX1X2*SigmaX3Y)-(Sqr(SigmaX1)*SigmaX2Y*SigmaX3kuad)+
            (SigmaY*SigmaX1kuad*SigmaX2X3*SigmaX3)-(SigmaX3*SigmaX1Y*SigmaX2*SigmaX1X3);
  d3A3   := (N*SigmaX1Y*SigmaX2X3*SigmaX1X3)-(SigmaX1*SigmaX1X3*SigmaX2*SigmaX3Y)+
            (SigmaY*SigmaX1*SigmaX1X2*SigmaX3kuad)-(Sqr(SigmaX3)*SigmaX1kuad*SigmaX2Y)-
            (N*SigmaX1Y*SigmaX1X2*SigmaX3kuad)+(SigmaX1*SigmaX1X3*SigmaX2Y*SigmaX3)-
            (SigmaY*SigmaX1*SigmaX2X3*SigmaX1X3)+(SigmaX3*SigmaX1kuad*SigmaX2*SigmaX3Y);
  detA3  := d1A3+d2A3+d3A3;
  d1A4   :=  (N*SigmaX1kuad*SigmaX2kuad*SigmaX3Y)-(SigmaX1*SigmaX1X2*SigmaX2Y*SigmaX3)+
            (Sqr(SigmaX2)*SigmaX1Y*SigmaX1X3)-(SigmaY*SigmaX1*SigmaX1X2*SigmaX2X3)+
            (SigmaX3*Sqr(SigmaX1X2)*SigmaY)-(SigmaX1X3*SigmaX2kuad*SigmaX1Y*N)+
            (SigmaX2X3*SigmaX2Y*Sqr(SigmaX1))-(SigmaX3Y*Sqr(SigmaX2)*SigmaX1kuad);
  d2A4   := -(N*SigmaX1kuad*SigmaX2Y*SigmaX2X3)+(SigmaX1*SigmaX1X2*SigmaX2*SigmaX3Y)-
            (SigmaX2*SigmaX1Y*SigmaX1X2*SigmaX3)+(SigmaY*SigmaX1*SigmaX2kuad*SigmaX1X3)+
            (N*SigmaX1Y*SigmaX1X2*SigmaX2X3)-(Sqr(SigmaX1)*SigmaX2kuad*SigmaX3Y)+
            (SigmaX2*SigmaX1kuad*SigmaX2Y*SigmaX3)-(SigmaY*SigmaX1X2*SigmaX2*SigmaX1X3);
  d3A4   :=  (N*SigmaX1X2*SigmaX2Y*SigmaX1X3)-(SigmaX1*SigmaX1Y*SigmaX2*SigmaX2X3)+
            (SigmaX2*SigmaX1*SigmaX1X2*SigmaX3Y)-(SigmaY*SigmaX3*SigmaX1kuad*SigmaX2kuad)-
            (N*Sqr(SigmaX1X2)*SigmaX3Y)+(SigmaX1*SigmaX1Y*SigmaX2kuad*SigmaX3)-
            (SigmaX2*SigmaX1*SigmaX2Y*SigmaX1X3)+(SigmaY*SigmaX1kuad*SigmaX2*SigmaX2X3);
  detA4  :=  d1A4+d2A4+d3A4;
  b0 := detA1/detA;
  b1 := detA2/detA;
  b2 := detA3/detA;
  b3 := detA4/detA;

  //Menampilkan Regresi
  LabelEquation.Text := 'Y = ' +  FloatToStr(RoundTo(b0,-2)) + ' + ' +
                              FloatToStr(RoundTo(b1,-2)) + '*X₁ + ' +
                              FloatToStr(RoundTo(b2,-2)) + '*X₂ + ' +
                              FloatToStr(RoundTo(b3,-2)) + '*X₃';
  ListBoxItem9.Text := 'b₀ = ' + FormatFloat('0.#####',b0);
  ListBoxItem10.Text := 'b₁ = ' + FormatFloat('0.#####',b1);
  ListBoxItem11.Text := 'b₂ = ' + FormatFloat('0.#####',b2);
  ListBoxItem12.Text := 'b₃ = ' + FormatFloat('0.#####',b3);

  //Menghitung Korelasi
  //Preparation
  Sigmax1iyi := SigmaX1Y - ((SigmaX1*SigmaY)/N);
  Sigmax2iyi := SigmaX2Y - ((SigmaX2*SigmaY)/N);
  Sigmax3iyi := SigmaX3Y - ((SigmaX3*SigmaY)/N);
  Sigmax1ix2i := SigmaX1X2 - ((SigmaX1*SigmaX2)/N);
  Sigmax1ix3i := SigmaX1X3 - ((SigmaX1*SigmaX3)/N);
  Sigmax2ix3i := SigmaX2X3 - ((SigmaX2*SigmaX3)/N);
  Sigmayikuad := SigmaYkuad - (Sqr(SigmaY)/N);
  Sigmax1ikuad := SigmaX1kuad - (Sqr(SigmaX1)/N);
  Sigmax2ikuad := SigmaX2kuad - (Sqr(SigmaX2)/N);
  Sigmax3ikuad := SigmaX3kuad - (Sqr(SigmaX3)/N);

  //Calculation of r
  rx1y := Sigmax1iyi / ((Sqrt(Sigmax1ikuad))*(Sqrt(Sigmayikuad)));
  rx2y := Sigmax2iyi / ((Sqrt(Sigmax2ikuad))*(Sqrt(Sigmayikuad)));
  rx3y := Sigmax3iyi / ((Sqrt(Sigmax3ikuad))*(Sqrt(Sigmayikuad)));
  rx1x2:= Sigmax1ix2i / ((Sqrt(Sigmax1ikuad))*(Sqrt(Sigmax2ikuad)));
  rx1x3:= Sigmax1ix3i / ((Sqrt(Sigmax1ikuad))*(Sqrt(Sigmax3ikuad)));
  rx2x3:= Sigmax2ix3i / ((Sqrt(Sigmax2ikuad))*(Sqrt(Sigmax3ikuad)));
  ry123 := Sqrt(((b1*Sigmax1iyi)+(b2*Sigmax2iyi)+(b3*Sigmax3iyi))/Sigmayikuad);

  //Menampilkan Korelasi
  ListBoxItem13.Text := 'CORR X₁.Y = ' + FormatFloat('0.#####',rx1y);
  ListBoxItem14.Text := 'CORR X₂.Y = ' + FormatFloat('0.#####',rx2y);
  ListBoxItem15.Text := 'CORR X₃.Y = ' + FormatFloat('0.#####',rx3y);
  ListBoxItem16.Text := 'CORR X₁.X₂ = ' + FormatFloat('0.#####',rx1x2);
  ListBoxItem17.Text := 'CORR X₁.X₃ = ' + FormatFloat('0.#####',rx1x3);
  ListBoxItem18.Text := 'CORR X₂.X₃ = ' + FormatFloat('0.#####',rx2x3);
  ListBoxItem19.Text := 'CORR X₁.X₂.X₃.Y = ' + FormatFloat('0.#####',ry123);

  //Menentukan r² dan R²
  rx1x2kuad := Sqr(rx1x2);
  rx1x3kuad := Sqr(rx1x3);
  rx2x3kuad := Sqr(rx2x3);
  ry123kuad := Sqr(ry123);

  ListBoxItem33.Text := 'r₁₂² = ' + FormatFloat('0.#####',rx1x2kuad);
  ListBoxItem34.Text := 'r₁₃² = ' + FormatFloat('0.#####',rx1x3kuad);
  ListBoxItem35.Text := 'r₂₃² = ' + FormatFloat('0.#####',rx2x3kuad);
  ListBoxItem36.Text := 'R² = ' + FormatFloat('0.#####',ry123kuad);

  //Uji Multikolinearitas
  if (rx1x2kuad > ry123kuad) OR (rx1x3kuad > ry123kuad) OR (rx2x3kuad > ry123kuad) then
  begin
    ListboxItem37.Text := 'Koefisien r² ada yg > R²';
    ListboxItem38.Text := 'Terjadi Multikolinearitas';
    ListBoxItem39.Text := 'Model Regresi Anda kemungkinan TIDAK ROBUST';
  end
  else if (rx1x2kuad < ry123kuad) AND (rx1x3kuad < ry123kuad) AND (rx2x3kuad < ry123kuad) then
  begin
    ListboxItem37.Text := 'Semua koefisien r² < R²';
    ListboxItem38.Text := 'Tidak Terjadi Multikolinearitas';
    ListBoxItem39.Text := 'Model Regresi Anda ROBUST';
  end;

  //Grafik
  for i := 0 to N-1 do
  begin
    Ycap[i]  := b0 + (b1*X1[i]) + (b2*X2[i]) + (b3*X3[i]);
    eKuad[i] := Sqr(Y[i]-Ycap[i]);

    Chart1.Series[0].AddXY(X1[i],Y[i]);
    Chart1.Series[1].AddXY(X2[i],Y[i]);
    Chart1.Series[2].AddXY(X3[i],Y[i]);
  end;

  //Menghitung Standard Error
  Se := Sqrt(Sum(eKuad)/(N-4));
  Seb0 := Sqrt(Sqr(Se)*((SigmaX1kuad*SigmaX2kuad*SigmaX3kuad)+
                        (SigmaX1X2*SigmaX2X3*SigmaX1X3)+
                        (SigmaX1X3*SigmaX1X2*SigmaX2X3)-
                        (Sqr(SigmaX1X3)*SigmaX2kuad)-
                        (Sqr(SigmaX2X3)*SigmaX1kuad)-
                        (Sqr(SigmaX1X2)*SigmaX3kuad)
                        )/detA);
  Seb1 := Sqrt(Sqr(Se)*((N*SigmaX2kuad*SigmaX3Kuad)+
                        (SigmaX2*SigmaX2X3*SigmaX3)+
                        (SigmaX3*SigmaX2*SigmaX2X3)-
                        (Sqr(SigmaX3)*SigmaX2kuad)-
                        (Sqr(SigmaX2X3)*N)-
                        (Sqr(SigmaX2)*SigmaX3kuad)
                        )/detA);
  Seb2 := Sqrt(Sqr(Se)*((N*SigmaX1kuad*SigmaX3kuad)+
                        (SigmaX1*SigmaX1X3*SigmaX3)+
                        (SigmaX3*SigmaX1*SigmaX1X3)-
                        (Sqr(SigmaX3)*SigmaX1kuad)-
                        (Sqr(SigmaX1X3)*N)-
                        (Sqr(SigmaX1)*SigmaX3kuad)
                        )/detA);
  Seb3 := Sqrt(Sqr(Se)*((N*SigmaX1kuad*SigmaX2kuad)+
                        (SigmaX1*SigmaX1X2*SigmaX2)+
                        (SigmaX2*SigmaX1*SigmaX1X2)-
                        (Sqr(SigmaX2)*SigmaX1kuad)-
                        (Sqr(SigmaX1X2)*N)-
                        (SigmaX2kuad*Sqr(SigmaX1))
                        )/detA);

  //Menampilkan Standard Error
  ListboxItem20.Text := 'Std. Error = ' + FormatFloat('0.#####',Se);
  ListboxItem21.Text := 'Std. Error b₀ = ' + FormatFloat('0.#####',Seb0);
  ListboxItem22.Text := 'Std. Error b₁ = ' + FormatFloat('0.#####',Seb1);
  ListboxItem23.Text := 'Std. Error b₂ = ' + FormatFloat('0.#####',Seb2);
  ListboxItem24.Text := 'Std. Error b₃ = ' + FormatFloat('0.#####',Seb3);

  //Menghitung t
  tb0 := b0/Seb0;
  tb1 := b1/Seb1;
  tb2 := b2/Seb2;
  tb3 := b3/Seb3;

  //Menampilkan t
  ListboxItem25.Text := 't(b₀) = ' + FormatFloat('0.#####',tb0);
  ListboxItem30.Text := 't(b₁) = ' + FormatFloat('0.#####',tb1);
  ListboxItem31.Text := 't(b₂) = ' + FormatFloat('0.#####',tb2);
  ListboxItem32.Text := 't(b₃) = ' + FormatFloat('0.#####',tb3);

  Panel1.Visible := False;
  btnReset.Enabled  := True;
  btnAnalyze.Enabled := False;
  btnForecast.Enabled := True;
end;

procedure TfRL3X.btnForecastClick(Sender: TObject);
var estX1, estX2, estX3, estY : Double;
begin
  if Trim(EditForX1.Text) = '' then
  begin
    ShowMessage('X₁ tidak boleh kosong');
    EditX1.SetFocus;
    Exit;
  end;
  if Trim(EditForX2.Text) = '' then
  begin
    ShowMessage('X₂ tidak boleh kosong');
    EditX2.SetFocus;
    Exit;
  end;
  if Trim(EditForX3.Text) = '' then
  begin
    ShowMessage('X₃ tidak boleh kosong');
    EditX3.SetFocus;
    Exit;
  end;
  estX1 := StrToFloat(EditForX1.Text);
  estX2 := StrToFloat(EditForX2.Text);
  estX3 := StrToFloat(EditForX3.Text);
  estY  := b0 + (b1*estX1) + (b2*estX2) + (b3*estX3);
  EditForY.Text := FloatToStr(RoundTo(estY,-2));
end;

procedure TfRL3X.btnResetClick(Sender: TObject);
begin
  //Menghapus TStringGrid
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;

  //Menghapus ListBox
  LabelEquation.Text:= '';
  ListboxItem1.Text := '';
  ListboxItem2.Text := '';
  ListboxItem3.Text := '';
  ListboxItem4.Text := '';
  ListboxItem5.Text := '';
  ListboxItem6.Text := '';
  ListboxItem7.Text := '';
  ListboxItem8.Text := '';
  ListboxItem9.Text := '';
  ListboxItem10.Text := '';
  ListboxItem11.Text := '';
  ListboxItem12.Text := '';
  ListboxItem13.Text := '';
  ListboxItem14.Text := '';
  ListboxItem15.Text := '';
  ListboxItem16.Text := '';
  ListboxItem17.Text := '';
  ListboxItem18.Text := '';
  ListboxItem19.Text := '';
  ListboxItem20.Text := '';
  ListboxItem21.Text := '';
  ListboxItem22.Text := '';
  ListboxItem23.Text := '';
  ListboxItem24.Text := '';
  ListboxItem25.Text := '';
  ListboxItem30.Text := '';
  ListboxItem31.Text := '';
  ListboxItem32.Text := '';
  ListboxItem33.Text := '';
  ListboxItem34.Text := '';
  ListboxItem35.Text := '';
  ListboxItem36.Text := '';
  ListboxItem37.Text := '';
  ListboxItem38.Text := '';
  ListboxItem39.Text := '';

  EditSetN.Text := '';
  EditY.Text := '';
  EditX1.Text := '';
  EditX2.Text := '';
  EditX3.Text := '';
  EditForY.Text := '';
  EditForX1.Text := '';
  EditForX2.Text := '';
  EditForX3.Text := '';

  N := 0;
  SigmaY := 0; SigmaX1 :=0; SigmaX2 := 0; SigmaX3 := 0;
  SigmaX1Y := 0; SigmaX2Y := 0; SigmaX3Y := 0;
  SigmaX1X2 := 0; SigmaX1X3 := 0; SigmaX2X3 := 0;
  SigmaYkuad := 0; SigmaX1kuad := 0; SigmaX2kuad := 0; SigmaX3kuad := 0;
  meanY := 0; meanX1 := 0; meanX2 := 0; meanX3 := 0;
  StDevY := 0; StDevX1 := 0; StDevX2 := 0; StDevX3 := 0;
  Sigmax1iyi := 0; Sigmax2iyi := 0; Sigmax3iyi := 0;
  Sigmax1ix2i := 0; Sigmax1ix3i := 0; Sigmax2ix3i := 0;
  Sigmayikuad := 0; Sigmax1ikuad := 0; Sigmax2ikuad := 0; Sigmax3ikuad := 0;
  d1A1 := 0; d2A1 := 0; d3A1 := 0;
  d1A2 := 0; d2A2 := 0; d3A2 := 0;
  d1A3 := 0; d2A3 := 0; d3A3 := 0;
  d1A4 := 0; d2A4 := 0; d3A4 := 0;
  detA := 0; detA1 := 0; detA2 := 0; detA3 := 0; detA4 := 0;
  b0 := 0; b1 := 0; b2 := 0; b3 := 0;
  rx1y := 0; rx2y := 0; rx3y := 0;
  rx1x2 := 0; rx1x3 := 0; rx2x3 := 0; ry123 := 0;
  rx1x2kuad := 0; rx1x3kuad := 0; rx2x3kuad := 0; ry123kuad := 0;
  Se := 0; Seb0 := 0; Seb1 := 0; Seb2 := 0; Seb3 := 0;
  tb0 := 0; tb1 := 0; tb2 := 0; tb3 := 0;

  SetLength(Y,N);
  SetLength(X1,N);
  SetLength(X2,N);
  SetLength(X3,N);
  SetLength(X1Y,N);
  SetLength(X2Y,N);
  SetLength(X3Y,N);
  SetLength(X1X2,N);
  SetLength(X1X3,N);
  SetLength(X2X3,N);
  SetLength(Ykuad,N);
  SetLength(X1kuad,N);
  SetLength(X2kuad,N);
  SetLength(X3kuad,N);
  SetLength(Ycap,N);
  SetLength(Ybarkuad,N);
  SetLength(X1barkuad,N);
  SetLength(X2barkuad,N);
  SetLength(X3barkuad,N);

  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;
  Chart1.Series[2].Clear;

  btnForecast.Enabled := False;
  btnSetN.Enabled := True;
  btnReset.Enabled := False;
  EditSetN.Enabled := True;
  EditSetN.SetFocus;
end;

end.
