unit fITCmxRegistro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ListBox, FMX.Layouts, FMX.Edit,
  FMX.ScrollBox, FMX.Memo;

type
  TfrmITCmxRegistro = class(TForm)
    tbMain: TToolBar;
    recFondoToolBar: TRectangle;
    lblTitulo: TLabel;
    sbtRegresar: TSpeedButton;
    sbtEnviar: TSpeedButton;
    lstRegistro: TListBox;
    lbiNombre: TListBoxItem;
    lbiEMail: TListBoxItem;
    lbiPais: TListBoxItem;
    lbiRecibirMails: TListBoxItem;
    lbiComentarios: TListBoxItem;
    edNombre: TEdit;
    edCorreo: TEdit;
    cmbPais: TComboBox;
    chkMails: TCheckBox;
    memComentario: TMemo;
    procedure sbtEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function Validar:Boolean;
    function Registrar:Boolean;
  public
  end;

var
  frmITCmxRegistro: TfrmITCmxRegistro;

implementation

{$R *.fmx}

uses fMain, cITCmxStatistics, uStatistics;

procedure TfrmITCmxRegistro.FormCreate(Sender: TObject);
begin
cmbPais.ItemIndex := cmbPais.Items.IndexOf('M�xico');
end;

function TfrmITCmxRegistro.Registrar: Boolean;
begin
try
  cltITCStatistics.ITCmxStatisticsClient.Registrarse(edNombre.Text, edCorreo.Text,
    cmbPais.Selected.Text, uStatistics.AppContador, memComentario.Text, chkMails.IsChecked);
  Close;
except
  on e: exception do
    frmMain.Msg('Ocurrio un problema al registrarse: ' + e.Message);
end; {try}
end;

procedure TfrmITCmxRegistro.sbtEnviarClick(Sender: TObject);
begin
if Validar then
  if Registrar then
    Close;
end;

function TfrmITCmxRegistro.Validar: Boolean;
begin
Result := False;
if (edNombre.Text = '') then begin
  edNombre.SetFocus;
  frmMain.Msg('Escriba su nombre por favor');
end else if (edNombre.Text = '') then begin
  edCorreo.SetFocus;
  frmMain.Msg('Escriba su correo por favor');
end else
  Result := True;
end;

end.
