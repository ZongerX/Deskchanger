unit Unit1;


interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Graphics, IdFTP, Menus,
  CoolTrayIcon, ExtCtrls, IdBaseComponent, IdComponent, 
  IdHTTP, StdCtrls, Controls, Forms,  Dialogs, Registry,
  WinProcs, ShellApi, IniFiles, Buttons, ComObj, ShlObj, IdTCPClient, wininet, IdTCPConnection,
  XPMan, StrUtils, ComCtrls;
type
  TForm1 = class(TForm)
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    sas1: TMenuItem;
    N1: TMenuItem;
    CheckBox2: TCheckBox;
    N2: TMenuItem;
    ComboBox1: TComboBox;
    Label2: TLabel;
    CheckBox3: TCheckBox;
    Edit2: TEdit;
    Edit1: TEdit;
    N3: TMenuItem;
    IdFTP1: TIdFTP;
    Button2: TButton;
    Label7: TLabel;
    Edit3: TEdit;
    Memo1: TMemo;
    Label3: TLabel;
    CheckBox4: TCheckBox;
    Timer2: TTimer;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Memo2: TMemo;
    CoolTrayIcon1: TCoolTrayIcon;
    Label10: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure IdHTTP1Redirect(Sender: TObject; var dest: String;
      var NumRedirect: Integer; var Handled: Boolean;
      var VMethod: TIdHTTPMethod);
    procedure CoolTrayIcon1Click(Sender: TObject);
    procedure CoolTrayIcon1MinimizeToTray(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure sas1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure Label6ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Label2Click(Sender: TObject);
    procedure Label2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure N3Click(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Label7ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure CheckBox4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label9MouseEnter(Sender: TObject);
    procedure Label8MouseEnter(Sender: TObject);
    procedure Label9MouseLeave(Sender: TObject);
    procedure Label8MouseLeave(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Change(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label10MouseEnter(Sender: TObject);
    procedure Label10MouseLeave(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  IdHTTP1: TIdHTTP;
  ver: string = '0.6.2';
  redir: boolean;
  IniFile : TIniFile;
  url: string;
  HD: boolean;

implementation

{$R *.dfm}


function Sort(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result:=StrToInt(List[Index1])-StrToInt(List[Index2]);
end;

procedure CheckUpdate();
var
  last:string;
begin
  //Проверка обновления
  last:=Form1.idhttp1.Get('http://games-wars.ucoz.ru/Lver.txt');
  if ver<>last then
    begin
      Form1.Label2.Visible:=true;
      Form1.CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Доступна новая версия '+last, bitInfo, 10);
      idhttp1.ClearWriteBuffer;
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
    if Form1.checkbox5.Checked then WriteString('', 'WallpaperStyle', '6');
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

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
const
 Desktop: TGuid='{75048700-EF1F-11D0-9888-006097DEACF9}'; //для получения доступа к рабочему столу
var
  ActiveDeskTop:IActiveDesktop; //Активация рабочего стола
begin
if key = #13 then
begin
 if Form1.IdFTP1.Connected=false then 
  begin
  idftp1.Host:='217.174.103.107';
  idftp1.Port:=21;
  idftp1.Username:='electro';
  idftp1.Password:='electro';
  idftp1.Connect(true, 30000);
  AssErt(idftp1.Connected);
  end;
  
  if pos('.jpg',edit3.Text)<>0 then
    begin
      idftp1.Get(edit3.text, GetWin('%AppData%')+'\img', true);
      ActiveDesktop:=CreateComObject(Desktop) as IActiveDesktop; //создаем объект и получаем разрешение доступа к рабочему столу
      ActiveDesktop.SetWallpaper(StringToOleStr(GetWin('%AppData%')+'\img'), 0); // определились с выбором картинки
      ActiveDesktop.ApplyChanges(AD_APPLY_ALL); // применяем картинку на рабочем столе
    end
      else
        begin
          edit3.Text:=(edit3.text+'/');
          Edit3.SelStart:=Length(Edit3.Text);
          idftp1.ChangeDir(edit3.text);
          idFTP1.List(memo1.Lines,'',false);
          idFTP1.List(ListBox1.Items,'',false);
        end;
idftp1.Disconnect;
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  buf: TMemoryStream;
begin
  //Подгрузка конфига с переводом
  IniFile:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
  if (Combobox1.Text=IniFile.ReadString('LANG','CHOOSELINK','Выберите ссылку')) or (ComboBox1.Text='')   then
    begin
      CoolTrayIcon1.ShowBalloonHint('Desktop Changer', IniFile.ReadString('LANG','CHOOSELINK','Выберите ссылку'), bitwarning, 10);
      exit;
    end;
      if ComboBox1.Text='Original FTP' then
          begin
            HD:=false;
            Button2.Click;
            exit;
          end
            else if ComboBox1.Text='Original FTP HD' then
              begin
                HD:=true;
                Button2.Click;
                exit;
              end;

  Button1.Enabled:=false;
  Button1.Caption:=(IniFile.ReadString('LANG','DOWNLOADING','Загрузка ')+'...');
  CoolTrayIcon1.Hint:=('DeskChanger '+ver+ #13 +IniFile.ReadString('LANG','DOWNLOADING','Загрузка'+'...'));
  if pos('http://', Combobox1.Text)=0 then ComboBox1.Text:=('http://'+Combobox1.Text);
    try
      begin
        //Загрузка изображения
        idHTTP1.get(Combobox1.Text);
        //Проверка на редирект
        buf:=TMemoryStream.Create;
        if redir=true then idHTTP1.Get(url, buf)
          else idHTTP1.Get(Combobox1.Text, buf);
        Button1.Caption:=(IniFile.ReadString('LANG','INSTALL','Установка'+'...'));
        Button1.Update;
        //Сохранение
        buf.SaveToFile(GetWin('%AppData%')+'\img.jpg');
//        buf.Clear;
        //Установка обоев
        SetWallpaper(Pchar(GetWin('%AppData%')+'\img.jpg'), False);
//        deletefile(Pchar(GetWin('%AppData%')+'\img'));
        if checkbox2.Checked then CoolTrayIcon1.ShowBalloonHint('DeskChanger '+ver,IniFile.ReadString('LANG','DESKTOPUPATED','Обои обновлены'), bitinfo, 10);
        label4.Visible:=true;
        label4.Caption:=(IniFile.ReadString('LANG','LASTUPDATED','Последнее обновление:')+' '+FormatDateTime('hh:mm',now));
        CoolTrayIcon1.Hint:=('DeskChanger '+ver+ #13 +IniFile.ReadString('LANG','LASTUPDATE','Последнее обновление:')+' '+FormatDateTime('hh:mm',now));
      end;
    except
      Button1.Caption:=(IniFile.ReadString('LANG','UPDATE','Обновить'));
      Button1.Enabled:=true;
//      idhttp1.Disconnect;
    end;
  Button1.Caption:=(IniFile.ReadString('LANG','UPDATE','Обновить'));
  Button1.Enabled:=true;
  IniFile.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
try
  if Combobox2.ItemIndex<>0 then button1.Click;  
  CheckUpdate(); //Проверка обновления
//  idhttp1.Disconnect;
except
  CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, IniFile.ReadString('LANG','CHECKINTERNET','Проверьте интернет соединение!'), biterror, 10);
end;
end;

procedure TForm1.IdHTTP1Redirect(Sender: TObject; var dest: String;
  var NumRedirect: Integer; var Handled: Boolean;
  var VMethod: TIdHTTPMethod);
begin
  try
    redir:=true;
    url:=idhttp1.Response.Location;
  except
  end;
end;

procedure TForm1.CoolTrayIcon1Click(Sender: TObject);
begin
  Form1.Visible:=true;
end;

procedure TForm1.CoolTrayIcon1MinimizeToTray(Sender: TObject);
begin
  Form1.Hide;
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

procedure TForm1.Label6Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://vk.com/deskchanger', nil, nil, SW_SHOW);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  reg:TRegistry;
  isProxyEnabled:boolean;
  ProxyServer,startparam:string;
  ProxyPort:integer;
begin
try
  //Параметры запуска
  startparam := ParamStr(1);
  if startparam = '/s' then Application.ShowMainForm:=false;
  if startparam = '/upd' then CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Программа обновлена!', bitInfo, 10);
  if startparam = '/deb' then
    begin
      button2.Visible:=true;
      edit3.Visible:=true;
      memo1.Visible:=true;
      Form1.ClientHeight:=300;
      label3.Visible:=true;
    end;

  idhttp1.Request.UserAgent:=('Win/ZongerX/DeskChanger/'+ver);
  Form1.Caption:=(Form1.Caption+' '+ver);
  CoolTrayIcon1.Hint:=('DeskChanger '+ver);
  Form1.ClientHeight:=115;
//^ Не трогать

  //INI Считывание
  IniFile:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\'+'Config.ini');
  Button1.Caption:=IniFile.ReadString('LANG','UPDATE','Обновить');
  Label2.Caption:=IniFile.ReadString('LANG','UPDATEPROGRAM','Обновить программу!');
  Label4.Caption:=IniFile.ReadString('LANG','LASTUPDATE','Последнее обновление: ');
  Label5.Caption:=IniFile.ReadString('LANG','WINDSMAP','Карта ветров');
  Label6.Caption:=IniFile.ReadString('LANG','SUPPORT','Поддержка');
  Label7.Caption:=IniFile.ReadString('LANG','SETTINGS','Настройки');
  Combobox1.Text:=IniFile.ReadString('LANG','CHOOSELINK','Выберите ссылку');
  Label7.Left:=IniFile.ReadInteger('FONT','Label7',254);
  Label6.Left:=IniFile.ReadInteger('FONT','Label6',193);
  Label5.Left:=IniFile.ReadInteger('FONT','Label5',121);
  IniFile.Free;
//  showmessage(ExtractFileDir(Application.ExeName)+'\Config.ini');

  //Выставление интервала обновления
  if Combobox2.ItemIndex=0 then Timer1.Enabled:=false
    else Timer1.Enabled:=true;
  if Combobox2.ItemIndex=1 then Timer1.Interval:=900000;
  if Combobox2.ItemIndex=2 then Timer1.Interval:=1800000;
  if Combobox2.ItemIndex=3 then Timer1.Interval:=3600000;
  if Combobox2.ItemIndex=4 then Timer1.Interval:=7200000;

  //Горячие клавиши
  RegisterHotkey(Handle, 1, MOD_SHIFT, VK_F9);

  //Загрузка настроек из реестра
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey('DeskChanger', False);

  //Загрузка ссылки
  if reg.ValueExists('Link') then ComboBox1.text:=(reg.ReadString('Link'));

  //Оповещение
  if reg.ValueExists('Notification') then
  begin
    Checkbox2.Checked:=true;
    N2.Checked:=true;
  end
    else
      begin
        Checkbox2.Checked:=false;
        N2.Checked:=false;
      end;

  //Иконка в трее
  if reg.ReadString('TrayIcon')='1' then
  begin
    CoolTrayicon1.IconVisible:=true;
    Checkbox3.Checked:=true
  end;
  if reg.ReadString('TrayIcon')='0' then
  begin
    CoolTrayicon1.IconVisible:=false;
    Checkbox3.Checked:=false;
    CheckBox2.Enabled:=false
  end;

  //Загрузка настроек прокси из системы
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

  if reg.ReadString('AutoProxy')='0' then
  begin
    //Загрузка настроек прокси из программы
    if reg.ValueExists('ProxyServer') then edit2.Text:=(reg.ReadString('ProxyServer'));
    if reg.ValueExists('ProxyPort') then edit1.Text:=(reg.ReadString('ProxyPort'));
  end;

  //Загрузка частоты обновления
  if reg.ReadString('Update')='0'   then Combobox2.ItemIndex:=0;
  if reg.ReadString('Update')='15'  then Combobox2.ItemIndex:=1;
  if reg.ReadString('Update')='30'  then Combobox2.ItemIndex:=2;
  if reg.ReadString('Update')='60'  then Combobox2.ItemIndex:=3;
  if reg.ReadString('Update')='120' then Combobox2.ItemIndex:=4;

  //Дебаг режим
  if reg.ValueExists('Debug') then
    begin
      button2.Visible:=true;
      edit3.Visible:=true;
      memo1.Visible:=true;
      Form1.ClientHeight:=300;
      label3.Visible:=true;
    end;

   //Изображение по центру
   if reg.ValueExists('WallpaperStyle') then Checkbox5.Checked:=true;

  //Проверка на запись автозапуска в реестре
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
  if reg.ValueExists('DeskChanger') then
    begin
      Checkbox1.Checked:=true;
//      Application.ShowMainForm:=false;
    end;

except
 CoolTrayIcon1.ShowBalloonHint('DeskChanger '+ver,'При запуске что-то пошло не так!', biterror, 10);
end;

try
if Checkbox4.Checked=true then Combobox1.Items.Text:=(idhttp1.Get('http://games-wars.ucoz.ru/servers.txt'));
except
  CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, IniFile.ReadString('LANG','CHECKINTERNET','Проверьте интернет соединение!'), biterror, 10);
end;
end;

//Действие при хоткее
procedure TForm1.WMHotkey( var msg: TWMHotkey );
begin
  if msg.hotkey = 1 then Form1.Show;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
Cooltrayicon1.PopupMenu:=popupmenu1;
end;

procedure TForm1.sas1Click(Sender: TObject);
begin
Form1.Button1.Click;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
if checkbox2.Checked=true then
  begin
    checkbox2.Checked:=false;
    N2.Checked:=false
  end
    else
      begin
        checkbox2.Checked:=true;
        N2.Checked:=true
      end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
var
  reg: TRegistry;
begin
if checkbox2.Checked=true then
  begin
    N2.Checked:=true;
    checkbox2.Checked:=true;
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('Notification', '');
    reg.Free;
  end
    else
      begin
        N2.Checked:=false;
        checkbox2.Checked:=false;
        reg:=TRegistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.OpenKey('DeskChanger', True);
        reg.DeleteValue('Notification');
        reg.Free;
      end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Hide;
  if form1.ClientHeight<>115 then Label7.OnClick(Self);
  abort;
end;

procedure TForm1.Label6MouseEnter(Sender: TObject);
begin
  Label6.Font.Color:=clHotLight;
  Label6.Font.Style:=label6.Font.Style +[fsunderline];
end;

procedure TForm1.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color:=clgray;
  Label6.Font.Style:=label6.Font.Style -[fsunderline];
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
var
  reg:TRegistry;
begin
if ComboBox1.Text<>'' then
  begin
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.CreateKey('DeskChanger');
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('Link', ComboBox1.Text);
    reg.Free;
  end
    else
      begin
        reg:=TRegistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.CreateKey('DeskChanger');
        reg.OpenKey('DeskChanger', True);
        reg.DeleteValue('Link');
        reg.Free;
      end;
  Combobox1.Update;
  button1.Click;
end;

procedure TForm1.Label6ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if label3.Visible=false then
    begin
      Form1.ClientHeight:=(Label3.Top+Memo1.Height+40);
      button2.Visible:=true;
      edit3.Visible:=true;
      memo1.Visible:=true;
      label3.Visible:=true;
      Checkbox6.Checked:=true;
    end
      else
        begin
          Form1.ClientHeight:=250;
          button2.Visible:=false;
          edit3.Visible:=false;
          memo1.Visible:=false;
          label3.Visible:=false;
          Checkbox6.Checked:=false;
        end;
end;

procedure TForm1.Label2Click(Sender: TObject);
var
  buf: TMemoryStream;  
begin
  try
    Label2.Caption:=IniFile.ReadString('LANG','UPDATE',Button1.Caption);
    buf:=TMemoryStream.Create;
    RenameFile(Application.ExeName, Application.Title+'.old');
    idHTTP1.Get('http://games-wars.ucoz.ru/deskchanger.upd',buf);
    buf.SaveToFile(Application.Title+'.exe');
    IdHTTP1.Free;
    buf.Free;
    Application.Terminate;
    ShellExecute(Form1.Handle,'Open', Pchar(Application.Title+'.exe /upd'), nil, nil, SW_HIDE);
    DeleteFile(Pchar(Application.Title+'.old'));
  except
    Showmessage('Не удалось обновить программу');
    Application.Terminate;
  end;
end;

procedure TForm1.Label2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Label2.Font.Color:=clHotLight;
end;

procedure TForm1.Label2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Label2.Font.Color:=clgray;
end;

procedure TForm1.Label2MouseEnter(Sender: TObject);
begin
  Label2.Font.Color:=clwindowframe;
  Label2.Font.Style:=label2.Font.Style +[fsunderline];
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
begin
  Label2.Font.Color:=clgray;
  Label2.Font.Style:=label2.Font.Style -[fsunderline];
end;

procedure TForm1.GroupBox1Click(Sender: TObject);
begin
  if form1.ClientHeight<>200 then
    begin
      checkbox3.Visible:=true;
      Form1.ClientHeight:=200
    end
  else
    begin
      checkbox3.Visible:=false;
      form1.ClientHeight:=115;
    end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
var
  reg: TRegistry;
begin
if checkbox3.Checked=true then
  begin
    CoolTrayicon1.IconVisible:=true;
    CheckBox2.Enabled:=true;
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('TrayIcon','1');
    reg.Free;
  end
  else
    begin
      CheckBox2.Enabled:=false;
      CoolTrayicon1.IconVisible:=false;
      reg:=TRegistry.Create;
      reg.RootKey:=HKEY_CURRENT_USER;
      reg.OpenKey('DeskChanger', True);
      reg.WriteString('TrayIcon','0');
      reg.Free;
    end;
end;

procedure TForm1.CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CheckBox3.Checked=false then Showmessage('Горячие клавиши для показа главного окна Shift+F9');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnRegisterHotkey( Handle, 1 );
end;

procedure TForm1.Edit2Change(Sender: TObject);
var
  reg:TRegistry;
begin
if (edit2.Text='') or (edit2.Text='Proxy IP') then
  begin
    idhttp1.ProxyParams.ProxyServer:='';
    idftp1.ProxySettings.Host:='';
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.CreateKey('DeskChanger');
    reg.OpenKey('DeskChanger', True);
    reg.DeleteValue('Proxy_server');
    reg.Free;
  end
    else
      begin
        idhttp1.ProxyParams.ProxyServer:=(Edit2.Text);
        idftp1.ProxySettings.Host:=(Edit2.Text);
        reg:=TRegistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.CreateKey('DeskChanger');
        reg.OpenKey('DeskChanger', True);
        reg.WriteString('Proxy_server', Edit2.Text);
        reg.Free;
      end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  reg:TRegistry;
begin
if (edit1.Text='') or (edit1.Text='Port') then
  begin
    idhttp1.ProxyParams.ProxyPort:=0;
    idftp1.ProxySettings.Port:=0;
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.CreateKey('DeskChanger');
    reg.OpenKey('DeskChanger', True);
    reg.DeleteValue('Proxy_port');
    reg.Free;
  end
    else
      begin
        idhttp1.ProxyParams.ProxyPort:=(StrToInt(Edit1.Text));
        idftp1.ProxySettings.Port:=(StrToInt(Edit1.Text));
        reg:=TRegistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.CreateKey('DeskChanger');
        reg.OpenKey('DeskChanger', True);
        reg.WriteString('Proxy_port', Edit1.Text);
        reg.Free;
      end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Form1.Show;
  if form1.ClientHeight=115 then label7.OnClick(Self);
end;





procedure TForm1.Label7Click(Sender: TObject);
begin
if form1.ClientHeight<200 then Form1.ClientHeight:=form1.ClientHeight+150
  else form1.ClientHeight:=115;
end;

procedure TForm1.Edit2Enter(Sender: TObject);
begin
  if Edit2.Text = 'Proxy IP' then
    begin
      Edit2.Font.Color:=clblack;
      Edit2.Text := '';
    end;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
begin
  if Edit2.Text = '' then
    begin
      Edit2.Font.Color:=clgray;
      Edit2.Text := 'Proxy IP';
    end;
end;

procedure TForm1.Edit1Enter(Sender: TObject);
begin
  if Edit1.Text = 'Port' then
    begin
      Edit1.Font.Color:=clblack;
      Edit1.Text := '';
    end;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text = '' then
    begin
      Edit1.Font.Color:=clgray;
      Edit1.Text := 'Port';
    end;
end;

procedure TForm1.Label7ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  reg: TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.DeleteKey('DeskChanger');
  N2.Checked:=false;
  checkbox2.Checked:=false;
  checkbox1.Checked:=false;
  Deletefile(Pchar(ExtractFileDir(Application.ExeName)+'\'+'Config.ini'));
  reg.CloseKey;
  reg.Free;
  Showmessage('Все настройки удалены');
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
var
  reg:TRegistry;
begin
Combobox1.Items.Text:=(idhttp1.Get('http://games-wars.ucoz.ru/servers.txt'));
if checkbox4.Checked=true then
  begin
    CheckBox4.Checked:=true;
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('ServerLinks','1');
    reg.Free;
  end
  else
    begin
    CheckBox4.Checked:=false;
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('ServerLinks','0');
    reg.Free;
    end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  reg:TRegistry;
begin
reg:=TRegistry.Create;
if ComboBox1.Text<>'' then
  begin
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.CreateKey('DeskChanger');
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('Link', ComboBox1.Text);
    reg.Free;
  end
    else
      begin
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.CreateKey('DeskChanger');
        reg.OpenKey('DeskChanger', True);
        reg.DeleteValue('Link');
        reg.Free;
      end;
end;



procedure TForm1.Label7MouseEnter(Sender: TObject);
begin
Label7.Font.Color:=clwindowframe;
Label7.Font.Style:=label7.Font.Style +[fsunderline];
end;

procedure TForm1.Label7MouseLeave(Sender: TObject);
begin
Label7.Font.Color:=clgray;
Label7.Font.Style:=label7.Font.Style -[fsunderline];
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  reg:Tregistry;
  startparam:string;
begin
  try
  //Загрузка списка ссылок
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey('DeskChanger', False);
  if reg.ReadString('ServerLinks')='1' then checkbox4.Checked:=true;

  CheckUpdate();  //Проверка обновления

  //Обновление изображения при запуске
  startparam := ParamStr(1);
  if startparam = '/s' then
    begin
      Application.ShowMainForm:=false;
      if Combobox2.ItemIndex<>0 then button1.Click;
    end;

  Timer2.Enabled:=false;
except
  if checkbox2.Checked then CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Проверьте интернет соединение', biterror, 10);
end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
if radiobutton1.Checked=true then
  begin
    edit1.Enabled:=false;
    edit2.Enabled:=false;
  end;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
if radiobutton2.Checked=true then
    begin
      edit1.Enabled:=true;
      edit2.Enabled:=true;
    end;
end;

procedure TForm1.ComboBox1Exit(Sender: TObject);
begin
if pos(combobox1.Text, combobox1.Items.Text)=0 then
  begin
    combobox1.Items.text:=(combobox1.items.text+combobox1.Text);
  end;
end;

procedure TForm1.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Color:=clHotLight;
  Label5.Font.Style:=label5.Font.Style +[fsunderline];
end;

procedure TForm1.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Color:=clgray;
  Label5.Font.Style:=label5.Font.Style -[fsunderline];
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://earth.nullschool.net/#current/wind/surface/level/orthographic=-281.69,4.61,416', nil, nil, SW_SHOW);
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
  IniFile:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
  IniFile.WriteString('LANG','UPDATE','Обновить');
  IniFile.WriteString('LANG','UPDATEPROGRAM','Обновить программу!');
  IniFile.WriteString('LANG','LASTUPDATE','Последнее обновление:');
  IniFile.WriteString('LANG','WINDSMAP','Карта ветров');
  IniFile.WriteString('LANG','SUPPORT','Поддержка');
  IniFile.WriteString('LANG','SETTINGS','Настройки');
  IniFile.WriteString('LANG','PROXY','Прокси');
  IniFile.WriteString('LANG','AUTOSEARCH','Автоопределение');
  IniFile.WriteString('LANG','SETPROXY','Указать прокси вручную');
  IniFile.WriteString('LANG','SERVERLINKS','Ссылки с сервера');
  IniFile.WriteString('LANG','TRAYICON','Иконка в трее');
  IniFile.WriteString('LANG','NOTIFICATION','Оповещение');
  IniFile.WriteString('LANG','AUTOSTART','Автозапуск');
  IniFile.WriteString('LANG','CHOOSELINK','Выберите ссылку');
  IniFile.WriteString('LANG','DESKTOPUPDATE','Обои обновлены');
  IniFile.WriteString('LANG','DOWNLOADING','Загрузка');
  IniFile.WriteString('LANG','INSTALL','Установка');
  IniFile.WriteString('LANG','CHECKINTERNET','Проверьте интернет соединение!');
  IniFile.WriteString('LANG','UPDATEINTERVAL','Интервал обновления:');
  IniFile.WriteInteger('FONT','Label7',253);
  IniFile.WriteInteger('FONT','Label6',192);
  IniFile.WriteInteger('FONT','Label5',120);

  //Установка
  Button1.Caption:=IniFile.ReadString('LANG','UPDATE',Button1.Caption);
  Label2.Caption:=IniFile.ReadString('LANG','UPDATEPROGRAM',Label2.Caption);
  Label4.Caption:=IniFile.ReadString('LANG','LASTUPDATE',Label4.Caption);
  Label5.Caption:=IniFile.ReadString('LANG','WINDSMAP',Label5.Caption);
  Label6.Caption:=IniFile.ReadString('LANG','SUPPORT',Label6.Caption);
  Label7.Caption:=IniFile.ReadString('LANG','SETTINGS',Label7.Caption);
  Groupbox1.Caption:=IniFile.ReadString('LANG','PROXY',Groupbox1.Caption);
  Radiobutton1.Caption:=IniFile.ReadString('LANG','AUTOSEARCH',Radiobutton1.Caption);
  Radiobutton2.Caption:=IniFile.ReadString('LANG','SETPROXY',Radiobutton2.Caption);
  Checkbox4.Caption:=IniFile.ReadString('LANG','SERVERLINKS',Checkbox4.Caption);
  Checkbox3.Caption:=IniFile.ReadString('LANG','TRAYICON',Checkbox3.Caption);
  Checkbox2.Caption:=IniFile.ReadString('LANG','NOTIFICATION',Checkbox2.Caption);
  Checkbox1.Caption:=IniFile.ReadString('LANG','AUTOSTART',Checkbox1.Caption);
  Label1.Caption:=IniFile.ReadString('LANG','UPDATEINTERVAL',Label1.Caption);
//  Combobox1.Text:=IniFile.ReadString('LANG','CHOOSELINK',Combobox1.Text);
  Label7.Left:=IniFile.ReadInteger('FONT','Label7',254);
  Label6.Left:=IniFile.ReadInteger('FONT','Label6',193);
  Label5.Left:=IniFile.ReadInteger('FONT','Label5',121);

  IniFile.Free;
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  //Запись в файл конфигурации
  IniFile:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
  IniFile.WriteString('LANG','UPDATE','Update');
  IniFile.WriteString('LANG','UPDATEPROGRAM','Update programm!');
  IniFile.WriteString('LANG','LASTUPDATE','Last update:');
  IniFile.WriteString('LANG','WINDSMAP','Winds map');
  IniFile.WriteString('LANG','SUPPORT','Support');
  IniFile.WriteString('LANG','SETTINGS','Settings');
  IniFile.WriteString('LANG','PROXY','Proxy');
  IniFile.WriteString('LANG','AUTOSEARCH','Autosearch');
  IniFile.WriteString('LANG','SETPROXY','Set proxy');
  IniFile.WriteString('LANG','SERVERLINKS','Server links');
  IniFile.WriteString('LANG','TRAYICON','Tray icon');
  IniFile.WriteString('LANG','NOTIFICATION','Notification');
  IniFile.WriteString('LANG','AUTOSTART','Autostart');
  IniFile.WriteString('LANG','CHOOSELINK','Select the link');
  IniFile.WriteString('LANG','DESKTOPUPDATED','Desktop updated');
  IniFile.WriteString('LANG','DOWNLOADING','Downloading');
  IniFile.WriteString('LANG','INSTALL','Install');
  IniFile.WriteString('LANG','CHECKINTERNET','Check you internet connection!');
  IniFile.WriteString('LANG','UPDATEINTERVAL','Update interval:');
  IniFile.WriteInteger('FONT','Label7',271);
  IniFile.WriteInteger('FONT','Label6',232);
  IniFile.WriteInteger('FONT','Label5',176);


  //Установка
  Button1.Caption:=IniFile.ReadString('LANG','UPDATE',Button1.Caption);
  Label2.Caption:=IniFile.ReadString('LANG','UPDATEPROGRAM',Label2.Caption);
  Label4.Caption:=IniFile.ReadString('LANG','LASTUPDATE',Label4.Caption);
  Label5.Caption:=IniFile.ReadString('LANG','WINDSMAP',Label5.Caption);
  Label6.Caption:=IniFile.ReadString('LANG','SUPPORT',Label6.Caption);
  Label7.Caption:=IniFile.ReadString('LANG','SETTINGS',Label7.Caption);
  Groupbox1.Caption:=IniFile.ReadString('LANG','PROXY',Groupbox1.Caption);
  Radiobutton1.Caption:=IniFile.ReadString('LANG','AUTOSEARCH',Radiobutton1.Caption);
  Radiobutton2.Caption:=IniFile.ReadString('LANG','SETPROXY',Radiobutton2.Caption);
  Checkbox4.Caption:=IniFile.ReadString('LANG','SERVERLINKS',Checkbox4.Caption);
  Checkbox3.Caption:=IniFile.ReadString('LANG','TRAYICON',Checkbox3.Caption);
  Checkbox2.Caption:=IniFile.ReadString('LANG','NOTIFICATION',Checkbox2.Caption);
  Checkbox1.Caption:=IniFile.ReadString('LANG','AUTOSTART',Checkbox1.Caption);
  Label1.Caption:=IniFile.ReadString('LANG','UPDATEINTERVAL',Label1.Caption);

//  Combobox1.Text:=IniFile.ReadString('LANG','CHOOSELINK',Combobox1.Text);
  Label7.Left:=IniFile.ReadInteger('FONT','Label7',271);
  Label6.Left:=IniFile.ReadInteger('FONT','Label6',232);
  Label5.Left:=IniFile.ReadInteger('FONT','Label5',176);

  IniFile.Free;
end;

procedure TForm1.Label9MouseEnter(Sender: TObject);
begin
Label9.Font.Color:=clwindowframe;
Label9.Font.Style:=label9.Font.Style +[fsunderline];
end;

procedure TForm1.Label8MouseEnter(Sender: TObject);
begin
Label8.Font.Color:=clwindowframe;
Label8.Font.Style:=label8.Font.Style +[fsunderline];
end;

procedure TForm1.Label9MouseLeave(Sender: TObject);
begin
Label9.Font.Color:=clgray;
Label9.Font.Style:=label9.Font.Style -[fsunderline];
end;

procedure TForm1.Label8MouseLeave(Sender: TObject);
begin
Label8.Font.Color:=clgray;
Label8.Font.Style:=label8.Font.Style -[fsunderline];
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
  var
    reg:TRegistry;
begin
  //Выставление интервала обновления
  if Combobox2.ItemIndex=0 then Timer1.Enabled:=false
    else Timer1.Enabled:=true;
  if Combobox2.ItemIndex=1 then Timer1.Interval:=900000;
  if Combobox2.ItemIndex=2 then Timer1.Interval:=1800000;
  if Combobox2.ItemIndex=3 then Timer1.Interval:=3600000;
  if Combobox2.ItemIndex=4 then Timer1.Interval:=7200000;


  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);
  if Combobox2.ItemIndex=0 then reg.WriteString('Update', '0');
  if Combobox2.ItemIndex=1 then reg.WriteString('Update', ComboBox2.Text);
  if Combobox2.ItemIndex=2 then reg.WriteString('Update', ComboBox2.Text);
  if Combobox2.ItemIndex=3 then reg.WriteString('Update', ComboBox2.Text);
  if Combobox2.ItemIndex=4 then reg.WriteString('Update', ComboBox2.Text);
  reg.Free;
end;

procedure TForm1.Label10Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'ftp://ftp.ntsomz.ru/', nil, nil, SW_SHOW);
end;

procedure TForm1.Label10MouseEnter(Sender: TObject);
begin
  Label10.Font.Color:=clHotLight;
  Label10.Font.Style:=label10.Font.Style +[fsunderline];
end;

procedure TForm1.Label10MouseLeave(Sender: TObject);
begin
  Label10.Font.Color:=clgray;
  Label10.Font.Style:=label10.Font.Style -[fsunderline];
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FTP: TStringList;
  Mon,MonStr,Year,Date:String;

  yearcycle:integer;
begin
  try
  FTP:=TStringList.Create;

  Date:=(DateToStr(GetCurrentDateTime)); //сегодняшнюю дату в тип str и в переменную
  Mon:=Date[4]+Date[5];//месяц 4 и 5 цифра
  Year:=Date[7]+Date[8]+Date[9]+Date[10]; //год 7,8,9 и 10 цифры

  //Перевод числовых значений месяца в строковые
  if Mon='01' then MonStr:='January';
  if Mon='02' then MonStr:='February';
  if Mon='03' then MonStr:='March';
  if Mon='04' then MonStr:='April';
  if Mon='05' then MonStr:='May';
  if Mon='06' then MonStr:='June';
  if Mon='07' then MonStr:='July';
  if Mon='08' then MonStr:='August';
  if Mon='09' then MonStr:='September';
  if Mon='10' then MonStr:='October';
  if Mon='11' then MonStr:='November';
  if Mon='12' then MonStr:='December';

  //Определение настроек FTP
  Form1.idftp1.Host:='217.174.103.107';
  Form1.idftp1.Port:=21;
  Form1.idftp1.Username:='electro';
  Form1.idftp1.Password:='electro';

  yearcycle:=1;//количество повторений

  //Начало поиска, оповещение пользователя
  Form1.Button1.Enabled:=false;
  Form1.Button1.Caption:='Поиск снимка...';
  Form1.Update;

  Try
    begin
      //Подключение к ftp
      Form1.idftp1.Connect(true, 60000);  //Подключение
      AssErt(Form1.idftp1.Connected);     //Подключение
      Form1.idFTP1.List(Form1.memo1.Lines,'',false); //Вывод списка папок


      //Сортировка по возрастанию
//      FTP.Assign(Form1.Memo1.Lines);
      FTP.CustomSort(Sort);
      Form1.Update;
      Form1.Memo1.Lines.Assign(FTP);
      Form1.Update;
      
      //Переход в корень FTP
      Form1.Memo2.Clear;
      Form1.edit3.Text:='/ELECTRO_L_2';
      Form1.edit3.Text:=Form1.edit3.Text+(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-yearcycle]+'');  // Перейти по последнему пункту из списка
      Form1.idftp1.ChangeDir(Form1.edit3.text);      //Смена директории FTP
      Form1.idFTP1.List(Form1.memo1.Lines,'',false); //Вывод списка папок
      Form1.idFTP1.List(ListBox1.Items,'',false);
      Form1.Update;

      //Перевод слов в цифры
      if pos('January', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('01');
      if pos('February', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('02');
      if pos('March', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('03');
      if pos('April', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('04');
      if pos('May', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('05');
      if pos('June', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('06');
      if pos('July', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('07');
      if pos('August', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('08');
      if pos('September', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('09');
      if pos('October', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('10');
      if pos('November', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('11');
      if pos('December', Form1.Memo1.Lines.Text)>0 then Form1.memo2.Lines.Add('12');


      //Сортировка по возрастанию
      FTP.Assign(Form1.Memo2.Lines);
      FTP.CustomSort(Sort);
      Form1.Memo1.Clear;
      Form1.Update;

      //Перевод цифр месяца в слова
      if Form1.Memo2.Lines[0]='01' then Form1.memo1.Lines.Add('January');
      if Form1.Memo2.Lines[1]='02' then Form1.memo1.Lines.Add('February');
      if Form1.Memo2.Lines[2]='03' then Form1.memo1.Lines.Add('March');
      if Form1.Memo2.Lines[3]='04' then Form1.memo1.Lines.Add('April');
      if Form1.Memo2.Lines[4]='05' then Form1.memo1.Lines.Add('May');
      if Form1.Memo2.Lines[5]='06' then Form1.memo1.Lines.Add('June');
      if Form1.Memo2.Lines[6]='07' then Form1.memo1.Lines.Add('July');
      if Form1.Memo2.Lines[7]='08' then Form1.memo1.Lines.Add('August');
      if Form1.Memo2.Lines[8]='09' then Form1.memo1.Lines.Add('September');
      if Form1.Memo2.Lines[9]='10' then Form1.memo1.Lines.Add('October');
      if Form1.Memo2.Lines[10]='11' then Form1.memo1.Lines.Add('November');
      if Form1.Memo2.Lines[11]='12' then Form1.memo1.Lines.Add('December');
      Form1.Update;

      //Год
      Form1.edit3.Text:=Form1.edit3.Text+(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-1]);//Перейти по последнему пункту из списка
      Form1.idFTP1.List(Form1.memo1.Lines,'',false);//Вывод списка папок
      Form1.idFTP1.List(ListBox1.Items,'',false);
      If checkbox6.Checked=false then //если авто включено
        begin
          Form1.idftp1.ChangeDir(Form1.edit3.text);     //Смена директории FTP
          Form1.idFTP1.List(Form1.memo1.Lines,'',false);//Вывод списка папок
          Form1.idFTP1.List(ListBox1.Items,'',false);
          Form1.Update;
        end
          else Exit;
      showmessage('ok');

      //Месяц
      Form1.edit3.Text:=Form1.edit3.Text+year+'/';//Добавить год и слеш
      Form1.idFTP1.List(Form1.memo1.Lines,'',false);//Вывод списка папок
      Form1.idFTP1.List(ListBox1.Items,'',false);
      If checkbox6.Checked=false then //если авто включено
        begin
          Form1.idftp1.ChangeDir(Form1.edit3.text);      //Смена директории FTP
          Form1.idFTP1.List(Form1.memo1.Lines,'',false); //Вывод списка папок
          Form1.idFTP1.List(ListBox1.Items,'',false);
          Form1.Update;
        end
          else Exit;
      showmessage('ok2');


      //Число
      Form1.edit3.Text:=Form1.edit3.Text+(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-1]+'/');//Перейти по последнему пункту из списка
      Form1.idFTP1.List(Form1.memo1.Lines,'',false);//Вывод списка папок
      Form1.idFTP1.List(ListBox1.Items,'',false);
      If checkbox6.Checked=false then //если авто включено
        begin
          Form1.idftp1.ChangeDir(Form1.edit3.text);      //Смена директории FTP
          Form1.idFTP1.List(Form1.memo1.Lines,'',false); //Вывод списка папок
          Form1.idFTP1.List(ListBox1.Items,'',false);
          Form1.Update;
        end
          else Exit;
//      showmessage('ok3');

      //Снимок
      Form1.edit3.Text:=Form1.edit3.Text+(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-1]+'/');//Перейти по последнему пункту из списка
      Form1.idFTP1.List(Form1.memo1.Lines,'',false);//Вывод списка папок
      Form1.idFTP1.List(ListBox1.Items,'',false);
      If checkbox6.Checked=false then //если авто включено
        begin
          Form1.idftp1.ChangeDir(Form1.edit3.text);      //Смена директории FTP
          Form1.idFTP1.List(Form1.memo1.Lines,'',false); //Вывод списка папок
          Form1.idFTP1.List(ListBox1.Items,'',false);
          Form1.Update;
        end
          else Exit;
      Form1.edit3.Text:=Form1.edit3.Text+(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-1]);//Перейти по последнему пункту из списка
 //     showmessage('ok4');

	  //Выбор и загрузка HD или обычного снимка
      if hd=true then Form1.idftp1.Get(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-1], GetWin('%AppData%')+'\img.jpg', true) //Скачивание
		else Form1.idftp1.Get(Form1.Memo1.Lines[Form1.Memo1.Lines.Count-2], GetWin('%AppData%')+'\img.jpg', true); //Скачивание

	  //Оповещение
	  Form1.Button1.Caption:='Установка изображения...';
    Form1.Update;

	  //Применение к рабочему столу
    SetWallpaper(Pchar(GetWin('%AppData%')+'\img.jpg'), False);

    //Оповещения об обновлении
    if Form1.checkbox2.Checked then Form1.CoolTrayIcon1.ShowBalloonHint('DeskChanger '+ver,IniFile.ReadString('LANG','DESKTOPUPATED','Обои обновлены '+#13+edit3.Text), bitinfo, 10);

    Form1.label4.Visible:=true;
//    Form1.label4.Caption:=(IniFile.ReadString('LANG','LASTUPDATED','Последнее обновление:')+' '+FormatDateTime('hh:mm',now));
//    Form1.CoolTrayIcon1.Hint:=('DeskChanger '+ver+ #13 +IniFile.ReadString('LANG','LASTUPDATE','Последнее обновление:')+' '+FormatDateTime('hh:mm',now));

	  Form1.idftp1.Disconnect;
    Form1.Button1.Caption:='Обновить';
    Form1.Button1.Enabled:=true;
    end;
  Except
    Form1.idftp1.Disconnect;
    Form1.label4.Caption:='Проверьте интернет соединение';
    Form1.CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, 'Ошибка резервного сервера', biterror, 10);
    exit;
  End;
  except
  end;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
var
  reg: TRegistry;
begin
if checkbox2.Checked=true then
  begin
    N2.Checked:=true;
    checkbox2.Checked:=true;
    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('DeskChanger', True);
    reg.WriteString('WallpaperStyle', '6');
    reg.Free;
  end
    else
      begin
        N2.Checked:=false;
        checkbox2.Checked:=false;
        reg:=TRegistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.OpenKey('DeskChanger', True);
        reg.DeleteValue('WallpaperStyle');
        reg.Free;
      end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
const
 Desktop: TGuid='{75048700-EF1F-11D0-9888-006097DEACF9}'; //для получения доступа к рабочему столу
var
  ActiveDeskTop:IActiveDesktop; //Активация рабочего стола
  reg: TRegIniFile;
  st: string;
begin
  if Form1.IdFTP1.Connected=false then
    begin
      idftp1.Host:='217.174.103.107';
      idftp1.Port:=21;
      idftp1.Username:='electro';
      idftp1.Password:='electro';
      idftp1.Connect(true, 30000);
      AssErt(idftp1.Connected);
    end;

  if pos('.jpg',edit3.Text)<>0 then
    begin
{
  Reg := TRegIniFile.Create('Control Panel');
  Reg.WriteString('desktop', 'Wallpaper', GetWin('%AppData%')+'\img');
  Reg.WriteString('desktop', 'TileWallpaper', '0');
  Reg.Free;
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDWININICHANGE);
}     showmessage('.jpg есть!');
      idftp1.Get(edit3.text, GetWin('%AppData%')+'\img', true);
      ActiveDesktop:=CreateComObject(Desktop) as IActiveDesktop; //создаем объект и получаем разрешение доступа к рабочему столу
      ActiveDesktop.SetWallpaper(StringToOleStr(GetWin('%AppData%')+'\img'), 0); // определились с выбором картинки
      ActiveDesktop.ApplyChanges(AD_APPLY_ALL); // применяем картинку на рабочем столе
    end
      else
        begin
          showmessage('.jpg не обнаружено!');
          edit3.Text:=(edit3.text+'/');
          st:=Edit3.Text+ListBox1.Items[ListBox1.ItemIndex];
          showmessage(st);
          Edit3.Text:=Edit3.Text+ListBox1.Items[ListBox1.ItemIndex]; //Выбранную строку в edit3
          idftp1.ChangeDir(st); //Смена директории FTP
          idFTP1.List(ListBox1.Items,'',false); //Вывод строк в ListBox
          Edit3.SetFocus;
        end;
        
  idftp1.Disconnect;
end;

end.

