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
    cmdSetCoordinateGO: TUniSQL;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function SetConnection: Boolean;
    function GetListOfMachines: TMacchine;
    function GetPrograms: TArray<string>;
  end;

var
  dbProductionContainer: TdbProductionContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdbProductionContainer.DataModuleDestroy(Sender: TObject);
begin
    UniConnection1.Disconnect
end;

procedure TdbProductionContainer.DataModuleCreate(Sender: TObject);
begin
    UniConnection1.Connect
end;

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

function TdbProductionContainer.GetPrograms: TArray<string>;
var
  q: TUniQuery;
  y, m, d: word;
begin

  DecodeDate(Now, y, m, d);
  q := TUniQuery.Create(nil);
  try
    q.Connection := UniConnection1;
    q.SQL.Add('SELECT DISTINCT ANNO, CAST(NUMERO_SETTIMANA AS UNSIGNED) FROM commesse');
    q.SQL.Add(format('WHERE CAST(anno AS UNSIGNED) in (%d,%d,%d) AND CAST(Numero_Settimana AS UNSIGNED) <= 52', [y-1,y,y+1]));
    q.SQL.Add('ORDER BY CAST(anno AS UNSIGNED) DESC, CAST(NUMERO_SETTIMANA AS UNSIGNED) DESC') ;

    q.Open;
    SetLength(result, q.RecordCount);

    var
    i := 0;

    while not q.Eof do
    begin
      result[i] := format('%s/%s', [q.Fields[1].AsString, q.Fields[0].AsString]);
      inc(i);
      q.Next
    end;
    q.Close

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
