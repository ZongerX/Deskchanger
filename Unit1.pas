unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdHTTP, System.Win.TaskbarCore, Vcl.Taskbar,
  IdIOHandler, IdIOHandlerSocket, ShellApi, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase, registry, IdFTP, IdTCPConnection, IdTCPClient,
  wininet, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    IdFTP1: TIdFTP;
    ListBox1: TListBox;
    Edit1: TEdit;
    Button3: TButton;
    TrayIcon1: TTrayIcon;
    ComboBox2: TComboBox;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label3: TLabel;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    Button4: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1BalloonClick(Sender: TObject);
    procedure TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Label2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Label3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label8MouseEnter(Sender: TObject);
    procedure Label8MouseLeave(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ComboBox1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  //Отдельный Thread
  TMyThread = class(TThread)
    private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  MyThread: TMyThread;
  ver: string = '1.0';

implementation

{$R *.dfm}


function GetCurrentDateTime: TDateTime;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTimeToDateTime(SystemTime);
end;

function GetWin(Comand: string): string;
var
  buff: array [0 .. $FF] of char;
begin
  ExpandEnvironmentStrings(PChar(Comand), buff, SizeOf(buff));
  Result := buff;
end;


procedure GetProxyData(var ProxyEnabled: boolean; var ProxyServer: string; var ProxyPort: integer);
var
  ProxyInfo: PInternetProxyInfo;
  Len: LongWord;
  i, j: integer;
begin
  Len := 4096;
  ProxyEnabled := false;
  GetMem(ProxyInfo, Len);
  try
    if InternetQueryOption(nil, INTERNET_OPTION_PROXY, ProxyInfo, Len)
    then
      if ProxyInfo^.dwAccessType = INTERNET_OPEN_TYPE_PROXY then
      begin
        ProxyEnabled:= True;
        ProxyServer := ProxyInfo^.lpszProxy;
      end
  finally
    FreeMem(ProxyInfo);
  end;

  if ProxyEnabled and (ProxyServer <> '') then
  begin
    i := Pos('http=', ProxyServer);
    if (i > 0) then
    begin
      Delete(ProxyServer, 1, i+5);
      j := Pos(';', ProxyServer);
      if (j > 0) then
        ProxyServer := Copy(ProxyServer, 1, j-1);
    end;
    i := Pos(':', ProxyServer);
    if (i > 0) then
    begin
      ProxyPort := StrToIntDef(Copy(ProxyServer, i+1, Length(ProxyServer)-i), 0);
      ProxyServer := Copy(ProxyServer, 1, i-1)
    end
  end;
end;

procedure CheckUpdate();
var
  last:string;
begin
  //Проверка обновления
  try
    last:=Form1.idhttp1.Get('https://raw.githubusercontent.com/ZongerX/Deskchanger/master/lastver.txt');
      if ver<>last then
        begin
//          Form1.Label2.Visible:=true;
//          CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Доступна новая версия '+last, bitInfo, 10);
        end;
  except
//    CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Ошибка проверки обновления программы', bitError, 10);
  end;
end;

procedure SetWallpaper(sWallpaperBMPPath: string; bTile: boolean);
var
  reg: TRegIniFile;
begin
  //     Изменяем ключи реестра
  //     HKEY_CURRENT_USER
  //     Control Panel\Desktop
  //     TileWallpaper (REG_SZ)
  //     Wallpaper (REG_SZ)

  reg := TRegIniFile.Create('Control Panel\Desktop');
  with reg do
  begin
    WriteString('', 'Wallpaper', sWallpaperBMPPath);
//    if Form1.checkbox5.Checked then WriteString('', 'WallpaperStyle', '6');
    if (bTile) then
    begin
      WriteString('', 'TileWallpaper', '1');
    end
    else
    begin
      WriteString('', 'TileWallpaper', '0');
    end;
  end;
  reg.Free;
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDWININICHANGE);
end;


//Второй Thread
procedure TMyThread.Execute;
var
  buf: TMemoryStream;
begin
  try
    if form1.IdFTP1.Connected then else Form1.idftp1.Connect;
    if pos('Original FTP', Form1.ComboBox1.Text)=1 then
      Form1.idftp1.Get(Form1.edit1.Text, GetWin('%AppData%')+'\img.jpg', true)
      else
        begin
          //Здесь описывается код, который будет выполняться в потоке
          buf:=TMemoryStream.Create;
          Form1.idHTTP1.Get(Form1.Combobox1.Text, buf); //Загрузка в буфер
          buf.SaveToFile(GetWin('%AppData%')+'\img.bmp'); //Сохранение
        end;
    Form1.IdFTP1.Disconnect;
  except
    //Вывод ошибки в thread пользователю
    on e:exception do
    showmessage('Ошибка загрузки: '+#13+e.Message);
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  buf: TMemoryStream;
begin

  if pos('Выберите источник', Combobox1.Text)=1 then
    begin
      showmessage('Нет ссылки');
      exit;
    end;

  if (ComboBox1.Text='Original FTP') or (ComboBox1.Text='Original FTP HD') then
    begin
      Button2.Click;
      exit;
    end
      else
         if pos('http://', Combobox1.Text) or pos('https://', Combobox1.Text)=0 then
            ComboBox1.Text:=('http://'+Combobox1.Text);

  Button1.Enabled:=false;
  Button1.Caption:='Загрузка изображения...';
  //Загрузка и сохранение изображения
  buf:=TMemoryStream.Create;
  idHTTP1.Get(Combobox1.Text, buf); //Загрузка в буфер
  buf.SaveToFile(GetWin('%AppData%')+'\img.bmp'); //Сохранение


  //Параметр False запускает поток сразу после создания, True - запуск впоследствии , методом Resume
//  MyThread:=TMyThread.Create(False);
  SetWallpaper((GetWin('%AppData%')+'\img.bmp'), False);

  //Отображение последнего обновления
  label3.Visible:=true;
  label3.Caption:=('Последнее обновление: ')+FormatDateTime('hh:mm',now);

  Button1.Caption:='Обновить';
  Button1.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Mon,MonStr,Year,Date:String;
  sort:TStringList;
begin
  try

  Date:=(DateToStr(GetCurrentDateTime)); //сегодняшнюю дату в тип str и в переменную
  Mon:=Date[4]+Date[5];//месяц 4 и 5 цифра
  Year:=Date[7]+Date[8]+Date[9]+Date[10]; //год 7,8,9,10 цифры

  //Определение настроек FTP
  Form1.idftp1.Host:='217.174.103.107';
  Form1.idftp1.Port:=21;
  Form1.idftp1.Username:='electro';
  Form1.idftp1.Password:='electro';

  //Начало поиска, оповещение пользователя
  Form1.Button1.Enabled:=false;
  Form1.Button1.Caption:='Поиск снимка...';
  Form1.Update;

  Try
    begin
      //Подключение к ftp
      listbox1.Items.Text:=listbox1.Items.Text+'Подключение к FTP...';
      Form1.Button1.Caption:='Подключение к FTP...';
      Form1.idftp1.Disconnect;  //Отключение (вдруг подключено)
      Form1.idftp1.Connect;  //Подключение
      AssErt(Form1.idftp1.Connected);     //Подключение
      listbox1.Items.Text:=listbox1.Items.Text+'Подключено';
      listbox1.Items.Text:=listbox1.Items.Text+'Вывод списка папок...';
      listbox1.Items.Clear;
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок

      //Переход в корень FTP
      listbox1.Items.Text:=listbox1.Items.Text+'Переход в корень FTP...';
      Button1.Caption:='Переход в корень FTP...';
      Edit1.Text:='/ELECTRO_L_2/';
      Form1.idftp1.ChangeDir(Form1.edit1.text);      //Смена директории FTP

      //Год
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок
      Edit1.Text:=edit1.Text+(ListBox1.Items[ListBox1.Items.Count-1]+'/');//Перейти по последнему пункту из списка
      Button1.Caption:='Меняю директорию... '+edit1.Text;
      Form1.idftp1.ChangeDir(Form1.edit1.text);     //Смена директории FTP
      Form1.idFTP1.List(ListBox1.Items,'',false);   //Вывод списка папок
//      showmessage('год выбрали '+edit3.text);

      //Месяц
      Form1.idFTP1.List(ListBox1.Items,'',false);
      Button1.Caption:='Меняю директорию... '+edit1.Text;
      Form1.idftp1.ChangeDir(Form1.edit1.text);   //Смена директории FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок
      Form1.Button1.Caption:='Год найден...';

      Button1.Caption:='Расшифровываю древние свитки...';
//      showmessage('Перевожу слова в цифры');

      //Перевод слов в цифры
      sort := TStringList.Create;
      if pos('January', Form1.Listbox1.Items.Text)>0 then sort.Add('01');
      if pos('February', Form1.Listbox1.Items.Text)>0 then sort.Add('02');
      if pos('Mart', Form1.Listbox1.Items.Text)>0 then sort.Add('03');
      if pos('April', Form1.Listbox1.Items.Text)>0 then sort.Add('04');
      if pos('May', Form1.Listbox1.Items.Text)>0 then sort.Add('05');
      if pos('June', Form1.Listbox1.Items.Text)>0 then sort.Add('06');
      if pos('July', Form1.Listbox1.Items.Text)>0 then sort.Add('07');
      if pos('August', Form1.Listbox1.Items.Text)>0 then sort.Add('08');
      if pos('September', Form1.Listbox1.Items.Text)>0 then sort.Add('09');
      if pos('October', Form1.Listbox1.Items.Text)>0 then sort.Add('10');
      if pos('November', Form1.Listbox1.Items.Text)>0 then sort.Add('11');
      if pos('December', Form1.Listbox1.Items.Text)>0 then sort.Add('12');

//      memo1.Lines:=sort;
//        sort.Add('hello');
//      memo2.Lines:=sort;
//      sort:=memo1.Lines;
//      Mon:=(sort[sort.Count-1]);

//      Mon:=(Memo1.Lines[Memo1.Lines.Count-1]); //Последнее значение memo1 в переменную
      //Перевод числовых значений месяца в строковые
      if Mon='01' then MonStr:='January';
      if Mon='02' then MonStr:='February';
      if Mon='03' then MonStr:='Mart';
      if Mon='04' then MonStr:='April';
      if Mon='05' then MonStr:='May';
      if Mon='06' then MonStr:='June';
      if Mon='07' then MonStr:='July';
      if Mon='08' then MonStr:='August';
      if Mon='09' then MonStr:='September';
      if Mon='10' then MonStr:='October';
      if Mon='11' then MonStr:='November';
      if Mon='12' then MonStr:='December';

      Edit1.Text:=(edit1.Text+MonStr+'/'); //Добавляем буквенный месяц из переменной
      Form1.Button1.Caption:='Меняю директорию... '+edit1.Text;
      Form1.idftp1.ChangeDir(Form1.edit1.text);   //Смена директории FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок
      Form1.Button1.Caption:='Месяц найден...';
//      showmessage('Месяц найден '+edit3.Text);

      //Число
      Form1.edit1.Text:=Form1.edit1.Text+(Form1.ListBox1.Items[Form1.ListBox1.Items.Count-1]+'/');//Перейти по последнему пункту из списка
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок
      Form1.Button1.Caption:='Меняю директорию... '+edit1.Text;
      Form1.idftp1.ChangeDir(Form1.edit1.text);      //Смена директории FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок
     Form1.Button1.Caption:='Число найдено...';
//     showmessage('Число найдено '+edit3.Text);

      //Снимок
      Form1.edit1.Text:=Form1.edit1.Text+(Form1.ListBox1.Items[Form1.ListBox1.Items.Count-1]+'/');//Перейти по последнему пункту из списка
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок
      Form1.Button1.Caption:='Меняю директорию... '+edit1.Text;
      Form1.idftp1.ChangeDir(Form1.edit1.text);   //Смена директории FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //Вывод списка папок


      Form1.Button1.Caption:='Снимок найден...';

      //Добавление ссылки на снимок в edit1
      if ComboBox1.Text='Original FTP HD' then
        Edit1.Text:=Edit1.Text+Listbox1.Items[Listbox1.Items.Count-1]
          else if ComboBox1.Text='Original FTP' then
            Edit1.Text:=Edit1.Text+Listbox1.Items[Listbox1.Items.Count-2];

    Form1.Button1.Caption:='Загрузка снимка...'+Listbox1.Items[Listbox1.Items.Count-1];

    //Загрузка снимка
    Form1.idftp1.Get(edit1.Text, GetWin('%AppData%')+'\img.jpg', true);
//    MyThread:=TMyThread.Create(False);

	  //Оповещение
	  Form1.Button1.Caption:='Установка изображения...';
    Form1.Update;

	  //Применение к рабочему столу
    SetWallpaper(Pchar(GetWin('%AppData%')+'\img.jpg'), False);

    //Оповещения об обновлении
{    if Form1.checkbox2.Checked then Form1.CoolTrayIcon1.ShowBalloonHint('DeskChanger '+ver,IniFile.ReadString('LANG','DESKTOPUPATED','Обои обновлены '+#13+edit1.Text), bitinfo, 10);

    label4.Visible:=true;
    Form1.label4.Caption:=(IniFile.ReadString('LANG','LASTUPDATED','Последнее обновление:')+' '+FormatDateTime('hh:mm',now));
    Form1.CoolTrayIcon1.Hint:=('DeskChanger '+ver+ #13 +IniFile.ReadString('LANG','LASTUPDATE','Последнее обновление:')+' '+FormatDateTime('hh:mm',now));
}

    //Отображение последнего обновления
    label3.Visible:=true;
    label3.Caption:=('Последнее обновление: ')+FormatDateTime('hh:mm',now);

	  Form1.idftp1.Disconnect;
    Form1.Button1.Caption:='Обновить';
    Form1.Button1.Enabled:=true;
    end;
  Except
    Form1.idftp1.Disconnect;
    Form1.Button1.Caption:='Обновить';
    Form1.Button1.Enabled:=true;
//    Form1.label4.Caption:='Проверьте интернет соединение';
//    Form1.CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Ошибка резервного сервера', biterror, 10);
    exit;
  End;
  except
    on E : Exception do Showmessage('Не удалось обновить снимок:'+#13+E.Message);
  end;

  //  memo1.Text:=idhttp1.Get(Combobox1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
var vers :integer;
begin
vers:=0;
if form1.Height > 150 then
  begin
    while form1.Height > 150 do
      begin
        vers:=vers+1;
//        Form1.Caption:=inttostr(vers);
//        Form1.Caption:=Form1.Caption+'.';
        form1.Height:=form1.Height-4;
        sleep(1);
      end;
  end;
 while form1.Height > Listbox1.Top+190 do
      begin
        vers:=vers+1;
        Form1.Caption:=inttostr(vers);
        Form1.Caption:=Form1.Caption+'.';
        form1.Height:=form1.Height+4;
        sleep(1);
      end;
//  trayicon1.ShowBalloonHint;
//  Trayicon1.BalloonHint:=('Desktop Changer '+ver, 'Программа обновлена!', bitInfo, 10);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  //Подгрузка списка ссылок на ресурсы
  combobox1.Items.Text:=(idhttp1.Get('https://raw.githubusercontent.com/ZongerX/Deskchanger/master/servers.txt'));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  reg: TRegistry;
begin
  if checkbox1.Checked=true then
    begin
      reg := TRegistry.Create;
      reg.RootKey := HKEY_CURRENT_USER;
      reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      reg.WriteString('DeskChanger', Application.ExeName+' /s');
      reg.CloseKey;
    end
  else
   begin
      reg := TRegistry.Create;
      reg.RootKey := HKEY_CURRENT_USER;
      reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      reg.DeleteValue('DeskChanger');
      reg.CloseKey;
   end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
var
  reg: TRegistry;
begin
  reg:=TRegistry.Create;
  if checkbox3.Checked=true then
    begin
      checkbox3.Checked:=true;
      reg.RootKey:=HKEY_CURRENT_USER;
      reg.OpenKey('DeskChanger', True);
      reg.WriteString('WallpaperStyle', '6');
    end
      else
        begin
          checkbox3.Checked:=false;
          reg.RootKey:=HKEY_CURRENT_USER;
          reg.OpenKey('DeskChanger', True);
          reg.DeleteValue('WallpaperStyle');
        end;
  reg.Free;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  reg:TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);
  reg.WriteString('Link', ComboBox1.Text);
  reg.Free;
end;

procedure TForm1.ComboBox1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

  showmessage('подгружаю ссылки');
  //Подгрузка списка ссылок на ресурсы
  combobox1.Items.Text:=(idhttp1.Get('https://raw.githubusercontent.com/ZongerX/Deskchanger/master/servers.txt'));
  abort;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  combobox1.OnChange(self);
  button1.Click;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  if Combobox2.ItemIndex=0 then Timer1.Enabled:=false
    else Timer1.Enabled:=true;
  if Combobox2.ItemIndex=1 then Timer1.Interval:=900000;
  if Combobox2.ItemIndex=2 then Timer1.Interval:=1800000;
  if Combobox2.ItemIndex=3 then Timer1.Interval:=3600000;
  if Combobox2.ItemIndex=4 then Timer1.Interval:=7200000;

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  begin
    if Form1.IdFTP1.Connected=false then
      begin
        idftp1.Host:='217.174.103.107';
        idftp1.Port:=21;
        idftp1.Username:='electro';
        idftp1.Password:='electro';
        idftp1.Connect;
      end;
    if pos('.jpg',edit1.Text)<>0 then
      begin
        idftp1.Get(edit1.text, GetWin('%AppData%')+'\img.bmp', true);
        SetWallpaper((GetWin('%AppData%')+'\img.bmp'), False);
      end;

//    edit1.Text:=(edit1.text+'/');
    Edit1.SelStart:=Length(Edit1.Text);
    idftp1.ChangeDir(edit1.text);
//    idFTP1.List(memo1.Lines,'',false);
    idFTP1.List(ListBox1.Items,'',false);
  end;
end;

procedure TForm1.Edit2Enter(Sender: TObject);
begin
  if Edit2.Text = 'IP' then
    begin
      Edit2.Font.Color:=clblack;
      Edit2.Text := '';
    end;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
var
  reg:TRegistry;
begin
  if Edit2.Text = '' then
    begin
      Edit2.Font.Color:=clgray;
      Edit2.Text := 'IP';
    end;

  //открытие ключа реестра HKEY_CURRENT_USER/DeskChanger
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);

  if (edit2.Text='') or (edit2.Text='Proxy IP') then
    begin
      idhttp1.ProxyParams.ProxyServer:='';
      idftp1.ProxySettings.Host:='';
      reg.DeleteValue('Proxy_server');
    end
      else
        begin
          idhttp1.ProxyParams.ProxyServer:=(Edit2.Text);
          idftp1.ProxySettings.Host:=(Edit2.Text);
          reg.WriteString('Proxy_server', Edit2.Text);
        end;

  reg.Free;
end;

procedure TForm1.Edit3Enter(Sender: TObject);
begin
  if Edit3.Text = 'Port' then
    begin
      Edit3.Font.Color:=clblack;
      Edit3.Text := '';
    end;
end;

procedure TForm1.Edit3Exit(Sender: TObject);
var
  reg:TRegistry;
begin
  if Edit3.Text = '' then
    begin
      Edit3.Font.Color:=clgray;
      Edit3.Text := 'Port';
      exit;
    end;

  //открытие ключа реестра HKEY_CURRENT_USER/DeskChanger
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);

  if (edit1.Text='') or (edit1.Text='Port') then
    begin
      idhttp1.ProxyParams.ProxyPort:=0;
      idftp1.ProxySettings.Port:=0;
      reg.DeleteValue('Proxy_port');
    end
      else
        begin
          idhttp1.ProxyParams.ProxyPort:=(StrToInt(Edit1.Text));
          idftp1.ProxySettings.Port:=(StrToInt(Edit1.Text));
          reg.WriteString('Proxy_port', Edit1.Text);
        end;

  reg.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.MessageBox('Закрыть программу?','Deskchanger',MB_YESNO+MB_ICONQUESTION);
  form1.Visible:=false;
  abort;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  reg:TRegistry;
  isProxyEnabled:boolean;
  ProxyServer,startparam:string;
  ProxyPort:integer;
begin
  form1.ClientHeight:=120;
  //Удаление файла старой версии
  DeleteFile(Pchar(Application.Title+'.old'));

  //Добавление верисии программы в заголовок
  Form1.Caption:= Form1.Caption+' '+ver;

  //Параметры запуска
  startparam := ParamStr(1);
  if startparam = '/s' then Application.ShowMainForm:=false;
//  if startparam = '/upd' then Trayicon1.ShowBalloonHint('Desktop Changer '+ver, 'Программа обновлена!', bitInfo, 10);


  try
  //Подгрузка списка ссылок на ресурсы
  combobox1.Items.Text:=(idhttp1.Get('https://raw.githubusercontent.com/ZongerX/Deskchanger/master/servers.txt'));
  except
    //Подгрузка SSL библиотек
    Label8.OnClick(self);
  end;



  //Загрузка настроек из реестра
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey('DeskChanger', False);

  //Загрузка ссылки
  if reg.ValueExists('Link') then ComboBox1.text:=(reg.ReadString('Link'));

  //Загрузка настроек прокси из реестра
  if reg.ReadString('AutoProxy')='1' then
  begin
    GetProxyData(isProxyEnabled, ProxyServer, ProxyPort);
      if isProxyEnabled=true then
      begin
        idhttp1.ProxyParams.ProxyServer:=(ProxyServer);
        idhttp1.ProxyParams.ProxyPort:=(ProxyPort);
//        ShowMessage(ProxyServer+':'+IntToStr(ProxyPort));
      end;
  end;

    //Загрузка настроек прокси из программы в реестр
    if reg.ReadString('AutoProxy')='0' then
      begin

        if reg.ValueExists('ProxyServer') then edit2.Text:=(reg.ReadString('ProxyServer'));
        if reg.ValueExists('ProxyPort') then edit3.Text:=(reg.ReadString('ProxyPort'));
      end;

  //Проверка на запись автозапуска в реестре
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
  if reg.ValueExists('DeskChanger') then Checkbox1.Checked:=true;
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
//Сворачивание/разворачивание настроек
if form1.ClientHeight<200 then Form1.ClientHeight:=form1.ClientHeight+105
  else button3.Click(); // form1.ClientHeight:=120;
end;

procedure TForm1.Label2ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  reg: TRegistry;
begin
  //Удаление настроек
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.DeleteKey('DeskChanger');
  checkbox1.Checked:=false;
  checkbox2.Checked:=false;
//  Deletefile(Pchar(ExtractFileDir(Application.ExeName)+'\'+'Config.ini'));
  reg.CloseKey;
  reg.Free;
  Application.MessageBox('Все настройки программы удалены!','Deskchanger',MB_OK);
end;

procedure TForm1.Label2MouseEnter(Sender: TObject);
begin
  Label2.Font.Color:=clwindowframe;
  Label2.Font.Style:=label2.Font.Style+[fsunderline];
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
begin
  Label2.Font.Color:=clgray;
  Label2.Font.Style:=Label2.Font.Style-[fsunderline];
end;

procedure TForm1.Label3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Form1.ClientHeight:=Listbox1.Top+190;

end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://vk.com/deskchanger', nil, nil, SW_SHOW);
end;

procedure TForm1.Label4MouseEnter(Sender: TObject);
begin
  Label4.Font.Color:=clwindowframe;
  Label4.Font.Style:=label4.Font.Style+[fsunderline];
end;

procedure TForm1.Label4MouseLeave(Sender: TObject);
begin
  Label4.Font.Color:=clgray;
  Label4.Font.Style:=Label4.Font.Style-[fsunderline];
end;

procedure TForm1.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Color:=clwindowframe;
  Label5.Font.Style:=label5.Font.Style+[fsunderline];
end;

procedure TForm1.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Color:=clgray;
  Label5.Font.Style:=Label5.Font.Style-[fsunderline];
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  //Ссылка на FTP "НЦ ОМЗ"
  ShellExecute(0, 'open', 'ftp://electro:electro@ftp.ntsomz.ru/', nil, nil, SW_SHOW);
end;

procedure TForm1.Label6MouseEnter(Sender: TObject);
begin
  Label6.Font.Color:=clwindowframe;
  Label6.Font.Style:=label6.Font.Style+[fsunderline];
end;

procedure TForm1.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color:=clgray;
  Label6.Font.Style:=Label6.Font.Style-[fsunderline];
end;

procedure TForm1.Label7Click(Sender: TObject);
var
  buf: TMemoryStream;
begin
  //Обновление программы
  try
    buf:=TMemoryStream.Create;
    RenameFile(Application.ExeName, Application.Title+'.old');

    //Попытка скачать с основного сервера, в ином случае с резерва
    try
      idHTTP1.Get('http://deskchanger.ru/deskchanger.exe',buf);
    except
      idHTTP1.Get('http://games-wars.ucoz.ru/deskchanger.upd',buf);
    end;

//  idHTTP1.Get('https://srv155-h-st.jino.ru/download?cid=dd6247818fb04d35ad90c299e1038b33&path=%2FDeskchanger%2Fdeskchanger.upd',buf);
    buf.SaveToFile(Application.Title+'.exe');
    buf.Clear;
    Application.Terminate;
    ShellExecute(Form1.Handle,'Open', Pchar(Application.Title+'.exe /upd'), nil, nil, SW_HIDE);
    DeleteFile(Pchar(Application.Title+'.old'));
  except
    on E : Exception do Showmessage('Не удалось обновить программу'+#13+E.Message);
//    Application.Terminate;
  end;
end;

procedure TForm1.Label7MouseEnter(Sender: TObject);
begin
  Label7.Font.Color:=clMenuHighlight;
  Label7.Font.Style:=label7.Font.Style+[fsunderline];
end;

procedure TForm1.Label7MouseLeave(Sender: TObject);
begin
  Label7.Font.Color:=clHighlight;
  Label7.Font.Style:=label7.Font.Style-[fsunderline];
end;

procedure TForm1.Label8Click(Sender: TObject);
var
  buf: TMemoryStream;
begin
  try
    buf:=TMemoryStream.Create;
    Form1.Button1.Enabled:=false;
    Form1.Button1.Caption:='Скачивание библиотеки libeay32.dll...';
//    idHTTP1.Get('https://srv155-h-st.jino.ru/download?cid=dd6247818fb04d35ad90c299e1038b33&path=%2FDeskchanger%2Flibeay32.dll',buf);
    idHTTP1.Get('http://games-wars.ucoz.ru/libeay32.dll',buf);
    buf.SaveToFile('libeay32.dll');
    buf.Clear;
    Form1.Button1.Caption:='Скачивание библиотеки ssleay32.dll...';
//    idHTTP1.Get('https://srv155-h-st.jino.ru/download?cid=dd6247818fb04d35ad90c299e1038b33&path=%2FDeskchanger%2Fssleay32.dll',buf);
    idHTTP1.Get('http://games-wars.ucoz.ru/ssleay32.dll',buf);
    buf.SaveToFile('ssleay32.dll');
    buf.Clear;
    Form1.Button1.Enabled:=true;
    Form1.Button1.Caption:='Обновить...';
  except
    on E : Exception do Showmessage('Не удалось загрузить SSL библиотеки:'+#13+E.Message);
  end;
  Form1.Button1.Enabled:=true;
  Form1.Button1.Caption:='Обновить';
end;

procedure TForm1.Label8MouseEnter(Sender: TObject);
begin
  Label8.Font.Color:=clwindowframe;
  Label8.Font.Style:=label8.Font.Style+[fsunderline];
end;

procedure TForm1.Label8MouseLeave(Sender: TObject);
begin
  Label8.Font.Color:=clgray;
  Label8.Font.Style:=Label8.Font.Style-[fsunderline];
end;

procedure TForm1.ListBox1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  idftp1.Disconnect;
  idftp1.Connect;
  idFTP1.ChangeDirUp();
  idftp1.List(ListBox1.Items,'',false); //Вывод списка папок
  edit1.Text:='/';
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);

begin
  edit1.Text:=edit1.Text+'/'+Listbox1.Items[listbox1.ItemIndex]; //Добавление в edit выделенной строки из listbox

  if pos('.jpg',edit1.Text)<>0 then
    else
      begin
        idftp1.ChangeDir(edit1.text);     //Смена директории FTP
        idftp1.List(ListBox1.Items,'',false);   //Вывод списка папок
      end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  if radiobutton1.Checked=true then
    begin
      edit2.Enabled:=false;
      edit3.Enabled:=false;
    end;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  if radiobutton2.Checked=true then
    begin
      edit2.Enabled:=true;
      edit3.Enabled:=true;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  button1.Click;

  //Подгрузка списка ссылок на ресурсы
  try
  combobox1.Items.Text:=(idhttp1.Get('https://raw.githubusercontent.com/ZongerX/Deskchanger/master/servers.txt'));
  except
//    резервный список ссылок
  end;

  //Проверка обновления программы
  if idhttp1.Get('https://raw.githubusercontent.com/ZongerX/Deskchanger/master/servers.txt') <> ver then
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if checkbox1.Checked then button1.Click;
  timer2.Destroy;
end;

procedure TForm1.TrayIcon1BalloonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  form1.Visible:=true;
end;

procedure TForm1.TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbLeft then
    begin
    end;

  if button = mbRight then
    begin
      Application.Terminate;
      sleep(100);
    end;

  if button = mbMiddle then
    begin
    end;


end;

end.
