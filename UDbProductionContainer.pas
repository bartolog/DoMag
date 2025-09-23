unit UDbProductionContainer;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, UniProvider,
  MySQLUniProvider, MemDS, DASQLMonitor, UniSQLMonitor, VirtualQuery,
  UProductionClasses;

type
  TdbProductionContainer = class(TDataModule)
    UniConnection1: TUniConnection;
    UniQuery1: TUniQuery;
    MySQLUniProvider1: TMySQLUniProvider;
    UniDataSource1: TUniDataSource;
    UniSQLMonitor1: TUniSQLMonitor;
    vqTotals: TVirtualQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function SetConnection: Boolean;
    function GetListOfMachines: TMacchine;
  end;

var
  dbProductionContainer: TdbProductionContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdbProductionContainer }

function TdbProductionContainer.GetListOfMachines: TMacchine;
var
  q: TUniQuery;
  m: TMacchina;
begin
  result := TMacchine.Create;

  q := TUniQuery.Create(Self);
  try
    q.Connection := UniConnection1;
    q.SQL.Add('SELECT * FROM macchine');
    q.Open;
    while not q.Eof do
    begin

      m := TMacchina.Create;
      m.FCodice := q.Fields[0].AsString;
      m.FId := q.Fields[1].AsInteger;
      m.FName := q.Fields[2].AsString;
      m.FCodiceLavorazione := q.Fields[3].AsString;
      result.Add(m);

      q.Next
    end;
    q.Close;
  finally
    q.Free
  end;

end;

function TdbProductionContainer.SetConnection: Boolean;
begin
  UniConnection1.Open;
  result := UniConnection1.Connected
end;

end.
