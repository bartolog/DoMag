program DoMag;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  UMain in 'UMain.pas' {frmMain},
  UGestGoContainer in '..\DDTPallets2\UGestGoContainer.pas' {GestGoContainer: TDataModule},
  UGestionaleParams in '..\DDTPallets2\UGestionaleParams.pas' {dlgGoParams},
  UDDTInterface in '..\DDTPallets2\UDDTInterface.pas',
  UMagClasses in 'UMagClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdlgGoParams, dlgGoParams);
  Application.CreateForm(TGestGoContainer, GestGoContainer);
  Application.Run;
end.
