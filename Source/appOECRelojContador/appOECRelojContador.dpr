program appOECRelojContador;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  fReloj in 'fReloj.pas' {fraReloj: TFrame},
  uGral in 'uGral.pas',
  tReloj in 'tReloj.pas',
  fSeleccionarZonaHoraria in 'fSeleccionarZonaHoraria.pas' {frmZonaHoraria},
  fContador in 'fContador.pas' {fraContador: TFrame},
  TContador in 'TContador.pas',
  fSeleccionarContador in 'fSeleccionarContador.pas' {frmSeleccionarContador},
  fCronometro in 'fCronometro.pas' {fraCronometro: TFrame},
  tCronometro in 'tCronometro.pas',
  fMensaje in 'fMensaje.pas' {frmMensaje},
  fITCmxRegistro in 'fITCmxRegistro.pas' {frmITCmxRegistro},
  uITCmxStatistics in 'uITCmxStatistics.pas',
  cITCmxStatistics in 'cITCmxStatistics.pas' {cltITCStatistics: TDataModule},
  uStatistics in '..\..\..\ITCmxStadistics\uStatistics.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TcltITCStatistics, cltITCStatistics);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
