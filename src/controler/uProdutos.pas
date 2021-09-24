unit uProdutos;

interface

uses
  Horse,
  System.JSON,
  uDAOGenerico,
  uProduto;

procedure Registry(App: THorse);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation


procedure Registry(App: THorse);
begin
  App.Get('/produtos', Get);
  App.Get('/produtos/:id', GetID);
  App.Post('/produtos', Insert);
  App.Put('/produtos/:id', Update);
  App.Delete('/produtos/:id', Delete);
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TPRODUTO>;
begin
  FDAO := TDAOGeneric<TPRODUTO>.New;
  Res.Send<TJSONObject>(FDAO.Insert(Req.Body<TJSONObject>));
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TPRODUTO>;
begin
  FDAO := TDAOGeneric<TPRODUTO>.New;

  FDAO
    .DAO
    .SQL
      .Fields('produtos.ID, produtos.DESCRICAO, produtos.CATEGORIA, produtos.PRECO, categorias.DESCRICAO AS CATEGORIA_DESCRICAO')
      .Join('INNER JOIN categorias ON produtos.CATEGORIA = categorias.ID')
      .Where('produtos.ID = ' + Req.Params.Items['id'])
    .&End
  .Find;

  Res.Send<TJSONObject>(FDAO.DataSetAsJsonObject);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TPRODUTO>;
begin
  FDAO := TDAOGeneric<TPRODUTO>.New;

  FDAO
    .DAO
    .SQL
      .Fields('produtos.ID, produtos.DESCRICAO, produtos.CATEGORIA, produtos.PRECO, categorias.DESCRICAO AS CATEGORIA_DESCRICAO')
      .Join('INNER JOIN categorias ON produtos.CATEGORIA = categorias.ID')
    .&End
  .Find;

  Res.Send<TJsonArray>(FDAO.DataSetAsJsonArray);
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TPRODUTO>;
begin
  FDAO := TDAOGeneric<TPRODUTO>.New;
  Res.Send<TJSONObject>(FDAO.Update(Req.Body<TJSONObject>));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TPRODUTO>;
begin
  FDAO := TDAOGeneric<TPRODUTO>.New;
  Res.Send<TJSONObject>(FDAO.Delete('ID', Req.Params.Items['id']));
end;

end.
