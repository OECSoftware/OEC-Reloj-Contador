// 
// Created by the DataSnap proxy generator.
// 24/09/2017 09:28:55 p.m.
// 

unit uITCmxStatistics;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TITCmxStatisticsClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FAddContadorCommand: TDSRestCommand;
    FRegistrarseCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    procedure AddContador(AApp: string);
    procedure Registrarse(ANombre: string; ACorreo: string; APais: string; AOrigen: string; ANotas: string; ANotificaciones: Boolean);
  end;

const
  TITCmxStatistics_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TITCmxStatistics_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TITCmxStatistics_AddContador: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'AApp'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

  TITCmxStatistics_Registrarse: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'ANombre'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ACorreo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'APais'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'AOrigen'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ANotas'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ANotificaciones'; Direction: 1; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TITCmxStatisticsClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TITCmxStatistics.EchoString';
    FEchoStringCommand.Prepare(TITCmxStatistics_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TITCmxStatisticsClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TITCmxStatistics.ReverseString';
    FReverseStringCommand.Prepare(TITCmxStatistics_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

procedure TITCmxStatisticsClient.AddContador(AApp: string);
begin
  if FAddContadorCommand = nil then
  begin
    FAddContadorCommand := FConnection.CreateCommand;
    FAddContadorCommand.RequestType := 'GET';
    FAddContadorCommand.Text := 'TITCmxStatistics.AddContador';
    FAddContadorCommand.Prepare(TITCmxStatistics_AddContador);
  end;
  FAddContadorCommand.Parameters[0].Value.SetWideString(AApp);
  FAddContadorCommand.Execute;
end;

procedure TITCmxStatisticsClient.Registrarse(ANombre: string; ACorreo: string; APais: string; AOrigen: string; ANotas: string; ANotificaciones: Boolean);
begin
  if FRegistrarseCommand = nil then
  begin
    FRegistrarseCommand := FConnection.CreateCommand;
    FRegistrarseCommand.RequestType := 'GET';
    FRegistrarseCommand.Text := 'TITCmxStatistics.Registrarse';
    FRegistrarseCommand.Prepare(TITCmxStatistics_Registrarse);
  end;
  FRegistrarseCommand.Parameters[0].Value.SetWideString(ANombre);
  FRegistrarseCommand.Parameters[1].Value.SetWideString(ACorreo);
  FRegistrarseCommand.Parameters[2].Value.SetWideString(APais);
  FRegistrarseCommand.Parameters[3].Value.SetWideString(AOrigen);
  FRegistrarseCommand.Parameters[4].Value.SetWideString(ANotas);
  FRegistrarseCommand.Parameters[5].Value.SetBoolean(ANotificaciones);
  FRegistrarseCommand.Execute;
end;

constructor TITCmxStatisticsClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TITCmxStatisticsClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TITCmxStatisticsClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FAddContadorCommand.DisposeOf;
  FRegistrarseCommand.DisposeOf;
  inherited;
end;

end.
