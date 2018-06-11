unit uDMStyle;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TDMStyle = class(TDataModule)
    StyleBookTransparent: TStyleBook;
    StyleBookAquaGraphite: TStyleBook;
    Win10ModernDark: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMStyle: TDMStyle;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
