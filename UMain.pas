unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxCore, dxRibbonSkins,
  dxRibbonCustomizationForm, dxBar, cxClasses, dxRibbon, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, cxImageList, Vcl.ExtCtrls,
  dxStatusBar, UGridFrame, TMSLogging;

type
  TfrmMain = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarComboSettimane: TdxBarCombo;
    imgList16: TcxImageList;
    ActionList1: TActionList;
    actSave: TAction;
    toolbarquick: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarEdit1: TdxBarEdit;
    imgList24: TcxImageList;
    actMakeDownloadDoc: TAction;
    dxBarLargeButton1: TdxBarLargeButton;
    dxRibbon1Tab2: TdxRibbonTab;
    dxBarManager1Bar2: TdxBar;
    actConnessione1: TAction;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxStatusBar1: TdxStatusBar;
    Panel1: TPanel;
    umgListStatusBar: TcxImageList;
    dxBarComboMacchine: TdxBarCombo;
    actRefresh: TAction;
    dxBarLargeButton3: TdxBarLargeButton;
    procedure ShowDBParamsClick(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actMakeDownloadDocExecute(Sender: TObject);
    procedure actConnessione1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxStatusBar1Panels0PanelStyleGetText(Sender: TObject;
      const R: TRect; var AText: string);
    procedure dxBarComboSettimaneChange(Sender: TObject);
    procedure actMakeDownloadDocUpdate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure dxBarComboMacchineDestroy(Sender: TObject);
  private
    { Private declarations }
    FDataGrid: TGridFrame;
    procedure LoadMachinesList;
    procedure LoadPrograms;
    procedure ShowMessage(const aCaption, aTitle, AText: string;
      aMainIcon: TTaskDialogIcon = tdiInformation);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses UGestionaleParams, UMagClasses, UDDTInterface, UGestGoContainer,
  Generics.Collections, UDbProductionContainer, UProductionClasses;

procedure TfrmMain.actConnessione1Execute(Sender: TObject);
begin
  dlgGoParams.ShowModal
end;

procedure TfrmMain.actMakeDownloadDocExecute(Sender: TObject);
var
  lDDt: IDDTDATA;
  lDDTMat: TList<IDDTItem>;
  i: integer;
  q: Double;
  um: string;
begin

  lDDTMat := TList<IDDTItem>.Create;
  try

    i := 0;
    with dbProductionContainer.vqTotals do
    begin

      open;

      while not eof do
      begin
        // prende l'unità di misura  ... dal codice utilizzato
        um := GestGoContainer.GetUMArt(Fields[0].AsString);
        if um = 'MC' then
          q := Fields[3].AsFloat;
        if um = 'MQ' then
          q := Fields[2].AsFloat;

        lDDTMat.Add(TMat_Prima.Create(       Fields[2].AsString,
          Fields[3].AsString, q,Fields[0].AsInteger,   Fields[1].AsDateTime));

        inc(i);
        next
      end;
      close;
    end;

    lDDt := TDDT_SCPR.Create(lDDTMat);

    GestGoContainer.RegistraDDT(lDDt);

    // qui posso registrare i riferimenti gestionale "GO" -> riga rapportino

    for i := 0 to  lDDTMat.Count - 1 do
    begin


      tmslogger.info( format('data : %s   macchina id : %d   cordinate Go :  %d - > %d',
      [datetostr(TMat_Prima(lddtmat[i]).DataScheda), TMat_Prima(lddtmat[i]).IdMacchina,  TMat_Prima(lddtmat[i]).GO_progressivo, TMat_Prima(lddtmat[i]).GO_Riga]));

    end;

    // qui io dovrei avere nella lista delle interfaccia dettaglio ddt
    // i riferimenti delle righe


    ShowMessage('doMag', 'Scarico materia prima',
      format('Sono stati scaricati %d articoli ', [lDDTMat.Count]))

  finally
    lDDTMat.Free
  end;

end;

procedure TfrmMain.actMakeDownloadDocUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FDataGrid.AreThereSelectedRows
end;

procedure TfrmMain.actRefreshExecute(Sender: TObject);
begin
     dxBarComboSettimaneChange(dxBarComboSettimane);
end;

procedure TfrmMain.actSaveExecute(Sender: TObject);
begin
  ShowMessage('Info', 'Salvataggio dati', 'lavoro salvato')
end;

procedure TfrmMain.dxBarComboMacchineDestroy(Sender: TObject);
var
  i: integer;
begin
  with (Sender as TdxBarCombo) do
  begin
    for i := 0 to Items.Count - 1 do
      Tmacchina(Items.Objects[i]).Free

  end;
end;

procedure TfrmMain.dxBarComboSettimaneChange(Sender: TObject);
begin

  with dbProductionContainer do
  begin
    UniQuery1.close;
    try
      var
      p := dxBarComboSettimane.Text;

      UniQuery1.Macros[0].Value := QuotedStr(p + '%');
      UniQuery1.Params[0].AsInteger :=
        Tmacchina(dxBarComboMacchine.Items.Objects
        [dxBarComboMacchine.ItemIndex]).FId;
      UniQuery1.open;
      FDataGrid.SetDataSource(UniDataSource1, true);
      FDataGrid.ApplyBestFit;

    except
      // on e: EStringListError do
      // ShowMessage('Errore', 'Selezione materiale rapportini',
      // 'Per favore seleziona macchina e programma', tdiError)

    end;
  end;
end;

procedure TfrmMain.dxStatusBar1Panels0PanelStyleGetText(Sender: TObject;
  const R: TRect; var AText: string);
var
  okConnectionToDb: Boolean;
begin
  okConnectionToDb := dbProductionContainer.SetConnection;
  if okConnectionToDb then
  begin

    AText := 'Database connesso';
    (dxStatusBar1.Panels[0].PanelStyle as TdxStatusBarTextPanelStyle)
      .ImageIndex := 0
  end
  else
  begin
    AText := 'Database non connesso';
    (dxStatusBar1.Panels[0].PanelStyle as TdxStatusBarTextPanelStyle)
      .ImageIndex := 1
  end;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dxRibbon1.BarManager.SaveToIniFile('mysettings.ini')
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  if FileExists('mysettings.ini') then
    dxRibbon1.BarManager.loadfromIniFile('mysettings.ini');

  LoadPrograms;
  LoadMachinesList;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

  FDataGrid := TGridFrame.Create(self);
  FDataGrid.Parent := Panel1;
  FDataGrid.Align := alClient;

end;

procedure TfrmMain.LoadPrograms;
begin
  with dbProductionContainer do
  begin
    var
    a := GetPrograms;
    dxBarComboSettimane.Items.AddStrings(a)
  end;

end;

procedure TfrmMain.LoadMachinesList;
var
  m: TMacchine;
  i: integer;
begin
  with dbProductionContainer do
  begin
    m := GetListOfMachines;
    try

      for i := 0 to m.Count - 1 do

        dxBarComboMacchine.Items.AddObject(m[i].FName, m[i]);

      // dxBarComboMacchine.ItemIndex := 0;

    finally
      // for i := 0 to m.Count - 1 do
      // m[i].Free;
      m.Free
    end;
  end;

end;

procedure TfrmMain.ShowDBParamsClick(Sender: TObject);
begin
  dlgGoParams.ShowModal
end;

procedure TfrmMain.ShowMessage(const aCaption, aTitle, AText: string;
  aMainIcon: TTaskDialogIcon = tdiInformation);
begin
  with TTaskDialog.Create(nil) do
  begin

    try
      Caption := aCaption;
      Title := aTitle;
      Text := AText;
      MainIcon := aMainIcon;
      CommonButtons := [tcbOk];
      execute;

    finally
      Free
    end;

  end;
end;

end.
