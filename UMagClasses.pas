unit UMagClasses;

interface

uses
  UDDTInterface, system.Generics.Collections;

type

  TMat_Prima = class(TInterfacedObject, IDDTItem)
  private

    FCode: string; // codice materia prima
    FDescrizione: string; // descrizione del materiale
    FQta: double; // quantità impèiegata

  public

    constructor Create(aCode, adescr: string; aQta: double);

    function GetIsDescrizione: Boolean;
    Function GetCodiceArticolo: string;
    Function GetDescrizione: string;
    function GetOrdine: string;
    function GetPosizione: integer;
    Function GetQuantita: double;
    function GetColli: integer;

    property Colli: integer read GetColli;

    property IsDescrizione: Boolean read GetIsDescrizione;
    property CodiceArticolo: string read GetCodiceArticolo;
    property Descrizione: string read GetDescrizione;
    property Quantita: double read GetQuantita;
    property Ordine: string read GetOrdine;
    property Posizione: integer read GetPosizione;

  end;

  TMateriePrime = Tlist<IDDTItem>;

  TDDT_SCPR = class(TInterfacedObject, IDDTDATA)

  private
    FDone: Boolean;
    FProgressivo: integer;
    FMateriePrime: Tlist<IDDTItem>;

  public

    constructor Create(aListMat: TMateriePrime);

    Function GetCodiceDestinatario: string; // Il codice cliente
    Function GetCodiceDestinazione: string;
    // il codice del magazzino ... da cui ricavarel'inidirizzo
    Function GetCodiceVettore: string; // il codice spedizione (vettore)
    Function GetColli: double; // il numero delle confezioni
    Function GetNote: string; // eventuali note
    Function GetAnnoEsercizio: string; // anno esercizio
    function GetTotaleRigheDDT: integer;
    procedure SetDone(aValue: Boolean);
    procedure SetResult(aValue: variant);
    function GetPalletsNumber: string;
    function GetScadenze: string;
    function GetTipoDoc: string;

    // righe descrizione da aggiungere in fondo
    function GetDescrizionePiede: Tarray<string>;
    function GetDescrizioneTesta: Tarray<string>;

    property CodiceDestinatario: string read GetCodiceDestinatario;

    property CodiceDestinazione: string read GetCodiceDestinazione;
    property CodiceVettore: string read GetCodiceVettore;
    property Colli: double read GetColli;
    property Note: string read GetNote;
    property AnnoEsercizio: string read GetAnnoEsercizio;
    property Totalerigheddt: integer read GetTotaleRigheDDT;

    function GetDetailDDt: Tlist<IDDTItem>;

  end;

implementation

{ TDDT_SCPR }

uses
  system.SysUtils;

constructor TDDT_SCPR.Create(aListMat: TMateriePrime);
begin
  FMateriePrime := aListMat
end;

function TDDT_SCPR.GetAnnoEsercizio: string;
var
  y, m, d: word;
begin

  DecodeDate(now, y, m, d);
  result := y.ToString

end;

function TDDT_SCPR.GetCodiceDestinatario: string;
begin
  result := 'PRODUZIO'
end;

function TDDT_SCPR.GetCodiceDestinazione: string;
begin
  result := ''
end;

function TDDT_SCPR.GetCodiceVettore: string;
begin
  result := 'MITT'
end;

function TDDT_SCPR.GetColli: double;
begin
  result := FMateriePrime.Count
end;

function TDDT_SCPR.GetDescrizionePiede: Tarray<string>;
begin
  result := []
end;

function TDDT_SCPR.GetDescrizioneTesta: Tarray<string>;
begin
  result := []
end;

function TDDT_SCPR.GetDetailDDt: Tlist<IDDTItem>;
begin
  result := FMateriePrime
end;

function TDDT_SCPR.GetNote: string;
begin
  result := ''
end;

function TDDT_SCPR.GetPalletsNumber: string;
begin
  result := ''
end;

function TDDT_SCPR.GetScadenze: string;
begin
  result := ''
end;

function TDDT_SCPR.GetTipoDoc: string;
begin
  result := 'SCPR'
end;

function TDDT_SCPR.GetTotaleRigheDDT: integer;
begin
  result := FMateriePrime.Count
end;

procedure TDDT_SCPR.SetDone(aValue: Boolean);
begin
  FDone := aValue
end;

procedure TDDT_SCPR.SetResult(aValue: variant);
begin
  FProgressivo := aValue
end;

{ TMat_Prima }

constructor TMat_Prima.Create(aCode, adescr: string; aQta: double);
begin
  inherited Create;

  FCode := aCode;
  FDescrizione := adescr;
  FQta := aQta

end;

function TMat_Prima.GetCodiceArticolo: string;
begin
  result := FCode
end;

function TMat_Prima.GetColli: integer;
begin
  result := 1
end;

function TMat_Prima.GetDescrizione: string;
begin
  result := FDescrizione
end;

function TMat_Prima.GetIsDescrizione: Boolean;
begin
  result := false
end;

function TMat_Prima.GetOrdine: string;
begin
  result := ''
end;

function TMat_Prima.GetPosizione: integer;
begin
  result := -1
end;

function TMat_Prima.GetQuantita: double;
begin
  result := FQta
end;

end.
