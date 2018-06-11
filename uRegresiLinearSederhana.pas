﻿unit uRegresiLinearSederhana;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMXTee.Series, FMXTee.Engine, FMXTee.Procs, FMXTee.Chart,
  FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Grid, FMX.TabControl,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, Math;

type
  TfRLS = class(TForm)
    Memo1: TMemo;
    ToolBar1: TToolBar;
    btnInfo: TButton;
    btnClose: TButton;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    StringGrid1: TStringGrid;
    ToolBar2: TToolBar;
    EditSetN: TEdit;
    btnAnalyze: TButton;
    btnSetN: TButton;
    Panel1: TPanel;
    ListBox2: TListBox;
    ListBoxItem14: TListBoxItem;
    Label2: TLabel;
    EditY: TEdit;
    ClearEditButton1: TClearEditButton;
    ListBoxItem15: TListBoxItem;
    Label3: TLabel;
    EditX: TEdit;
    ClearEditButton2: TClearEditButton;
    TabItem2: TTabItem;
    ToolBar4: TToolBar;
    LabelEquation: TLabel;
    ToolBar5: TToolBar;
    EditForX: TEdit;
    ClearEditButton4: TClearEditButton;
    Label5: TLabel;
    Label7: TLabel;
    EditForY: TEdit;
    ToolBar6: TToolBar;
    btnForecast: TButton;
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
    TabItem3: TTabItem;
    Chart1: TChart;
    Series1: TPointSeries;
    Series3: TLineSeries;
    btnReset: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnSetNClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnForecastClick(Sender: TObject);
  private
    { Private declarations }
    N : Integer;
    X     : array of Double;
    Y     : array of Double;
    XY    : array of Double;
    Xkuad : array of Double;
    Ykuad : array of Double;
    Xbarkuad : array of Double;
    Ybarkuad : array of Double;
    Ycap  : array of Double;
    a,b,r : Double;
    SigmaX,SigmaY,SigmaXY,SigmaXkuad,SigmaYkuad : Double;
    meanY, meanX, StDevY, StDevX : Double;
    Se, Sea, Seb, ta, tb : Double;
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
  public
    { Public declarations }
  end;

var
  fRLS: TfRLS;

implementation

{$R *.fmx}

uses uDMStyle;

procedure TfRLS.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfRLS.btnInfoClick(Sender: TObject);
begin
  Memo1.Visible := not Memo1.Visible;
end;

procedure TfRLS.FormCreate(Sender: TObject);
begin
  EditSetN.SetFocus;
end;

procedure TfRLS.btnSetNClick(Sender: TObject);
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
procedure TfRLS.Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

procedure TfRLS.btnAnalyzeClick(Sender: TObject);
  var i : Integer; InputY, InputX : TStringList;
begin
  //Memastikan TEdit tidak kosong
  if Trim(EditY.Text) = '' then
    ShowMessage('Field ini tidak boleh kosong');

  if Trim(EditX.Text) = '' then
    ShowMessage('Field ini tidak boleh kosong');

  //Membuat Column
  for i := 0 to 5 do
    StringGrid1.AddObject(TStringColumn.Create(Self));

  //Memberi Teks Header
  StringGrid1.RowCount := N+1;
  StringGrid1.Columns[0].Header := '#';
  StringGrid1.Columns[1].Header := 'Y';
  StringGrid1.Columns[2].Header := 'X';
  StringGrid1.Columns[3].Header := 'X.Y';
  StringGrid1.Columns[4].Header := 'Y²';
  StringGrid1.Columns[5].Header := 'X²';

  //Memasukkan dan memecah inputan TEdit menjadi Array
  InputY  := TStringList.Create;
  InputX := TStringList.Create;
  Split(' ',EditY.Text,InputY);
  Split(' ',EditX.Text,InputX);

  //Menentukan Length Array sesuai N
  SetLength(X,N);
  SetLength(Y,N);
  SetLength(XY,N);
  SetLength(Xkuad,N);
  SetLength(Ykuad,N);
  SetLength(Xbarkuad,N);
  SetLength(Ybarkuad,N);
  SetLength(Ycap,N);

  for i := 0 to N-1 do
    begin
      //Memasukkan nilai-nilai kedalam Array
      Y[i]  := StrToFloat(InputY[i]);
      X[i] := StrToFloat(InputX[i]);
      XY[i] := X[i]*Y[i];
      Ykuad[i]  := Sqr(Y[i]);
      Xkuad[i] := Sqr(X[i]);

      //Menampilkan nilai-nilai kedalam StringGrid
      StringGrid1.Cells[0,i] := IntToStr(i+1);
      StringGrid1.Cells[1,i] := FloatToStr(Y[i]);
      StringGrid1.Cells[2,i] := FloatToStr(X[i]);
      StringGrid1.Cells[3,i] := FloatToStr(XY[i]);
      StringGrid1.Cells[4,i] := FloatToStr(Ykuad[i]);
      StringGrid1.Cells[5,i] := FloatToStr(Xkuad[i]);
    end;

  //Menghitung Sigma-sigma
  StringGrid1.Cells[0,N] := '∑ =';
  SigmaY    := Sum(Y);
  SigmaX    := Sum(X);
  SigmaXY   := Sum(XY);
  SigmaYkuad:= Sum(Ykuad);
  SigmaXkuad:= Sum(Xkuad);

  //Menampilkan Sigma-sigma
  StringGrid1.Cells[1,N] := FormatFloat(',0.##',SigmaY);
  StringGrid1.Cells[2,N] := FormatFloat(',0.##',SigmaX);
  StringGrid1.Cells[3,N] := FormatFloat(',0.##',SigmaXY);
  StringGrid1.Cells[4,N] := FormatFloat(',0.##',SigmaYkuad);
  StringGrid1.Cells[5,N] := FormatFloat(',0.##',SigmaXkuad);

  //Menghitung ukuran Pemusatan
  meanY := Mean(Y);
  meanX := Mean(X);

  for i := 0 to N-1 do
    begin
      Ybarkuad[i]  := Sqr(Y[i]-meanY);
      Xbarkuad[i] := Sqr(X[i]-meanX);
    end;

  //Menghitung ukuran penyebaran
  StDevY := Sqrt(Sum(Ybarkuad)/N);
  StDevX := Sqrt(Sum(Xbarkuad)/N);

  //Menampilkan ukuran Pemusatan&Penyebaran
  ListBoxItem1.Text := 'Mean Y = ' + FormatFloat(',0.#####',meanY);
  ListBoxItem2.Text := 'Mean X = ' + FormatFloat(',0.#####',meanX);
  ListBoxItem3.Text := 'StDev Y = ' + FormatFloat(',0.#####',StDevY);
  ListBoxItem4.Text := 'StDev X = ' + FormatFloat(',0.#####',StDevX);

  //Menghitung Regresi
  b := ((N*SigmaXY)-(SigmaX*SigmaY))/((N*SigmaXkuad)-Sqr(SigmaX));
  a := meanY - (b*meanX);


  LabelEquation.Text := 'Y = ' +  FloatToStr(RoundTo(a,-2)) + ' + ' +
                              FloatToStr(RoundTo(b,-2)) + '*X';
  ListBoxItem5.Text := 'a = ' + FormatFloat(',0.#####',a);
  ListBoxItem6.Text := 'b = ' + FormatFloat(',0.#####',b);

  //Menghitung Korelasi
  r := ((N*SigmaXY) - (SigmaX*SigmaY))/
      (sqrt((N*SigmaXkuad)-sqr(SigmaX))*sqrt((N*SigmaYkuad)-sqr(SigmaY)));

  //Menampilkan Korelasi
  ListBoxItem7.Text := 'r = ' + FormatFloat('0.#####',r);
  ListBoxItem8.Text := 'r² = ' + FormatFloat('0.#####',Sqr(r));

  //Menghitung Standard Error
  Se := Sqrt((Sum(Ybarkuad)-Sqr(b)*Sum(Xbarkuad))/(N-2));
  Seb := Sqrt(Sqr(Se)/Sum(Xbarkuad));
  Sea := Sqrt(Sqr(Se)*SigmaXkuad/(N*Sum(XbarKuad)));

  //Menampilkan Standard Error
  ListBoxItem9.Text := 'Std. Error = ' + FormatFloat('0.#####',Se);
  ListBoxItem10.Text := 'Std. Error a = ' + FormatFloat('0.#####',Sea);
  ListBoxItem11.Text := 'Std. Error b = ' + FormatFloat('0.#####',Seb);

  //Menghitung t
  ta := a/Sea;
  tb := b/Seb;

  //Menampilkan t
  ListBoxItem12.Text := 't(a) = ' + FormatFloat('0.#####',ta);
  ListBoxItem13.Text := 't(b) = ' + FormatFloat('0.#####',tb);

  //Grafik
  for i := 0 to N-1 do
  begin
    Ycap[i] := a + (b*X[i]);

    Chart1.Series[0].AddXY(X[i],Y[i]);
    Chart1.Series[1].AddXY(X[i],Ycap[i]);
  end;

  Panel1.Visible := False;
  btnReset.Enabled  := True;
  btnAnalyze.Enabled := False;
  btnForecast.Enabled := True;
end;

procedure TfRLS.btnForecastClick(Sender: TObject);
var estX, estY : Double;
begin
  if Trim(EditForX.Text) = '' then
  begin
    ShowMessage('X₁ tidak boleh kosong');
    EditX.SetFocus;
    Exit;
  end;

  estX := StrToFloat(EditForX.Text);
  estY  := a + (b*estX);
  EditForY.Text := FloatToStr(RoundTo(estY,-2));
end;

procedure TfRLS.btnResetClick(Sender: TObject);
begin
  //Menghapus TStringGrid
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

  EditSetN.Text := '';
  EditY.Text := '';
  EditX.Text := '';
  EditForY.Text := '';
  EditForX.Text := '';

  N := 0;
  SigmaY := 0; SigmaX :=0; SigmaXY := 0;
  SigmaYkuad := 0; SigmaXkuad := 0;
  meanY := 0; meanX := 0; StDevY := 0; StDevX := 0;
  a := 0; b := 0; r := 0;
  Se := 0; Sea := 0; Seb := 0; ta := 0; tb := 0;

  SetLength(Y,N);
  SetLength(X,N);
  SetLength(XY,N);
  SetLength(Ykuad,N);
  SetLength(Xkuad,N);
  SetLength(Ycap,N);
  SetLength(Ybarkuad,N);
  SetLength(Xbarkuad,N);

  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;

  btnForecast.Enabled := False;
  btnSetN.Enabled := True;
  btnReset.Enabled := False;
  EditSetN.Enabled := True;
  EditSetN.SetFocus;
end;

end.
