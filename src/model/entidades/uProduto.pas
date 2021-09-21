unit uPRODUTO;

interface

uses SimpleAttributes;

type
  [Tabela('produto')]
  TPRODUTO = class
    private
    FPRECO: Currency;
    FDESCRICAO: String;
    FID: Integer;
    FCATEGORIA: Integer;
    procedure SetCATEGORIA(const Value: Integer);
    procedure SetDESCRICAO(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetPRECO(const Value: Currency);
    public
      constructor Create;
      destructor Destroy; override;
    published
      [Campo('ID'), Pk, AutoInc]
      property ID : Integer read FID write SetID;
      [Campo('DESCRICAO')]
      property DESCRICAO : String read FDESCRICAO write SetDESCRICAO;
      [Campo('CATEGORIA'), FK]
      property CATEGORIA : Integer read FCATEGORIA write SetCATEGORIA;
      [Campo('PRECO')]
      property PRECO : Currency read FPRECO write SetPRECO;
  end;


implementation

{ TPRODUTO }

constructor TPRODUTO.Create;
begin

end;

destructor TPRODUTO.Destroy;
begin

  inherited;
end;

procedure TPRODUTO.SetCATEGORIA(const Value: Integer);
begin
  FCATEGORIA := Value;
end;

procedure TPRODUTO.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TPRODUTO.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPRODUTO.SetPRECO(const Value: Currency);
begin
  FPRECO := Value;
end;

end.
