unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.TlHelp32, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  RandomCaptionUnit, ProcessManagerUnit, MemoryManagerUnit;

type
  TForm1 = class(TForm)
    EditPID: TEdit;
    BtnAttach: TButton;
    EditValue1: TEdit;
    BtnApply: TButton;
    ProcessListBox: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    EditValue2: TEdit;
    Label3: TLabel;
    EditValue3: TEdit;
    Label4: TLabel;
    EditValue4: TEdit;
    search: TEdit;
    Label5: TLabel;
    Timer1: TTimer;

    procedure FormShow(Sender: TObject);
    procedure ProcessListBoxDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnAttachClick(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure searchChange(Sender: TObject);
    procedure EditValue4Change(Sender: TObject);

  private
    FProcessHandle: THandle;
    procedure ListProcesses(const Filter: string = '');
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  ListProcesses;
  Timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Self.Caption := TRandomCaptionGenerator.GenerateRandomCaption;
end;

procedure TForm1.ListProcesses(const Filter: string = '');
var
  ProcessManager: TProcessManager;
  ProcessList: TStringList;
begin
  ProcessManager := TProcessManager.Create;
  try
    ProcessList := ProcessManager.ListProcesses(Filter);
    ProcessListBox.Items.Assign(ProcessList);
  finally
    ProcessManager.Free;
  end;
end;

procedure TForm1.ProcessListBoxDblClick(Sender: TObject);
var
  PIDStr: string;
begin
  if ProcessListBox.ItemIndex >= 0 then
  begin
    PIDStr := Copy(ProcessListBox.Items[ProcessListBox.ItemIndex], 1, Pos(':', ProcessListBox.Items[ProcessListBox.ItemIndex]) - 1);
    EditPID.Text := Trim(PIDStr);
  end;
end;

procedure TForm1.searchChange(Sender: TObject);
begin
  ListProcesses(search.Text);
end;

procedure TForm1.BtnAttachClick(Sender: TObject);
var
  PID: DWORD;
  ProcessManager: TProcessManager;
begin
  if TryStrToInt(EditPID.Text, Integer(PID)) then
  begin
    ProcessManager := TProcessManager.Create;
    try
      FProcessHandle := ProcessManager.OpenProcessByPID(PID);
      if FProcessHandle = 0 then
        ShowMessage('Erro ao tentar anexar ao processo. Error Code: ' + IntToStr(GetLastError))
      else
        ShowMessage('Anexado ao processo.');
    finally
      ProcessManager.Free;
    end;
  end
  else
    ShowMessage('PID inválido.');
end;

procedure TForm1.BtnApplyClick(Sender: TObject);
var
  MemoryManager: TMemoryManager;
begin
  if FProcessHandle = 0 then
  begin
    ShowMessage('Nenhum processo anexado.');
    Exit;
  end;

  MemoryManager := TMemoryManager.Create(FProcessHandle);
  try
    // Endereços e valores para aplicar
    MemoryManager.WriteMemory(Pointer($00CC5894), StrToIntDef(EditValue1.Text, 0));
    MemoryManager.WriteMemory(Pointer($00CC54AC), StrToIntDef(EditValue2.Text, 0));
    MemoryManager.WriteMemory(Pointer($00CC568C), StrToIntDef(EditValue3.Text, 0));
    MemoryManager.WriteMemory(Pointer($00CC5524), StrToIntDef(EditValue4.Text, 0));

    ShowMessage('Valores aplicados com sucesso.');
  finally
    MemoryManager.Free;
  end;
end;

procedure TForm1.EditValue4Change(Sender: TObject);
begin
  // Lógica adicional para EditValue4Change, se necessário
end;

end.

