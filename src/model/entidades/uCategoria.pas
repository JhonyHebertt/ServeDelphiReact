unit uCATEGORIA;

interface

uses
  SimpleAttributes;

type
  [Tabela('categorias')]
  TCATEGORIA = class
    private
    FDESCRICAO: String;
    FID: Integer;
    procedure SetDESCRICAO(const Value: String);
    procedure SetID(const Value: Integer);

    public
      constructor Create;
      destructor Destroy; override;
    published
      [Campo('ID'), Pk, AutoInc]
      property ID : Integer read FID write SetID;
      [Campo('DESCRICAO')]
      property DESCRICAO : String read FDESCRICAO write SetDESCRICAO;
  end;


implementation

{ TCATEGORIA }

constructor TCATEGORIA.Create;
begin

end;

destructor TCATEGORIA.Destroy;
begin

  inherited;
end;

procedure TCATEGORIA.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TCATEGORIA.SetID(const Value: Integer);
begin
  FID := Value;
end;

end.
