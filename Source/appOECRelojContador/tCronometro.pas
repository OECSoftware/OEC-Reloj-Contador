unit tCronometro;

interface

uses
  FMX.Types,
  System.Classes;

type
  TThreadCronometro = class(TThread)
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

{ TCronometro }

procedure TThreadCronometro.Continuar;
begin
FtmrReloj.Enabled := True;
end;

procedure TThreadCronometro.Execute;
begin
FtmrReloj := TTimer.Create(nil);

FtmrReloj.Interval := 1000;
FtmrReloj.OnTimer := Timer;
FtmrReloj.Enabled := False;

while true do begin
  if Application.Terminated or Self.Terminated then
    Break;
  Application.ProcessMessages;
end; {while}
end;

procedure TThreadCronometro.Pausa;
begin
FtmrReloj.Enabled := False;
end;

procedure TThreadCronometro.Timer(Sender: TObject);
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
