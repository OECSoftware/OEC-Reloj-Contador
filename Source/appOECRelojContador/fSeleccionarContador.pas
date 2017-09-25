unit fSeleccionarContador;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, DPF.iOS.BarCodeReader,
  DPF.iOS.Keyboard, DPF.iOS.SlideDialog, DPF.iOS.UISearchBar,
  DPF.iOS.BaseControl, DPF.iOS.UIStepper, FMX.EditBox, FMX.ComboTrackBar,
  FMX.TMSScrollMenu, FMX.TMSBaseControl, FMX.TMSBadge, FMX.TMSTableView,
  FMX.TMSTableViewEx, FMX.TMSCustomButton, FMX.TMSSpeedButton, FMX.TMSSpinner;

type
  TfrmSeleccionarContador = class(TForm)
    tbMain: TToolBar;
    recFondoToolBar: TRectangle;
    lblTitulo: TLabel;
    sbtRegresar: TSpeedButton;
    sbtGuardar: TSpeedButton;
    edDescripcion: TEdit;
    Tiempo: TLabel;
    spi: TTMSFMXSpinner;
    procedure spiSelectedValueChanged(Sender: TObject; Column: Integer;
      SelectedValue: Double; RangeType: TTMSFMXSpinnerRangeType);
    procedure sbtGuardarClick(Sender: TObject);
  private
    FSegundos: integer;
    FMinutos: integer;
    FHoras: integer;
    FTotalSegundos: integer;

    procedure CalcularSegundos;
    function getDescripcion: string;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    property TotalSegundos:integer read FTotalSegundos;

    property Horas:integer read FHoras;
    property Minutos:integer read FMinutos;
    property Segundos:integer read FSegundos;

    property Descripcion:string read getDescripcion;
  end;

var
  frmSeleccionarContador: TfrmSeleccionarContador;

implementation

{$R *.fmx}

{ TfrmSeleccionarContador }

procedure TfrmSeleccionarContador.CalcularSegundos;
var
  iHoras, iMinutos, iTotal:Integer;
begin
FHoras := Round(spi.Columns[0].SelectedValue);
FMinutos := Round(spi.Columns[1].SelectedValue);
FSegundos := Round(spi.Columns[2].SelectedValue);

iHoras := FHoras * 60 * 60;
iMinutos := FMinutos * 60;

iTotal := iHoras + iMinutos + FSegundos;

FTotalSegundos := iTotal;

{$ifdef debug}
lblTitulo.Text := IntToStr(FTotalSegundos);
{$endif}
end;

constructor TfrmSeleccionarContador.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
end;

destructor TfrmSeleccionarContador.Destroy;
begin

inherited Destroy;
end;

function TfrmSeleccionarContador.getDescripcion: string;
begin
if edDescripcion.Text.Length = 0 then
  Result := 'Contador'
else
  Result := edDescripcion.Text;
end;

procedure TfrmSeleccionarContador.sbtGuardarClick(Sender: TObject);
begin
CalcularSegundos;
if TotalSegundos > 0 then
  ModalResult := mrOk;
end;

procedure TfrmSeleccionarContador.spiSelectedValueChanged(Sender: TObject;
  Column: Integer; SelectedValue: Double; RangeType: TTMSFMXSpinnerRangeType);
begin
CalcularSegundos;
end;

end.
