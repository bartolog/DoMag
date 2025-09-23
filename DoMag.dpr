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
  UMagClasses in 'UMagClasses.pas',
  UGridFrame in 'UGridFrame.pas' {GridFrame: TFrame},
  UDbProductionContainer in 'UDbProductionContainer.pas' {dbProductionContainer: TDataModule},
  UProductionClasses in 'UProductionClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdbProductionContainer, dbProductionContainer);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdlgGoParams, dlgGoParams);
  Application.CreateForm(TGestGoContainer, GestGoContainer);
  Application.Run;
end.
