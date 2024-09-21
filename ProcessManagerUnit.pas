unit ProcessManagerUnit;

interface

uses
  Winapi.Windows, Winapi.TlHelp32, System.Classes, System.SysUtils;

type
  TProcessManager = class
  public
    function ListProcesses(const Filter: string = ''): TStringList;
    function OpenProcessByPID(PID: DWORD): THandle;
  end;

implementation

{ TProcessManager }

function TProcessManager.ListProcesses(const Filter: string): TStringList;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
  ProcessList: TStringList;
begin
  ProcessList := TStringList.Create;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then
    Exit(ProcessList);

  ProcessEntry.dwSize := SizeOf(ProcessEntry);
  if not Process32First(Snapshot, ProcessEntry) then
  begin
    CloseHandle(Snapshot);
    Exit(ProcessList);
  end;

  repeat
    if (Filter = '') or (Pos(UpperCase(Filter), UpperCase(ProcessEntry.szExeFile)) > 0) then
      ProcessList.Add(Format('%d: %s', [ProcessEntry.th32ProcessID, ProcessEntry.szExeFile]));
  until not Process32Next(Snapshot, ProcessEntry);

  CloseHandle(Snapshot);
  Result := ProcessList;
end;

function TProcessManager.OpenProcessByPID(PID: DWORD): THandle;
begin
  Result := OpenProcess(PROCESS_VM_WRITE or PROCESS_VM_READ or PROCESS_VM_OPERATION, False, PID);
end;

end.

