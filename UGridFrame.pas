unit UGridFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBAccess, Uni;

type
  TGridFrame = class(TFrame)
    tvMainDV: TcxGridDBTableView;
    tvMainLevel1: TcxGridLevel;
    tvMain: TcxGrid;
    cxStyleRepository1: TcxStyleRepository;
    cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet;
    siBold: TcxStyle;
  private
    { Private declarations }
    procedure CreateGridColumns;

  public
    { Public declarations }
    procedure ApplyBestFit;
    procedure SetDataSource(aDataSource: TDataSource;
      CreateColumns: boolean = true);

    function AreThereSelectedRows: boolean;

  end;

implementation

{$R *.dfm}
{ TGridFrame }

procedure TGridFrame.ApplyBestFit;
begin
  // tvMainDV.ApplyBestFit(nil,true,false)
end;

function TGridFrame.AreThereSelectedRows: boolean;
begin
  result := false;
  if assigned(tvMainDV.DataController.DataSource) then

    result := tvMainDV.DataController.GetSelectedCount > 0
end;

procedure TGridFrame.CreateGridColumns;
var
  ds: TDataSource;
  i: integer;
begin

  tvMainDV.ClearItems; // cancella tutte le colonne



  ds := tvMainDV.DataController.DataSource;

  // crea le colonne
  if assigned(ds) and assigned(ds.DataSet) then
  begin
    for i := 0 to ds.DataSet.FieldCount - 1 do
    begin
      with tvMainDV.CreateColumn do
      begin

        DataBinding.FieldName := ds.DataSet.Fields[i].FieldName;
        Caption := ds.DataSet.Fields[i].DisplayName;
        if ds.DataSet.Fields[i].DataType = ftFloat  then
         Summary.GroupKind  := skSum


      end;

    end;



  end;

end;

procedure TGridFrame.SetDataSource(aDataSource: TDataSource;
  CreateColumns: boolean);
begin
  tvMainDV.DataController.DataSource := aDataSource;

  tvMainDV.OptionsData.Appending := false;
  tvMainDV.OptionsData.Deleting := false;
  tvMainDV.OptionsData.Editing := false;
  tvMainDV.OptionsData.Inserting := false;
  tvMainDV.OptionsSelection.MultiSelect := true;

  if CreateColumns then
    CreateGridColumns

end;

end.
