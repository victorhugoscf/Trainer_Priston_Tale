unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.TlHelp32, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
    { Private declarations }
    FProcessHandle: THandle;
    procedure ListProcesses(const Filter: string = '');
    function OpenProcessByPID(PID: DWORD): THandle;
    procedure WriteMemory(Address: Pointer; Value: DWORD);
  public
    { Public declarations }
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
var
  RandomCaption: string;
  i: Integer;
  RandomChar: Char;
begin
  Randomize;


  // Gera uma string aleatória misturando letras e números
  RandomCaption := '';
  for i := 1 to 10 do
  begin
    if Random(2) = 0 then
      RandomChar := Chr(Ord('A') + Random(26))
    else
      RandomChar := Chr(Ord('0') + Random(10));

    RandomCaption := RandomCaption + RandomChar;
  end;

  // Define a caption do formulário
  Self.Caption := RandomCaption;
end;



procedure TForm1.ListProcesses(const Filter: string = '');
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
  ProcessName: string;
begin
  ProcessListBox.Clear;

  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Failed to create process snapshot. Error Code: ' + IntToStr(GetLastError));
    Exit;
  end;

  ProcessEntry.dwSize := SizeOf(ProcessEntry);
  if not Process32First(Snapshot, ProcessEntry) then
  begin
    ShowMessage('Failed to retrieve process list. Error Code: ' + IntToStr(GetLastError));
    CloseHandle(Snapshot);
    Exit;
  end;

  repeat
    ProcessName := ProcessEntry.szExeFile;
    // Filtra pelo nome do processo se o filtro não estiver vazio
    if (Filter = '') or (Pos(UpperCase(Filter), UpperCase(ProcessName)) > 0) then
    begin
      ProcessListBox.Items.Add(Format('%d: %s', [ProcessEntry.th32ProcessID, ProcessName]));
    end;
  until not Process32Next(Snapshot, ProcessEntry);

  CloseHandle(Snapshot);
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
  ListProcesses(search.Text); // Atualiza a lista de processos com base no texto de busca
end;

procedure TForm1.BtnAttachClick(Sender: TObject);
var
  PID: DWORD;
begin
  if TryStrToInt(EditPID.Text, Integer(PID)) then
  begin
    FProcessHandle := OpenProcessByPID(PID);
    if FProcessHandle = 0 then
      ShowMessage('Erro ao tentar anexar ao processo. Error Code: ' + IntToStr(GetLastError))
    else
      ShowMessage('Anexado ao processo.');
  end
  else
    ShowMessage('PID inválido.');
end;



procedure TForm1.EditValue4Change(Sender: TObject);
begin
  // Adicione aqui o código desejado para o evento EditValue4Change, se necessário
end;

function TForm1.OpenProcessByPID(PID: DWORD): THandle;
begin
  Result := OpenProcess(PROCESS_VM_WRITE or PROCESS_VM_READ or PROCESS_VM_OPERATION, False, PID);
end;

procedure TForm1.BtnApplyClick(Sender: TObject);
var
  Address1, Address2, Address3, Address4: Pointer;
  Value1, Value2, Value3, Value4: DWORD;
  Written: SIZE_T;
  Success: Boolean;
begin
  if FProcessHandle = 0 then
  begin
    ShowMessage('Nenhum processo anexado.');
    Exit;
  end;

  // Endereços para alteração (substitua pelos endereços reais)
  Address1 := Pointer($00ccccec);
  Address2 := Pointer($00cccf6c);
  Address3 := Pointer($00ccd084);
  Address4 := Pointer($00CCD19C);

  // Valores para escrever
  Value1 := StrToIntDef(EditValue1.Text, 0);
  Value2 := StrToIntDef(EditValue2.Text, 0);
  Value3 := StrToIntDef(EditValue3.Text, 0);
  Value4 := StrToIntDef(EditValue4.Text, 0);

  // Inicializa a variável de sucesso como verdadeira
  Success := True;

  // Tenta escrever na memória e verifica se a operação foi bem-sucedida
  if not WriteProcessMemory(FProcessHandle, Address1, @Value1, SizeOf(Value1), Written) then
  begin
    Success := False;
    ShowMessage('Failed to write memory to Address1. Error Code: ' + IntToStr(GetLastError));
  end;

  if not WriteProcessMemory(FProcessHandle, Address2, @Value2, SizeOf(Value2), Written) then
  begin
    Success := False;
    ShowMessage('Failed to write memory to Address2. Error Code: ' + IntToStr(GetLastError));
  end;

  if not WriteProcessMemory(FProcessHandle, Address3, @Value3, SizeOf(Value3), Written) then
  begin
    Success := False;
    ShowMessage('Failed to write memory to Address3. Error Code: ' + IntToStr(GetLastError));
  end;

  if not WriteProcessMemory(FProcessHandle, Address4, @Value4, SizeOf(Value4), Written) then
  begin
    Success := False;
    ShowMessage('Failed to write memory to Address4. Error Code: ' + IntToStr(GetLastError));
  end;

  // Mostra mensagem de sucesso apenas se todas as operações foram bem-sucedidas
  if Success then
    ShowMessage('Ativado com sucesso.');
end;

procedure TForm1.WriteMemory(Address: Pointer; Value: DWORD);
var
  Written: SIZE_T;
begin
  if not WriteProcessMemory(FProcessHandle, Address, @Value, SizeOf(Value), Written) then
    ShowMessage('Erro ao ativar. Error Code: ' + IntToStr(GetLastError));
end;

end.

