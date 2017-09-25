unit TContador;

interface

uses
  FMX.Types,
  System.Classes;

type
  TThreadContador = class(TThread)
  private
    FtmrReloj:TTimer;
    FOnTimer: TNotifyEvent;

    procedure Timer(Sender:TObject);
  protected
    procedure Execute; override;
  public
    property OnTimer:TNotifyEvent read FOnTimer write FOnTimer;

    procedure Pausa;
    procedure Continuar;
  end;

implementation

Uses
  FMX.Forms;

{ TContador }

procedure TThreadContador.Continuar;
begin
FtmrReloj.Enabled := True;
end;

procedure TThreadContador.Execute;
begin
FtmrReloj := TTimer.Create(nil);

FtmrReloj.Interval := 1000;
FtmrReloj.OnTimer := Timer;
FtmrReloj.Enabled := True;

while true do begin
  if Application.Terminated or Self.Terminated then
    Break;
  Application.ProcessMessages;
end; {while}
end;

procedure TThreadContador.Pausa;
begin
FtmrReloj.Enabled := False;
end;

procedure TThreadContador.Timer(Sender: TObject);
begin
Synchronize(
  procedure
  begin
    if assigned(OnTimer) then
      OnTimer(Sender);
  end
);
end;

end.
