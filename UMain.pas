unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    ShowDBParams: TButton;
    btnDoDDt: TButton;
    procedure ShowDBParamsClick(Sender: TObject);
    procedure btnDoDDtClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses UGestionaleParams, UMagClasses, UDDTInterface, UGestGoContainer,
  Generics.Collections;

procedure TfrmMain.btnDoDDtClick(Sender: TObject);
var
  lDDt: IDDTDATA;
  lDDTMat: TList<IDDTItem>;

begin

  lDDTMat := TList<IDDTItem>.Create;

  lDDTMat.Add(TMat_Prima.Create('mp_truc18', 'truciolare 18mm 3600x2070', 200));
  lDDTMat.Add(TMat_Prima.Create('mp_mult18', 'truciolare 18mm 2800x1500',
    250.154));
  lDDTMat.Add(TMat_Prima.Create('mp_masonite2',
    'truciolare 18mm 3600x2070', 50.104));

  lDDt := TDDT_SCPR.Create(lDDTMat);

  GestGoContainer.RegistraDDT(lDDt);

end;

procedure TfrmMain.ShowDBParamsClick(Sender: TObject);
begin
  dlgGoParams.ShowModal
end;

end.
