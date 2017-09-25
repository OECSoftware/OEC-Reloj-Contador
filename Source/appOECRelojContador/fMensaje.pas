unit fMensaje;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.ScrollBox, FMX.Memo,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage;

type
  TfrmMensaje = class(TForm)
    tbMain: TToolBar;
    recFondoToolBar: TRectangle;
    lblTitulo: TLabel;
    sbtRegresar: TSpeedButton;
    sbtEnviar: TSpeedButton;
    edAsunto: TEdit;
    memMensaje: TMemo;
    smtp: TIdSMTP;
    msg: TIdMessage;
    procedure sbtRegresarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbtEnviarClick(Sender: TObject);
  private
  public
  end;

var
  frmMensaje: TfrmMensaje;

implementation

{$R *.fmx}

uses fMain;

procedure TfrmMensaje.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := TCloseAction.caFree;
end;

procedure TfrmMensaje.sbtEnviarClick(Sender: TObject);
begin
msg.Subject := edAsunto.Text;
msg.Body.Text := memMensaje.Lines.Text;
try
  smtp.Connect;
  try
    smtp.Send(msg);
    frmMain.Msg('Se envio el correo a hola@oecsoftware.com.mx', False);
    Close;
  finally
    smtp.Disconnect;
  end; {try}
except
  on e: exception do
    frmMain.Msg('Ocurrio un problema al enviar el correo: ' + e.message, False);
end;
end;

procedure TfrmMensaje.sbtRegresarClick(Sender: TObject);
begin
Close;
end;

end.
