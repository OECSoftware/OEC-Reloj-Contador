unit cITCmxStatistics;

interface

uses
  System.SysUtils, System.Classes, uITCmxStatistics, Datasnap.DSClientRest;

type
  TcltITCStatistics = class(TDataModule)
    rest: TDSRestConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FInstanceOwner: Boolean;
    FITCmxStatisticsClient: TITCmxStatisticsClient;
    function GetITCmxStatisticsClient: TITCmxStatisticsClient;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ITCmxStatisticsClient: TITCmxStatisticsClient read GetITCmxStatisticsClient write FITCmxStatisticsClient;

    procedure AddAppContador;
  end;

var
  cltITCStatistics: TcltITCStatistics;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uStatistics;

{$R *.dfm}

procedure TcltITCStatistics.AddAppContador;
begin
ITCmxStatisticsClient.AddContador(AppContador);
end;

constructor TcltITCStatistics.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

procedure TcltITCStatistics.DataModuleCreate(Sender: TObject);
begin
rest.Port := uStatistics.Puerto;
{$ifdef RELEASE}
rest.Host := uStatistics.Host;
{$endif}
end;

destructor TcltITCStatistics.Destroy;
begin
  FITCmxStatisticsClient.Free;
  inherited;
end;

function TcltITCStatistics.GetITCmxStatisticsClient: TITCmxStatisticsClient;
begin
  if FITCmxStatisticsClient = nil then
    FITCmxStatisticsClient:= TITCmxStatisticsClient.Create(rest, FInstanceOwner);
  Result := FITCmxStatisticsClient;
end;

end.
