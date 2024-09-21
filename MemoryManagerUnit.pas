unit MemoryManagerUnit;

interface

uses
  Winapi.Windows, System.SysUtils;

type
  TMemoryManager = class
  private
    FProcessHandle: THandle;
  public
    constructor Create(ProcessHandle: THandle);
    procedure WriteMemory(Address: Pointer; Value: DWORD);
  end;

implementation

constructor TMemoryManager.Create(ProcessHandle: THandle);
begin
  FProcessHandle := ProcessHandle;
end;

procedure TMemoryManager.WriteMemory(Address: Pointer; Value: DWORD);
var
  Written: SIZE_T;
begin
  if not WriteProcessMemory(FProcessHandle, Address, @Value, SizeOf(Value), Written) then
    raise Exception.Create('Erro ao escrever na memória. Código de Erro: ' + IntToStr(GetLastError));
end;

end.

