
{******************************************}
{                                          }
{             FastReport VCL               }
{         Server templates support         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerTemplates;

{$I frx.inc}

interface

uses Classes, SysUtils, frxServerVariables, frxServerSSI,
    frxServerUtils, frxServerConfig;


type
  TfrxServerTemplate = class(TObject)
  private
    FVariables: TfrxServerVariables;
    FSSI: TfrxSSIStream;
    FTemplate: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Prepare;
    procedure SetTemplate(const Name: String);

    property TemplateStrings: TStringList read FTemplate;
    property Variables: TfrxServerVariables read FVariables;
  end;

implementation

const
  error403 = '<html><head><title>Forbidden</title></head><body><h1><b>ERROR 403</b><br>Forbidden</h1><h3><!--#echo var="ERROR"--></h3><body></html>';
  error404 = '<html><head><title>Not found</title></head><body><h1><b>ERROR 404</b><br>Not found</h1><h3><!--#echo var="ERROR"--></h3><body></html>';
  error500 = '<html><head><title>Internal error</title></head><body><h1><b>ERROR 500</b><br>Internal error</h1><h3><!--#echo var="ERROR"--></h3><body></html>';
  list_begin = '<table width="750" border="0" cellspacing="0" cellpadding="0">';
  list_header = '<tr><td bgcolor="#DDDDDD" colspan="2"><b><!--#echo var="HEADER"--></b></td></tr>';
  list_line = '<tr><td valign="top"><a href="result?report=<!--#echo var="FILE"-->" target=_blank><!--#echo var="NAME"--></a></td><td><!--#echo var="DESCRIPTION"--></td></tr>';
  list_end = '</table>';
  form_begin = '<html><head>' +
    '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">' +
    '<meta name="Generator" content="FastReport 5.0 http://www.fast-report.com">' +
    '<title><!--#echo var="TITLE"--></title></head>' +    '<body  bgcolor="#FFFFFF" text="#000000" <!--#echo var="HTML_INIT"-->>' +
    '<script>history.forward()</script>' +
    '<!--#echo var="HTML_CODE"-->' +
    '<table border="0" cellspacing="0" cellpadding="0" align="center">' +
    '<tr height="100%"><td width="100%" align="center" valign="middle">' +
    '<form method="get" action="result">' +
    '<input type="hidden" name="report" value="<!--#echo var="REPORT"-->">' +
    '<input type="hidden" name="pagenav" value="0">' +
    '<input type="hidden" name="multipage" value="0">' +
    '<input type="hidden" name="sessionid" value="<!--#echo var="SESSION"-->">' +
    '<table border="0" cellspacing="0" cellpadding="0" bgcolor="<!--#echo var="BCOLOR"-->" align="center" style="border: solid 1px #000000">' +
    '<tr height="20"><td style="font-family: Arial; font-weight: bold; font-size: 14px; color: #FFFFFF; background-color: #000080;" align="center" valign="middle" colspan="<!--#echo var="COLSPAN"-->"><!--#echo var="CAPTION"--></td></tr>';
  form_end = '<tr height="10"><td style="font-size:1px" colspan="<!--#echo var="COLSPAN"-->">&nbsp;</td></tr></table></form></td></tr></table></body></html>';
  form_checkbox = '<input type="checkbox" name="<!--#echo var="NAME"-->" value="<!--#echo var="NAME"-->" <!--#echo var="CHECKED"-->>' +
    '<font style="font-family: <!--#echo var="FONT_NAME"-->; font-size: <!--#echo var="FONT_SIZE"-->px;' +
    'color: <!--#echo var="FONT_COLOR"-->; background-color: <!--#echo var="BCOLOR"-->;"><!--#echo var="CAPTION"--></font>';
  form_label = '<font style="font-family: <!--#echo var="FONT_NAME"-->; font-size: <!--#echo var="FONT_SIZE"-->px; color: <!--#echo var="FONT_COLOR"-->; background-color: <!--#echo var="BCOLOR"-->;"><!--#echo var="CAPTION"--></font>';
  form_memo = '<textarea name="<!--#echo var="NAME"-->" rows="<!--#echo var="ROWS"-->" cols="<!--#echo var="COLS"-->" wrap="virtual"><!--#echo var="TEXT"--></textarea>';
  form_text = '<input type="<!--#echo var="VISIBLE"-->" name="<!--#echo var="NAME"-->" value="<!--#echo var="VALUE"-->" id="<!--#echo var="NAME"-->" size="<!--#echo var="SIZE"-->" maxlength="<!--#echo var="LENGTH"-->" <!--#echo var="READONLY"-->>';
  form_radio = '<input type="radio" name="<!--#echo var="NAME"-->" value="<!--#echo var="VALUE"-->" <!--#echo var="CHECKED"-->>' +
    '<font style="font-family: <!--#echo var="FONT_NAME"-->; font-size: <!--#echo var="FONT_SIZE"-->px; color: <!--#echo var="FONT_COLOR"-->; background-color: <!--#echo var="BCOLOR"-->;"><!--#echo var="CAPTION"--></font>';
  form_button = '<input type="submit" size="<!--#echo var="SIZE"-->" value="<!--#echo var="VALUE"-->">';
  form_select = '<select size="1" name="<!--#echo var="NAME"-->">';
  form_date = '<input type="<!--#echo var="VISIBLE"-->" name="<!--#echo var="NAME"-->" value="<!--#echo var="VALUE"-->" id="<!--#echo var="NAME"-->" size="<!--#echo var="SIZE"-->" maxlength="<!--#echo var="LENGTH"-->" <!--#echo var="READONLY"-->>';
  form_image  = '<img src="<!--#echo var="SRC"-->" width="<!--#echo var="WIDTH"-->" height="<!--#echo var="HEIGHT"-->">';
  main =
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">' +
    '<html><head>' +
    '<title><!--#echo var="TITLE"--></title>' +
    '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">' +
    '<script language="javascript" type="text/javascript"> var frCurPage = 1;</script></head>' +
    '<frameset rows="32,*" cols="*">' +
    '<frame name="topFrame" src="<!--#echo var="NAV_PAGE"-->" noresize scrolling="no">' +
    '<frame name="mainFrame" src="<!--#echo var="MAIN_PAGE"-->">' +
    '</frameset>' +
    '</html>';
  navigator =
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13#10 +
    '<html><head>'#13#10 +
    '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'#13#10 +
    '<meta name="Generator" content="FastReport 5.0 http://www.fast-report.com">'#13#10 +
    '<title></title><style type="text/css"><!--'#13#10 +
    'body { font-family: Tahoma; font-size: 8px; font-weight: bold; font-style: normal; text-align: center; vertical-align: middle; }'#13#10 +
    'input {text-align: center}'#13#10 +
    '.nav { font : 9pt Tahoma; color : #283e66; font-weight : bold; text-decoration : none;}'#13#10 +
    '--></style><script language="javascript" type="text/javascript"><!--'#13#10 +
    '  var frPgCnt = <!--#echo var="PGCNT"-->; var frRepName = "<!--#echo var="REPNAME"-->"; var frMultipage = <!--#echo var="MULTIPAGE"-->; var frPrefix="<!--#echo var="PREFIX"-->";'#13#10 +
    '  function DoPage(PgN) {'#13#10 +
    '    if ((PgN > 0) && (PgN <= frPgCnt) && (PgN != parent.frCurPage)) {'#13#10 +
    '      if (frMultipage > 0)  parent.mainFrame.location = frPrefix + PgN + ".html";'#13#10 +
    '      else parent.mainFrame.location = frPrefix + "main.html#PageN" + PgN;'#13#10 +
    '      UpdateNav(PgN); } else document.PgForm.PgEdit.value = parent.frCurPage; }'#13#10 +
    '  function UpdateNav(PgN) {'#13#10 +
    '    parent.frCurPage = PgN; document.PgForm.PgEdit.value = PgN;'#13#10 +
    '    if (PgN == 1) { document.PgForm.bFirst.disabled = 1; document.PgForm.bPrev.disabled = 1; }'#13#10 +
    '    else { document.PgForm.bFirst.disabled = 0; document.PgForm.bPrev.disabled = 0; }'#13#10 +
    '    if (PgN == frPgCnt) { document.PgForm.bNext.disabled = 1; document.PgForm.bLast.disabled = 1; }'#13#10 +
    '    else { document.PgForm.bNext.disabled = 0; document.PgForm.bLast.disabled = 0; } }'#13#10 +
    '  function RefreshRep() { parent.location = "result?report=" + frRepName + "&multipage=" + frMultipage; }'#13#10 +
    '  function ExportRep()'#13#10 +
    '  {'#13#10 +
    '    frExpFmt = document.PgForm.format.value;'#13#10 +
    '    parent.location = "result?report=" + frRepName + "&format=" + frExpFmt + "&cacheid=" + "<!--#echo var="SESSION"-->";'#13#10 +
    '  }'#13#10 +
    '--></script></head>'#13#10 +
    '<body bgcolor="#DDDDDD" text="#000000" leftmargin="0" topmargin="4" onload="UpdateNav(parent.frCurPage)">'#13#10 +
    '<form name="PgForm" onsubmit="DoPage(document.forms[0].PgEdit.value); return false;" action="">'#13#10 +
    '<table cellspacing="0" align="left" cellpadding="0" border="0" width="100%">'#13#10 +
    '<tr valign="middle">'#13#10 +
    '<td width="60" align="center"><button name="bFirst" class="nav" type="button" onclick="DoPage(1); return false;"><!--#echo var="L_FIRST"--></button></td>'#13#10 +
    '<td width="60" align="center"><button name="bPrev" class="nav" type="button" onclick="DoPage(Math.max(parent.frCurPage - 1, 1)); return false;"><!--#echo var="L_PREV"--></button></td>'#13#10 +
    '<td width="100" align="center"><input type="text" class="nav" name="PgEdit" value="parent.frCurPage" size="4"></td>'#13#10 +
    '<td width="60" align="center"><button name="bNext" class="nav" type="button" onclick="DoPage(parent.frCurPage + 1); return false;"><!--#echo var="L_NEXT"--></button></td>'#13#10 +
    '<td width="60" align="center"><button name="bLast" class="nav" type="button" onclick="DoPage(frPgCnt); return false;"><!--#echo var="L_LAST"--></button></td>'#13#10 +
    '<td width="20">&nbsp;</td>'#13#10 +
    '<td width="60" align="center"><button name="bRefresh" class="nav" type="button" onclick="RefreshRep(); return false;"><!--#echo var="L_REFRESH"--></button></td>'#13#10 +
    '<!--#echo var="BLOCK_PRINT"-->'#13#10 +
    '<td width="20">&nbsp;</td>'#13#10 +
    '<td width="40" align="center"><select class="nav" size="1" width="6" name="format"><!--#echo var="EXPORTS"--></select></td>'#13#10 +
    '<td width="60" align="left"><button name="bExport" class="nav" type="button" onclick="ExportRep(); return false;"><!--#echo var="L_EXPORT"--></button></td>'#13#10 +
    '<td align="right" class="nav"><!--#echo var="L_TOTAL"-->: <script language="javascript" type="text/javascript"> document.write(frPgCnt);</script></td>'#13#10 +
    '<td width="10">&nbsp;</td>'#13#10 +
    '</tr></table></form></body></html>';
  outline = '';
  report = '';
  print =
    '<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta name="Generator" content="FastReport 5.0 http://www.fast-report.com">' +
    '<title>Print dialog</title></head><body><table border="0" cellspacing="0" cellpadding="0" align="center">' +
    '<tr height="100%"><td width="100%" align="center" valign="middle"><form method="post" action="index.html">' +
    '<input type="hidden" name="cacheid" value="<!--#echo var="SESSION"-->"><input type="hidden" name="report" value="<!--#echo var="REPORT"-->">' +
    '<input type="hidden" name="prn" value="2"><table style="font-family: Arial; font-size: 12px; border: solid 1px #000000" border="0" width="600px" cellspacing="0" cellpadding="0" bgcolor="EEEEEE" align="center">' +
    '<tr height="20"><td style="font-weight: bold; color: #FFFFFF; background-color: #000080;" align="center" valign="middle" colspan="3">Print</td></tr>' +
    '<tr height="10"><td style="font-size:1px">&nbsp;</td></tr>' +
    '<tr><td size="20px">&nbsp;</td><td>' +
    '<p>Printer name &nbsp;<select size="1" width="20" name="printer"><!--#echo var="PRINTERS"--></select></p>' +
    '<p>Pages (enter page numbers and/or page ranges, example: 1,3,5-7) &nbsp;' +
    '<input type="text" name="pages" value="" size="25"></p>' +
    '<p>Number of copies &nbsp;<input type="text" size="6" name="copies" value="1"></p>' +
    '<p>Collate pages &nbsp;<input type="checkbox" name="collate" value="1" checked></p>' +
    '<p>Reverse order &nbsp;<input type="checkbox" name="reverse" value="1"></p></td>' +
    '<td size="20px">&nbsp;</td></tr><tr height="10"><td style="font-size:1px">&nbsp;</td></tr>' +
    '<tr><td align="center" colspan="3"><hr><input type="submit" value="Print">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
    '<input type="button" onclick="javascript: window.location=''index.html'';" value="Cancel"></td></tr>' +
    '<tr height="10"><td style="font-size:1px">&nbsp;</td></tr></table></form></td></tr></table></body></html>';
  nav_print =
    '  <script language="javascript" type="text/javascript">'#13#10 +
    '<!--'#13#10 +
    '  function PrintRep() { parent.location = "result?report=" + frRepName + "&prn=1&cacheid=" + "<!--#echo var="SESSION"-->"; }'#13#10 +
    '--></script>'#13#10 +
    '<td width="60" align="center"><button name="bPrint" class="nav" type="button" onclick="PrintRep(); return false;"><!--#echo var="L_PRINT"--></button></td>';

{ TfrxServerTemplate }

procedure TfrxServerTemplate.Clear;
begin
  FVariables.Clear;
  FSSI.Clear;
  FTemplate.Clear;
end;

constructor TfrxServerTemplate.Create;
begin
  FVariables := TfrxServerVariables.Create;
  FSSI := TfrxSSIStream.Create;
  FSSI.Variables := FVariables;
  FTemplate := TStringList.Create;
end;

destructor TfrxServerTemplate.Destroy;
begin
  FSSI.Free;
  FVariables.Free;
  FTemplate.Free;
  inherited;
end;

procedure TfrxServerTemplate.Prepare;
begin
  FSSI.Clear;
  FTemplate.SaveToStream(FSSI{$IFDEF DELPHI12}, TEncoding.UTF8{$ENDIF});
  FSSI.Prepare;
  FTemplate.Clear;
  FSSI.Position := 0;
  FTemplate.LoadFromStream(FSSI{$IFDEF DELPHI12}, TEncoding.UTF8{$ENDIF});
end;

procedure TfrxServerTemplate.SetTemplate(const Name: String);
var
  path: String;
begin
  path := frxGetAbsPathDir(ServerConfig.GetValue('server.http.templatespath'), ServerConfig.ConfigFolder) + name + '.html';
  if FileExists(path) then
    FTemplate.LoadFromFile(path{$IFDEF DELPHI12}, TEncoding.UTF8 {$ENDIF})
  else if name = 'error403' then
    FTemplate.Text := error403
  else if name = 'error404' then
    FTemplate.Text := error404
  else if name = 'error500' then
    FTemplate.Text := error500
  else if name = 'list_begin' then
    FTemplate.Text := list_begin
  else if name = 'list_header' then
    FTemplate.Text := list_header
  else if name = 'list_line' then
    FTemplate.Text := list_line
  else if name = 'list_end' then
    FTemplate.Text := list_end
  else if name = 'form_begin' then
    FTemplate.Text := form_begin
  else if name = 'form_button' then
    FTemplate.Text := form_button
  else if name = 'form_checkbox' then
    FTemplate.Text := form_checkbox
  else if name = 'form_end' then
    FTemplate.Text := form_end
  else if name = 'form_label' then
    FTemplate.Text := form_label
  else if name = 'form_memo' then
    FTemplate.Text := form_memo
  else if name = 'form_radio' then
    FTemplate.Text := form_radio
  else if name = 'form_select' then
    FTemplate.Text := form_select
  else if name = 'form_text' then
    FTemplate.Text := form_text
  else if name = 'form_date' then
    FTemplate.Text := form_date
  else if name = 'form_image' then
    FTemplate.Text := form_image
  else if name = 'main' then
    FTemplate.Text := main
  else if name = 'navigator' then
    FTemplate.Text := navigator
  else if name = 'nav_print' then
    FTemplate.Text := nav_print
  else if name = 'outline' then
    FTemplate.Text := outline
  else if name = 'report' then
    FTemplate.Text := report
  else if name = 'print' then
    FTemplate.Text := print;
end;

end.
