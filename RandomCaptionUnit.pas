unit RandomCaptionUnit;

interface

type
  TRandomCaptionGenerator = class
  public
    class function GenerateRandomCaption: string;
  end;

implementation

uses
  System.SysUtils;

class function TRandomCaptionGenerator.GenerateRandomCaption: string;
var
  i: Integer;
  RandomChar: Char;
begin
  Randomize;
  Result := '';

  // Gera uma string aleatória misturando letras e números
  for i := 1 to 10 do
  begin
    if Random(2) = 0 then
      RandomChar := Chr(Ord('A') + Random(26)) // Letras
    else
      RandomChar := Chr(Ord('0') + Random(10)); // Números

    Result := Result + RandomChar;
  end;
end;

end.

