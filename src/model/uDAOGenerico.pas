unit uDAOGenerico;

interface

uses
  System.JSON, REST.Json, SimpleInterface, SimpleDAO, SimpleAttributes,
  System.RTTI, System.Generics.Collections, System.Classes, SimpleQueryFireDac,
  Data.DB, System.SysUtils, System.TypInfo, SimpleRTTI, SimpleSQL, DataSetConverter4D,
  DataSetConverter4D.Impl, DataSetConverter4D.Helper, DataSetConverter4D.Util;


type
  iDAOGeneric<T : class> = interface
    ['{717F0AA7-60E6-4939-9575-524DA74EC8B3}']
    function Find : TJsonArray; overload;
    function Find (const aID:String): TJsonObject; overload;
    function Insert (const aJsonObject :TJsonObject):TJsonObject;
    function Update (const aJsonObject :TJsonObject):TJsonObject;
    function Delete (aField :String; aValue :String):TJsonObject;
  end;


  TDAOGeneric<T : class, constructor> = class(TInterfacedObject, iDAOGeneric<T>)
  private
    FConn : iSimpleQuery;
    FDAO : iSimpleDAO<T>;
    FDataSource : TDataSource;
  public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOGeneric<T>;
      function Find : TJsonArray; overload;
      function Find (const aID:String): TJSONObject; overload;
      function Insert (const aJSONObject :TJSONObject):TJSONObject;
      function Update (const aJSONObject :TJSONObject):TJSONObject;
      function Delete (aField :String; aValue :String):TJSONObject;
  end;

implementation

{ TDAOGeneric<T> }

uses uServerReactModelConnection;

constructor TDAOGeneric<T>.Create;
begin
  FDataSource := TDataSource.Create(nil);
  uServerReactModelConnection.Connected;
  FConn:= TSimpleQueryFiredac.New(uServerReactModelConnection.FConn);
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);
end;

function TDAOGeneric<T>.Delete(aField, aValue: String): TJSONObject;
begin
  FDAO.Delete(aField, aValue);
  Result := FDataSource.DataSet.AsJSONObject;
end;

destructor TDAOGeneric<T>.Destroy;
begin
  FDataSource.Free;
  uServerReactModelConnection.Disconnected;
  inherited;
end;

function TDAOGeneric<T>.Find(const aID: String): TJSONObject;
begin
  FDAO.Find(StrToInt(aID));
  Result := FDataSource.DataSet.AsJSONObject;
end;

function TDAOGeneric<T>.Find: TJsonArray;
begin
  FDAO.Find;
  Result := FDataSource.DataSet.AsJSONArray;
end;

class function TDAOGeneric<T>.New: iDAOGeneric<T>;
begin
  Result:= Self.Create;
end;

function TDAOGeneric<T>.Insert(const aJsonObject: TJsonObject): TJsonObject;
begin
  FDAO.Insert(Tjson.JsonToObject<T>(aJsonObject));
  Result := FDataSource.DataSet.AsJSONObject;
end;

function TDAOGeneric<T>.Update(const aJSONObject: TJSONObject): TJSONObject;
begin
  FDAO.Update(Tjson.JsonToObject<T>(aJsonObject));
  Result := FDataSource.DataSet.AsJSONObject;
end;

end.
