unit RenomeiaBoleto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ED_Caminho: TEdit;
    ED_Inicio: TEdit;
    ED_Final: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetFileList(const Path: string): TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetFileList(const Path: string): TStringList;
 var
   U: String;
   I, Inicio, Fim: Integer;
   SearchRec: TSearchRec;
   Nome, NewNome : String;
 begin
   Result := TStringList.Create;
   try
     Inicio := StrToInt(ED_Inicio.Text);
     Fim    := StrToInt(ED_Final.Text);
     I := FindFirst(Path, 0, SearchRec);
     while I = 0 do
     begin
       Result.Add(SearchRec.Name);
       Nome := SearchRec.Name;
       NewNome := Nome;
       delete(NewNome,Inicio,Fim);
       RenameFile(Nome,NewNome+'.html');
       I := FindNext(SearchRec);
     end;
   except
     Result.Free;
     raise;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 GetFileList(ED_Caminho.Text+'\*.html');
 ShowMessage('Os Arquivos da pasta: '+ED_Caminho.Text+#13' Foram Renomeados');
end;

end.
