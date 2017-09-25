unit fSeleccionarZonaHoraria;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TfrmZonaHoraria = class(TForm)
    tbMain: TToolBar;
    recFondoToolBar: TRectangle;
    lblTitulo: TLabel;
    sbtRegresar: TSpeedButton;
    sbtGuardar: TSpeedButton;
    lstZona: TListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstZonaDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function getZona: string;
  public
    property Zona:string read getZona;
  end;

var
  frmZonaHoraria: TfrmZonaHoraria;

implementation

{$R *.fmx}

procedure TfrmZonaHoraria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := TCloseAction.caFree;
end;

procedure TfrmZonaHoraria.FormShow(Sender: TObject);
begin
lstZona.ScrollToItem(lstZona.Selected);
end;

function TfrmZonaHoraria.getZona: string;
begin
if Assigned(lstZona.Selected) then
  Result := lstZona.Selected.Text
else
  Result := 'America/Mexico_City';
end;

procedure TfrmZonaHoraria.lstZonaDblClick(Sender: TObject);
begin
ModalResult := mrOk;
end;

end.
