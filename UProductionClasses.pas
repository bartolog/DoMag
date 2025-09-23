unit UProductionClasses;

interface


uses
Generics.Collections;

type



TMacchina = class
  FCodice : string;
  FId : integer;
  FName : string;
  FCodiceLavorazione : string
end;

TMacchine = TList<TMacchina>;

implementation

end.
