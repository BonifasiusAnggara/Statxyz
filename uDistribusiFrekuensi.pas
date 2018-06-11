﻿unit uDistribusiFrekuensi;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Memo, FMXTee.Engine, FMXTee.Series, FMXTee.Procs,
  FMXTee.Chart, FMX.ListBox, FMX.Edit, FMX.Layouts, FMX.StdCtrls, FMX.ScrollBox,
  FMX.Grid, FMX.TabControl, FMX.Controls.Presentation, Math;

type
  TfDF = class(TForm)
    ToolBar1: TToolBar;
    btnInfo: TButton;
    btnClose: TButton;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    StringGrid1: TStringGrid;
    ToolBar2: TToolBar;
    EditSetN: TEdit;
    btnSetN: TButton;
    btnReset: TButton;
    btnAnalyze: TButton;
    Panel1: TPanel;
    ListBox2: TListBox;
    ListBoxItem14: TListBoxItem;
    Label2: TLabel;
    EditData: TEdit;
    ClearEditButton1: TClearEditButton;
    TabItem2: TTabItem;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    ListBoxItem13: TListBoxItem;
    ListBoxItem15: TListBoxItem;
    ListBoxItem16: TListBoxItem;
    ListBoxItem17: TListBoxItem;
    ListBoxItem18: TListBoxItem;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    ListBoxItem19: TListBoxItem;
    ListBoxItem20: TListBoxItem;
    TabItem3: TTabItem;
    Chart1: TChart;
    Series1: TBarSeries;
    Memo1: TMemo;
    procedure btnInfoClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSetNClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    { Private declarations }
    N : Integer;
    Data : Array of Double;
    Xi : Array of Double;
    Xbarkuad : array of Double;
    bawah : Array of Double;
    atas : Array of Double;
    fi : Array of Double;
    fKum : Array of Double;
    fiXi : Array of Double;
    Range, Interval, maxD, minD : Double;
    Sigmafi, SigmafiXi, MeanXi, Xbar : Double;
    batasatas, batasbawah : Double;
    modN, modKelas : Integer;
    med, Median, Lo, fmo, f1o, f2o : Double;
    Lmo, modus : Double;
    kelas, fio, fm : Double;
    kelasint : Integer;
    StDev, Varians : Double;
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
  public
    { Public declarations }
  end;

var
  fDF: TfDF;

implementation

{$R *.fmx}

uses uDMStyle;

procedure TfDF.FormCreate(Sender: TObject);
begin
  EditSetN.SetFocus;
end;

// procedure untuk split string
procedure TfDF.Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

procedure TfDF.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfDF.btnInfoClick(Sender: TObject);
begin
  Memo1.Visible := not Memo1.Visible;
end;

procedure TfDF.btnSetNClick(Sender: TObject);
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
  Setlength(Data,N);
  SetLength(Xbarkuad,N);

  EditSetN.Enabled  := False;
  btnSetN.Enabled   := False;
  Panel1.Visible  := True;
  btnAnalyze.Enabled := True;
  EditData.SetFocus;
end;

procedure TfDF.btnAnalyzeClick(Sender: TObject);
  var i, j, x : Integer; InputData : TStringList;
Stringkelas : String;
temp, y : Double;

begin
  //Memastikan TEdit tidak kosong
  if Trim(EditData.Text) = '' then
  begin
    ShowMessage('Field ini tidak boleh kosong');
    EditData.SetFocus;
    Exit;
  end;

  //Membuat Column
  for i := 0 to 5 do
    StringGrid1.AddObject(TStringColumn.Create(Self));

  //Memberi Teks Header
  StringGrid1.Columns[0].Header := 'Batas Kelas';
  StringGrid1.Columns[1].Header := 'Nilai Tengah';
  StringGrid1.Columns[2].Header := 'Frekuensi';
  StringGrid1.Columns[3].Header := 'Frekuensi Kumulatif';
  StringGrid1.Columns[4].Header := 'Frekuensi Relatif';
  StringGrid1.Columns[5].Header := 'Xᵢ.fᵢ';

  //SUBROUTINE DISTRIBUSI FREKUENSI

  //Input Data
  InputData  := TStringList.Create;
  Split(' ',EditData.Text,InputData);
  for i := 0 to N-1 do
    //Memasukkan nilai-nilai kedalam Array
    Data[i]  := StrToFloat(InputData[i]);

  //Jumlah kelas
  kelas := 1 + 3.322*Log10(N);
  kelas := floor(kelas);
  ListboxItem1.Text := 'Jumlah Data = ' + FloatToStr(length(Data));
  ListboxItem2.Text := 'Jumlah Kelas = ' + FloatToStr(kelas);

  //Mencari nilai min dan max, Range dan Interval
  minD := Data[0];
  maxD := Data[0];
  for i := 0 to N-1 do
    begin
      if Data[i] > maxD then
        maxD := Data[i];
      if Data[i] < minD then
        minD := Data[i];
    end;
  Range := maxD - minD;
  Interval := Range/kelas;
  Interval := Round(Interval);
  ListboxItem3.Text := 'Data Min = ' + FloatToStr(minD);
  ListboxItem4.Text := 'Data Max = ' + FloatToStr(maxD);
  ListboxItem5.Text := 'Range = ' + FloatToStr(Range);
  ListboxItem6.Text := 'Interval = ' + FloatToStr(Interval);

  //Menampilkan Kelas Kelas
  Stringkelas := FloatToStr(kelas);
  kelasint := StrToInt(Stringkelas);
  StringGrid1.RowCount := kelasint+1;
  SetLength(bawah,kelasint);
  SetLength(atas,kelasint);
  batasbawah := minD;
  batasatas := minD + Interval-0.01;

  for i := 0 to kelasint-2 do
  begin
    bawah[i] := batasbawah;
    atas[i] := batasatas;
    StringGrid1.Cells[0,i] := FloatToStr(batasbawah) + ' - ' +
                                FloatToStr(batasatas);
    batasbawah := batasatas + 0.01;
    batasatas := batasbawah + Interval-0.01;
  end;
  StringGrid1.Cells[0,kelasint-1] := FloatToStr(batasbawah) + ' - ' +
                                FloatToStr(maxD);
  bawah[kelasint-1] := batasbawah;
  atas[kelasint-1] := maxD;

  //Membuat nilai tengah
  Setlength(Xi,kelasint);
  batasbawah := minD;
  batasatas := minD + Interval-0.01;

  for i := 0 to kelasint-2 do
  begin
    Xi[i] := (batasbawah + batasatas)/2;
    StringGrid1.Cells[1,i] := FloatToStr(Xi[i]);
    batasbawah := batasatas + 0.01;
    batasatas := batasbawah + Interval-0.01;
  end;
  Xi[kelasint-1] := (batasbawah+maxD)/2;
  StringGrid1.Cells[1,kelasint-1] := FloatToStr(Xi[kelasint-1]);


  //Menghitung frekuensi xi
  begin
    SetLength(fi,kelasint);
    batasbawah := minD;
    batasatas := minD + Interval-0.01;

    for i := 0 to kelasint-2 do
    begin
      x := 0;
      for j := 0 to N-1 do
        begin
          if (Data[j] >= batasbawah) and (Data[j] <= batasatas) then
          x := x + 1;
        end;
      fi[i] := x;
      StringGrid1.Cells[2,i] := FloatToStr(fi[i]);
      batasbawah := batasatas + 0.01;
      batasatas := batasbawah + Interval-0.01;
    end;

    x := 0;
    for j := 0 to N-1 do
    begin
      if (Data[j] >= batasbawah) and (Data[j] <= maxD) then
      x := x + 1;
    end;
    fi[kelasint-1] := x;
    StringGrid1.Cells[2,kelasint-1] := FloatToStr(fi[kelasint-1]);
    StringGrid1.Cells[2,kelasint] := '∑ = ' + FloatToStr(Sum(fi));
  end;

  //Menampilkan Grafik
  begin
    for i := 0 to kelasint-1 do
      Chart1.Series[0].AddXY(Xi[i],fi[i]);
  end;

  //Menghitung frekuensi kumulatif
  begin
    SetLength(fKum,kelasint);
    y := 0;
    for i := 0 to kelasint-1 do
      begin
      y := y + fi[i];
      fKum[i] := y;
      StringGrid1.Cells[3,i] := FloatToStr(fKum[i]);
      end;
  end;

  //Menghitung frekuensi relatif
  begin
    Sigmafi := Sum(fi);
    for i := 0 to kelasint-1 do
      StringGrid1.Cells[4,i] := FloatToStr(RoundTo((fi[i]/Sigmafi),-2));
  end;

  //WACANA BESAR UKURAN PEMUSATAN

  //Menghitung Mean
  begin
    SetLength(fiXi,kelasint);
    for i := 0 to kelasint-1 do
    begin
      fiXi[i] := fi[i]*Xi[i];
      StringGrid1.Cells[5,i] := FloatToStr(fiXi[i]);
    end;
    SigmafiXi := Sum(fiXi);
    StringGrid1.Cells[5,kelasint] := '∑ = ' + FloatToStr(SigmafiXi);
    MeanXi := SigmafiXi/Sigmafi;
    Xbar := Mean(Data);
  end;

  //Menghitung Median
  begin
    //Mengurutkan elemen array
    begin
      for i := 0 to N-2 do
      begin
        for j := 1 to N-1 do
        begin
          if (Data[i] > Data[j]) then
          begin
          temp := Data[j];
          Data[j] := Data[i];
          Data[i] := temp;
          end;
        end;
      end;
    end;

    //Mencari nilai med
    begin
    modN := N mod 2;
    if modN = 0 then
      begin
        for i := 0 to N-1 do
          begin
          if i = N/2 then
          med := (Data[i-1]+Data[i])/2
          end;
      end
    else
      begin
        for i := 0 to N-1 do
          begin
          if i = N/2-0.5 then
          med := Data[i]
          end;
      end;
    end;

    //Mencari batas bawah / L0
    begin
    batasbawah := minD;
    modKelas := kelasint mod 2;
    if modKelas = 0 then
      begin
        for i := 1 to kelasint do
          begin
          if i <= kelasint/2 then
          batasbawah := batasbawah + Interval
          end;
      end
    else
      begin
        for i := 1 to kelasint do
          begin
          if i <= kelasint/2+0.5 then
          batasbawah := batasbawah + Interval
          end;
      end;
    Lo := batasbawah-Interval-0.005
    end;

    //Mencari fi0 dan fm
    begin
    if modKelas = 0 then
      begin
        for i := 1 to kelasint do
          if i = kelasint/2 then
          begin
          fm := fi[i-1];
          fio := fKum[i-2];
          end;
      end
    else
      begin
        for i := 1 to kelasint do
          if i = kelasint/2+0.5 then
          begin
          fm := fi[i-1];
          fio := fKum[i-2];
          end;
      end;
    end;

    //Menghitung Median
    begin
      temp := (N/2-fio)/fm * Interval;
      Median := Lo + temp;
    end;
  end;

  //Menghitung Modus
  begin
    fmo := 0;
    for i := 0 to kelasint-1 do
      begin
        if fi[i] > fmo then
        begin
        fmo := fi[i];
        f1o := fmo-fi[i-1];
        f2o := fmo-fi[i+1];
        Lmo := (bawah[i]+atas[i-1])/2;
        end;
      end;
    temp := f1o/(f1o+f2o)*Interval;
    modus := Lmo + temp;
  end;

  //Menghitung Ukuran Penyebaran
  for i := 0 to N-1 do
    Xbarkuad[i] := Sqr(Data[i]-Xbar);

  Varians := Sum(Xbarkuad)/N;
  StDev := Sqrt(Varians);

  //Menampilkan data-data
  ListboxItem7.Text := 'Mean Xᵢ = ' + FloatToStr(RoundTo(MeanXi,-2));
  ListboxItem8.Text := 'µ = ' + FloatToStr(RoundTo(Xbar,-3));
  ListboxItem9.Text := 'Med = ' + FloatToStr(med);
  ListboxItem10.Text := 'L₀ = ' + FloatToStr(Lo);
  ListboxItem11.Text := '∑fᵢ₀ = ' + FloatToStr(fio);
  ListboxItem12.Text := 'fm = ' + FloatToStr(fm);
  ListboxItem13.Text := 'Median = ' + FloatToStr(RoundTo(Median,-3));
  ListboxItem14.Text := 'fm₀ = ' + FloatToStr(fmo);
  ListboxItem15.Text := 'f₁₀ = ' + FloatToStr(f1o);
  ListboxItem16.Text := 'f₂₀ = ' + FloatToStr(f2o);
  ListboxItem17.Text := 'Lm₀ = ' + FloatToStr(Lmo);
  ListboxItem18.Text := 'Modus = ' + FloatToStr(RoundTo(modus,-3));
  ListboxItem19.Text := 'Varians = ' + FormatFloat(',0.####',Varians);
  ListboxItem20.Text := 'Std. Deviation = ' + FormatFloat(',0.####',StDev);

  Panel1.Visible := False;
  btnReset.Enabled  := True;
  btnAnalyze.Enabled := False;
end;

procedure TfDF.btnResetClick(Sender: TObject);
var i : integer;
begin
  //Menghapus TStringGrid
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;
  StringGrid1.Columns[0].DisposeOf;

  //Menghapus ListBox
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
  EditSetN.Text := '';
  EditData.Text := '';

  N := 0;
  SetLength(Data,N);
  SetLength(Xi,N);
  SetLength(bawah,N);
  SetLength(atas,N);
  SetLength(fi,N);
  SetLength(fKum,N);
  SetLength(fiXi,N);
  SetLength(Xbarkuad,N);
  Range := 0; Interval := 0; maxD := 0; minD := 0;
  Sigmafi := 0; SigmafiXi := 0; MeanXi := 0; Xbar := 0;
  batasatas := 0; batasbawah := 0;
  modN := 0; modKelas := 0;
  med := 0; Median := 0; Lo := 0;
  fmo := 0; f1o := 0; f2o := 0;
  Lmo := 0; modus := 0;
  kelas := 0; fio := 0; fm := 0;
  kelasint := 0; Varians := 0; StDev := 0;

  Chart1.Series[0].Clear;

  btnSetN.Enabled := True;
  btnReset.Enabled := False;
  EditSetN.Enabled := True;
  EditSetN.SetFocus;
end;

end.
