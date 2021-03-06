unit uCategorias;

interface

uses
  Horse,
  System.JSON,
  uDAOGenerico,
  uCATEGORIA;

procedure Registry(App: THorse);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry(App: THorse);
begin
  App.Get('/categorias', Get);
  App.Get('/categorias/:id', GetID);
  App.Post('/categorias', Insert);
  App.Put('/categorias/:id', Update);
  App.Delete('/categorias/:id', Delete);
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TCATEGORIA>;
begin
  FDAO := TDAOGeneric<TCATEGORIA>.New;
  Res.Send<TJSONObject>(FDAO.Insert(Req.Body<TJSONObject>));
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TCATEGORIA>;
begin
  FDAO := TDAOGeneric<TCATEGORIA>.New;
  Res.Send<TJSONObject>(FDAO.Find(Req.Params.Items['id']));
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TCATEGORIA>;
begin
  FDAO := TDAOGeneric<TCATEGORIA>.New;
  Res.Send<TJsonArray>(FDAO.Find);
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TCATEGORIA>;
begin
  FDAO := TDAOGeneric<TCATEGORIA>.New;
  Res.Send<TJSONObject>(FDAO.Update(Req.Body<TJSONObject>));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO: iDAOGeneric<TCATEGORIA>;
begin
  FDAO := TDAOGeneric<TCATEGORIA>.New;
  Res.Send<TJSONObject>(FDAO.Delete('ID', Req.Params.Items['id']));
end;

end.
