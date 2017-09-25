unit tReloj;

interface

uses
  FMX.Types,
  System.Classes;

type
  TThreadReloj = class(TThread)
  private
    FtmrReloj:TTimer;
    FOnTimer: TNotifyEvent;

    procedure Timer(Sender:TObject);
  protected
    procedure Execute; override;
  public
    property OnTimer:TNotifyEvent read FOnTimer write FOnTimer;
  end;

implementation

Uses
  FMX.Forms;
{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure Reloj.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ Reloj }

procedure TThreadReloj.Execute;
begin
FtmrReloj := TTimer.Create(nil);

FtmrReloj.Interval := 900;
FtmrReloj.OnTimer := Timer;
FtmrReloj.Enabled := True;

while true do begin
  if Application.Terminated or Self.Terminated then
    Break;
  Application.ProcessMessages;
end; {while}
end;

procedure TThreadReloj.Timer(Sender: TObject);
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