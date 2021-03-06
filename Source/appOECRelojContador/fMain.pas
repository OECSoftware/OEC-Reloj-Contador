unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.MultiView,
  FMX.Objects, fReloj;

type
  TfrmMain = class(TForm)
    tbMain: TToolBar;
    lblTitulo: TLabel;
    sbtMenu: TSpeedButton;
    lstItems: TListBox;
    mvwMain: TMultiView;
    recFondoMenu: TRectangle;
    recFondoToolBar: TRectangle;
    recAgregar: TRectangle;
    sbtReloj: TSpeedButton;
    recContador: TRectangle;
    sbtContador: TSpeedButton;
    recAgregarCronometro: TRectangle;
    sbtCronometro: TSpeedButton;
    recMensaje: TRectangle;
    sbtEnviarMensaje: TSpeedButton;
    fraReloj: TfraReloj;
    sbtEstadisticas: TSpeedButton;
    recRegistro: TRectangle;
    sbtRegistro: TSpeedButton;
    lblAcercade: TLabel;
    procedure sbtRelojClick(Sender: TObject);
    procedure sbtContadorClick(Sender: TObject);
    procedure sbtCronometroClick(Sender: TObject);
    procedure sbtEnviarMensajeClick(Sender: TObject);
    procedure sbtRegistroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblAcercadeClick(Sender: TObject);
  private
    procedure AgregarReloj;
    procedure AgregarContador;
    procedure AgregarCronometro;
  public
    constructor Create(AOwner:TComponent); override;

    procedure Msg(AMsg:string; ASync:Boolean = True);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
{$IFDEF MSWINDOWS}
  WinAPI.WIndows, WINAPI.SHellAPI,
{$ENDIF MSWINDOWS}
{$IFDEF ANDROID}
  Androidapi.Helpers, Androidapi.JNI.App,
  FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
  FMX.Dialogs,
{$ELSE}
{$IFDEF IOS}
  Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS, FMX.Dialogs,
{$ENDIF IOS}
{$ENDIF ANDROID}
  FMX.DialogService.Async, FMX.DialogService.Sync,
  fSeleccionarZonaHoraria, fSeleccionarContador, fContador, fCronometro,
  fMensaje, fITCmxRegistro, cITCmxStatistics;

{ TfrmMain }

procedure TfrmMain.AgregarContador;
var
  iItem:Integer;
  Item:TListBoxItem;
  fContador:TfraContador;
begin
iItem := lstItems.Items.Add('');
Item := lstItems.ListItems[iItem];

fContador := TfraContador.Create(Item);
with fContador do begin
  Parent := Item;
  Align := TAlignLayout.Client;

  Descripcion := frmSeleccionarContador.Descripcion;

  Horas := frmSeleccionarContador.Horas;
  Minutos := frmSeleccionarContador.Minutos;
  Segundos := frmSeleccionarContador.Segundos;

  TotalSegundos := frmSeleccionarContador.TotalSegundos;

  Iniciar;
end; {with}
end;

procedure TfrmMain.AgregarCronometro;
var
  iItem:Integer;
  Item:TListBoxItem;
  fCronometro:TfraCronometro;
begin
iItem := lstItems.Items.Add('');
Item := lstItems.ListItems[iItem];

fCronometro := TfraCronometro.Create(Item);
with fCronometro do begin
  Parent := Item;
  Align := TAlignLayout.Client;
end; {with}
end;

procedure TfrmMain.AgregarReloj;
var
  iItem:Integer;
  Item:TListBoxItem;
  fReloj:TfraReloj;
begin
iItem := lstItems.Items.Add('');
Item := lstItems.ListItems[iItem];

fReloj := TfraReloj.Create(Item);
with fReloj do begin
  Parent := Item;
  Align := TAlignLayout.Client;
  ZonaHoraria := frmZonaHoraria.Zona;
end; {with}
end;

constructor TfrmMain.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
fraReloj.QuitarVisible := False;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
TThread.CreateAnonymousThread(procedure ()
  begin
    cltITCStatistics.AddAppContador;
  end).Start;

end;

procedure TfrmMain.lblAcercadeClick(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
shellexecute(0, 'open', 'https://www.oecsoftware.com.mx/', nil, nil, SW_NORMAL);
{$else}
OpenURL('https://www.oecsoftware.com.mx/');
{$endif}
end;

procedure TfrmMain.Msg(AMsg: string; ASync: Boolean);
begin
if (ASync) then
  FMX.DialogService.Async.TDialogServiceAsync.ShowMessage(AMsg)
else
  FMX.DialogService.Sync.TDialogServiceSync.ShowMessage(AMsg);
end;

procedure TfrmMain.sbtContadorClick(Sender: TObject);
begin
frmSeleccionarContador := TfrmSeleccionarContador.Create(Self);
{$ifdef MSWINDOWS}
if ispositiveresult(frmSeleccionarContador.ShowModal) then begin
  AgregarContador;
end; {if}
{$else}
frmSeleccionarContador.ShowModal(procedure (AModalResult:TModalResult)
  begin
    if IsPositiveResult(AModalResult) then
      AgregarContador;
  end
);
{$endif}
mvwMain.HideMaster;
end;

procedure TfrmMain.sbtCronometroClick(Sender: TObject);
begin
AgregarCronometro;
mvwMain.HideMaster;
end;

procedure TfrmMain.sbtEnviarMensajeClick(Sender: TObject);
begin
frmMensaje := TfrmMensaje.Create(Self);
{$ifdef MSWINDOWS}
frmMensaje.ShowModal;
{$else}
frmMensaje.ShowModal(procedure (AModalResult:TModalResult)
  begin
  end
);
{$endif}
mvwMain.HideMaster;
end;

procedure TfrmMain.sbtRegistroClick(Sender: TObject);
begin
frmITCmxRegistro := TfrmITCmxRegistro.Create(Self);
{$ifdef MSWINDOWS}
frmITCmxRegistro.ShowModal;
{$else}
frmITCmxRegistro.ShowModal(procedure (AModalResult:TModalResult)
  begin
  end
);
{$endif}
mvwMain.HideMaster;
end;

procedure TfrmMain.sbtRelojClick(Sender: TObject);
begin
frmZonaHoraria := TfrmZonaHoraria.Create(Self);
{$ifdef MSWINDOWS}
if ispositiveresult(frmZonaHoraria.ShowModal) then begin
  AgregarReloj;
end; {if}
{$else}
frmZonaHoraria.ShowModal(procedure (AModalResult:TModalResult)
  begin
    if IsPositiveResult(AModalResult) then
      AgregarReloj;
  end
);
{$endif}
mvwMain.HideMaster;
end;

end.
